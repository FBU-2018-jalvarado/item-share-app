//
//  CatAndItemTableViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CatAndItemTableViewController.h"
#import "CategoryTableCell.h"
#import "ItemTableCell.h"
#import "Item.h"


@interface CatAndItemTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation CatAndItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catAndItemTableView.delegate = self;
    self.catAndItemTableView.dataSource = self;

    [self.catAndItemTableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate callPrevVCtoDismissKeyboard];
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
    if([segue.identifier isEqualToString:@"CategoryCollSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        CategoriesViewController *categoriesViewController = [navVC.viewControllers firstObject];
        categoriesViewController.firstPage = YES;
        categoriesViewController.title = @"Categories";
        categoriesViewController.delegate = self.delegate;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        if (indexPath.row < self.categoryRows.count) {
            CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategorySearchCell"];
            [cell setCategory:self.categoryRows[indexPath.row]];
            return cell;
        }
        else {
            ItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemSearchCell"];
            [cell setItem:self.itemRows[indexPath.row-self.categoryRows.count][@"title"] withAddress:self.itemRows[indexPath.row-self.categoryRows.count][@"address"]];
            return cell;
        }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemRows.count + self.categoryRows.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // if its a category cell
    if(indexPath.row < self.categoryRows.count)
    {
        // empty the category array and populate the items with ones w that have  category
        [self choseCat:self.categoryRows[indexPath.row]];
    }
    // if its an item cell
    else {
        // grab the item
        Item *selectedItem = self.itemRows[indexPath.row - self.categoryRows.count];
        // pass it to the map view
        NSMutableArray *theOneItemArray = [[NSMutableArray alloc] init];
        [theOneItemArray addObject:selectedItem];
        [self.delegate filterInMap:theOneItemArray];
        // dismiss the search view
        [self.delegate goToMap];
    }
}

// category table cells disappear and item cells get filtered
- (void)choseCat:(NSString *)categoryName {
    self.categoryRows = [[NSMutableArray alloc] init];
    [self filterForCat:categoryName];
    [self.delegate clearSearchBar];
    
    // now fetchItemsWithCat will filter in the completion block
}

// filter the whole items array for only items within given category
- (void)filterForCat:(NSString *)categoryName {
    [self fetchItemsWithCat:categoryName];
    // now fetchItemsWithCat will filter in the completion block
}

// determine if item is of type "categoryName"
- (BOOL)hasCat:(Item *)thisItem catName:(NSString *)categoryName{
    for(NSString *category in thisItem.categories)
    {
        if([category isEqualToString:categoryName])
        {
            return YES;
        }
    }
    return NO;
}

- (void)fetchItemsWithCat:(NSString *)categoryName {
    
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
            NSLog(@"ERROR GETTING FULL LIST OF ITEMS!");
        }
        else {
            if (items) {
                self.itemRows = [[NSMutableArray alloc] init];
                for(Item *newItem in items)
                {
                    [self.itemRows addObject:newItem];
                }
                NSLog(@"SUCCESSFULLY GRABBED FULL LIST OF ITEMS!");
                NSMutableArray *itemsInCategory = [[NSMutableArray alloc] init];
                for(Item *thisItem in self.itemRows)
                {
                    if([self hasCat:thisItem catName:categoryName])
                    {
                        [itemsInCategory addObject:thisItem];
                    }
                }
                self.itemRows = itemsInCategory;
                [self.catAndItemTableView reloadData];
                [self.delegate filterInMap:self.itemRows];
            }
        }
    }];
}
@end
