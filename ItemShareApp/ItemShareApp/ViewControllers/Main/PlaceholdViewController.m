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
#import "SearchViewController.h"
#import "ItemCell.h"
#import "Item.h"
#import "Parse.h"
#import "MapViewController.h"

@interface PlaceholdViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UIView *categoryCollV;
@property (weak, nonatomic) IBOutlet UIView *catAndItemTableV;
@property CatAndItemTableViewController *catAndItemTableViewController;
@property CategoriesViewController *categoryCollectionView;
//from SearchBar
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *filteredCategoryArray;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@end

@implementation PlaceholdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // from SearchBar
    self.searchBar.delegate = self;
    //self.catAndItemTableViewController.catAndItemTableView.alpha = 0;
    self.categoryArray = [NSMutableArray arrayWithObjects:@"cat1", @"cat12", @"cat123", @"cat123", @"cat1234", @"bananacat1234", nil];
    self.catAndItemTableViewController.categoryRows = [[NSMutableArray alloc] init];
    self.catAndItemTableViewController.categoryRows = self.categoryArray;
    
    [self fetchItems];
    // Do any additional setup after loading the view.
}

- (IBAction)onTapMap:(id)sender {
//    [self performSegueWithIdentifier:@"MapSegue" sender:sender];
    //[self dismissViewControllerAnimated:true completion:nil];
    [self.placeholderDelegate dismissToMap];
}

- (void)goToMap {
//    [self performSegueWithIdentifier:@"MapSegue" sender:nil];
    //[self dismissViewControllerAnimated:true completion:nil];
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
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    //self.catAndItemTableViewController.catAndItemTableView.alpha = 0;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        /*
         if (searchText.length != 0) {
         NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
         return [evaluatedObject.title rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound;
         }];
         NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
         self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
         }
         else {
         self.filteredItemsArray = self.itemsArray;
         }
         [self addAnnotations:self.mapView withArray:self.filteredItemsArray];
         [self removeAllPinsButUserLocation];
         */
        
        //UI
        self.categoryCollV.frame = CGRectMake(self.categoryCollV.frame.origin.x, self.categoryCollV.frame.origin.y, self.categoryCollV.frame.size.width, 0);
        self.categoryCollV.alpha = 0;
        if(self.catAndItemTableV.frame.origin.y == 200)
        {
            self.catAndItemTableV.frame = CGRectMake(self.catAndItemTableV.frame.origin.x, self.catAndItemTableV.frame.origin.y - 146, self.catAndItemTableV.frame.size.width, self.catAndItemTableV.frame.size.height + 146);
        }

        
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
//        NSArray *tempCat = [self.catAndItemTableViewController.categoryRows filteredArrayUsingPredicate:predicateCat];
        NSArray *tempCat = [self.categoryArray filteredArrayUsingPredicate:predicateCat];
        self.filteredCategoryArray = [NSMutableArray arrayWithArray:tempCat];
    }
    // there is nothing in search bar and category cells reappear
    else {
        //UI
        self.categoryCollV.frame = CGRectMake(self.categoryCollV.frame.origin.x, self.categoryCollV.frame.origin.y, self.categoryCollV.frame.size.width, 146);
        self.categoryCollV.alpha = 1;
        // along w all items and categories in the table view
        self.filteredItemsArray = self.itemsArray;
        self.filteredCategoryArray = self.categoryArray;
        if(self.catAndItemTableV.frame.origin.y == 54)
        {
            self.catAndItemTableV.frame = CGRectMake(self.catAndItemTableV.frame.origin.x, self.catAndItemTableV.frame.origin.y + 146, self.catAndItemTableV.frame.size.width, self.catAndItemTableV.frame.size.height - 146);
        }
    }
    
    //filter pins
    [self.placeholderDelegateMap addAnnotationsInMap:self.filteredItemsArray];
    [self.placeholderDelegateMap removeAnnotationsInMap];
    
    self.catAndItemTableViewController.itemRows = self.filteredItemsArray;
    self.catAndItemTableViewController.categoryRows = self.filteredCategoryArray;
    
    [self.catAndItemTableViewController.catAndItemTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"CategoryCollectionSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        CategoriesViewController *categoriesViewController = navVC.viewControllers[0];
        categoriesViewController.firstPage = YES;
        categoriesViewController.title = @"Categories";
        categoriesViewController.delegate = self;
    }
    if([segue.identifier isEqualToString:@"catAndItemTableSegue"])
    {
        self.catAndItemTableViewController = [segue destinationViewController];
    }
    if([segue.identifier isEqualToString:@"CategoryCollectionSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        self.categoryCollectionView = [navVC.viewControllers firstObject];
        // self.categoryCollectionView = [segue destinationViewController];
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

@end
