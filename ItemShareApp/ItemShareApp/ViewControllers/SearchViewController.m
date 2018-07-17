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
#import "User.h"
#import "Parse.h"

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *filteredItemsArray;
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
    self.itemsArray = [NSMutableArray arrayWithObjects:@"item1", @"item2", @"item3", @"item4", @"item5", @"item6", @"item6", @"item7",  @"item8", @"item9", @"item10", nil];
    self.filteredItemsArray = self.itemsArray;
    [self postInfo];
    [self fetchItems];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length != 0) {
       // commented out because need to pull model class to implement these lines of code. Commmiting to pull.
                NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Item *evaluatedObject, NSDictionary *bindings) {
                    return [evaluatedObject.title containsString:searchText];
                }];
                NSArray *temp = [self.itemsArray filteredArrayUsingPredicate:predicate];
                self.filteredItemsArray = [NSMutableArray arrayWithArray:temp];
    }
    else {
        self.filteredItemsArray = self.itemsArray;
    }
    [self.tableView reloadData];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    Item *item = self.filteredItemsArray[indexPath.row];
    
    
    [cell setItem:self.filteredItemsArray[indexPath.row]];
    cell.item = self.filteredItemsArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredItemsArray.count;
}

- (void)postInfo{
    PFUser *user = [PFUser currentUser];
    [Item postItem:@"title1" withOwner:user withLocation:nil withAddress:@"address1" withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"error");
        }
        else{
            NSLog(@"success");
            
        }
    }];
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
                NSLog(@"SUCCESSFULLY RETREIVED ITEMS!");
                [self.tableView reloadData];
                
            }
        }
    }];
}

@end
