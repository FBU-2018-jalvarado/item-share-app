//
//  PlaceholdViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PlaceholdViewController.h"
#import "CategoriesViewController.h"
#import "CatAndItemTableViewController.h"
//from SearchBar
#import "ItemCell.h"
#import "Item.h"
#import "Parse.h"
#import "MapViewController.h"
#import "Category.h"

@interface PlaceholdViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *categoryCollV;
@property (weak, nonatomic) IBOutlet UIView *catAndItemTableV;
@property CatAndItemTableViewController *catAndItemTableViewController;
@property CategoriesViewController *categoryCollectionView;
//from SearchBar
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
@property (strong, nonatomic) NSMutableArray *filteredCategoryArray;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@end

@implementation PlaceholdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // from SearchBar
    self.searchBar.delegate = self;
    self.categoryArray = [[NSMutableArray alloc] init];
    Category *category = [[Category alloc] init];
    [category setCats];
    self.categoryArray = category.catArray;
    
    [self fetchItems];
    // Do any additional setup after loading the view.
}

- (IBAction)onTapMap:(id)sender {
    [self.placeholderDelegate dismissToMap];
}

- (void)goToMap {
    [self.placeholderDelegate dismissToMap];
}
 // from SearchBar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self.placeholderDelegate dismissToMap];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.catAndItemTableViewController.catAndItemTableView.alpha = 1;
    [self.placeholderDelegate showSearchView];
    [self filterInMap:self.catAndItemTableViewController.itemRows];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //self.catAndItemTableViewController.catAndItemTableView.alpha = 0;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        //UI
        [self startTypingFormat];

        // filter the items array
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
        self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];

        // filter the categories array
        NSPredicate *predicateCat = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedCategory, NSDictionary *bindings) {
            return [evaluatedCategory rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
        }];
        NSArray *tempCat = [self.categoryArray filteredArrayUsingPredicate:predicateCat];
        self.filteredCategoryArray = [NSMutableArray arrayWithArray:tempCat];
    }
    // there is nothing in search bar and category cells reappear
    else {
        //UI
        [self emptyTextBarFormat];
        
        // along w all items and categories in the table view
        
        self.filteredItemsArray = self.itemsArray;
//        self.filteredCategoryArray = self.categoryArray;
        self.filteredCategoryArray = @[];
    }
    
    //filter pins
    [self.placeholderDelegateMap removeAnnotationsInMap];
    [self.placeholderDelegateMap addAnnotationsInMap:self.filteredItemsArray];
    
    
    self.catAndItemTableViewController.itemRows = self.filteredItemsArray;
    self.catAndItemTableViewController.categoryRows = self.filteredCategoryArray;
    
    [self.catAndItemTableViewController.catAndItemTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)emptyTextBarFormat {
    // make the category collection view reappear
    self.catAndItemTableViewController.categoryCollView.frame = CGRectMake(self.catAndItemTableViewController.categoryCollView.frame.origin.x, self.catAndItemTableViewController.categoryCollView.frame.origin.y, self.catAndItemTableViewController.categoryCollView.frame.size.width, 146);
    self.catAndItemTableViewController.categoryCollView.alpha = 1;
}

- (void)startTypingFormat {
    // make the category collection view disappear
    self.catAndItemTableViewController.categoryCollView.frame = CGRectMake(self.catAndItemTableViewController.categoryCollView.frame.origin.x, self.catAndItemTableViewController.categoryCollView.frame.origin.y, self.catAndItemTableViewController.categoryCollView.frame.size.width, 0);
    self.catAndItemTableViewController.categoryCollView.alpha = 0;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"CategoryCollectionSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        CategoriesViewController *categoriesViewController = [navVC.viewControllers firstObject];
        categoriesViewController.firstPage = YES;
        categoriesViewController.title = @"Categories";
        categoriesViewController.delegate = self;
    }
    if([segue.identifier isEqualToString:@"catAndItemTableSegue"])
    {
        self.catAndItemTableViewController = [segue destinationViewController];
        self.catAndItemTableViewController.delegate = self;
    }
}


- (void)fetchItems {
    
    PFQuery *itemQuery = [Item query];
    //PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery orderByDescending:@"createdAt"];
    [itemQuery includeKey:@"location"];
    [itemQuery includeKey:@"title"];
    [itemQuery includeKey:@"owner"];
    [itemQuery includeKey:@"address"];
    //    postQuery.limit = 20;
    
    // fetch data asynchronously
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray<Item *> * _Nullable items, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"ERROR GETTING THE ITEMS!");
        }
        else {
            if (items) {
                self.itemsArray = [[NSMutableArray alloc] init];
                for(Item *newItem in items)
                {
                    [self.itemsArray addObject:newItem];
                }
                // self.itemsArray = [self.itemsArray arrayByAddingObjectsFromArray:items];
                //self.itemsArray = items;
                self.filteredItemsArray = self.itemsArray;
                self.catAndItemTableViewController.itemRows = [[NSMutableArray alloc] init];
                self.catAndItemTableViewController.itemRows = self.itemsArray;
                NSLog(@"SUCCESSFULLY RETREIVED ITEMS!");
                [self.catAndItemTableViewController.catAndItemTableView reloadData];
                
            }
        }
    }];
}

// delegate function to dismiss keyboard from previous view controller
-(void)callPrevVCtoDismissKeyboard {
    [self.placeholderDelegate dismissKeyboard];
}

// delegate function to clear search bar text
-(void)clearSearchBar {
    self.searchBar.text = @"";
}

// delegate function to react when a category is chosen
-(void)callChoseCat:(NSString *)categoryName {
    [self.catAndItemTableViewController choseCat:categoryName];
}

// delegate function to only display filtered items in map
- (void)filterInMap:(NSMutableArray *)listOfItems {
    [self.placeholderDelegateMap removeAnnotationsInMap];
    [self.placeholderDelegateMap addAnnotationsInMap:listOfItems];
}

@end
