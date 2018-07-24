//
//  SearchViewController.m
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "SearchViewController.h"
#import "ItemCell.h"
#import "Item.h"
#import "Parse.h"
#import "MapViewController.h"
#import "Category.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
@property (strong, nonatomic) NSArray *categoryArray;
@property (strong, nonatomic) NSMutableArray *filteredCategoryArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    //temporary until I can do search method
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.tableView.alpha = 0;
//    self.itemsArray = [NSMutableArray arrayWithObjects:@"item1", @"item2", @"item3", @"item4", @"item5", @"item6", @"item6", @"item7",  @"item8", @"item9", @"item10", nil];
//    self.filteredItemsArray = self.itemsArray;
//    [self postInfo];
    [self fetchItems];
    
    Category *category = [[Category alloc] init];
    [category setCats];
    self.categoryArray = category.catArray;
    self.filteredCategoryArray = [self.categoryArray mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.tableView.alpha = 1;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.tableView.alpha = 0;
}

// finds categories/items that contain the string of the searchText in them, with case, diacritic and space insensitivity
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
        // case and diacritic insensitivity
        NSPredicate *itemPredicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
            return [self inInsensitive:evaluatedObject.title withSearchText:searchText];
        }];
        NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:itemPredicate];
        self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
        
        // future code for filtering through categories
//        NSPredicate *catPredicate = [NSPredicate predicateWithBlock:^BOOL(ns *evaluatedObject, NSDictionary bindings) {
//            <#code#>
//        }]
    }
    else {
        self.filteredItemsArray = self.itemsArray;
        self.filteredCategoryArray = [self.categoryArray mutableCopy];
    }
    [self.tableView reloadData];
}

// function for determining if searchText is in evaluatedObject.title with all the insensitivities listed above
- (BOOL)inInsensitive:(NSString *)itemTitle withSearchText:(NSString *)searchText {
    NSString *spacelessItemTitle = [itemTitle stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *spacelessSearchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"spacelessItemTitle: %@", spacelessItemTitle);
    NSLog(@"spacelessSearchText: %@", spacelessSearchText);
    
    return [spacelessItemTitle rangeOfString:spacelessSearchText options:NSDiacriticInsensitiveSearch | NSCaseInsensitiveSearch].location != NSNotFound;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     MapViewController *mapViewController = [segue destinationViewController];
     ItemCell *tappedCell = sender;
     NSIndexPath *tappedIndexPath = [self.tableView indexPathForCell:tappedCell];
     Item *itemTapped = self.filteredItemsArray[tappedIndexPath.row];
    // mapViewController.item = itemTapped;
 }


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    Item *item = self.filteredItemsArray[indexPath.row];
    [cell setItem:item];
//    cell.item = item;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredItemsArray.count + self.filteredCategoryArray.count;
}

//- (void)postInfo{
//    PFUser *user = [PFUser currentUser];
//    [Item postItem:@"title4" withOwner:user withLocation:nil withAddress:@"address4" withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"error");
//        }
//        else{
//            NSLog(@"success");
//        }
//    }];
//}

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
                NSLog(@"SUCCESSFULLY RETREIVED ITEMS!");
                [self.tableView reloadData];
                
            }
        }
    }];
}

@end
