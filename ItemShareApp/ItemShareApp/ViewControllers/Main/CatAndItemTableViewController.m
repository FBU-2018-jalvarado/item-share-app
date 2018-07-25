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
//    self.itemRows = [[NSMutableArray alloc] init];
//    self.categoryRows = [[NSMutableArray alloc] init];
//    self.itemRows = [NSMutableArray arrayWithObjects:@"ione", @"itwo", @"ithree", @"ifour", @"ifive", @"isix", @"iseven", @"ieight", @"inine", @"iten", nil];
//    self.categoryRows = [NSMutableArray arrayWithObjects:@"cat1", @"cat2", @"cat3", nil];
    [self.catAndItemTableView reloadData];
    // Do any additional setup after loading the view.
}
//- (IBAction)scrollToDismissKeyboard:(id)sender {
//    [self.view endEditing:YES];
//}
//- (IBAction)scrollDownToDismissKeyboard:(id)sender {
//    [self.view endEditing:YES];
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate callPrevVCtoDismissKeyboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        if (indexPath.row < self.categoryRows.count) {
            CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategorySearchCell"];
            [cell setCategory:self.categoryRows[indexPath.row]];
            return cell;
        }
        else {
            ItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemSearchCell"];
            [cell setItem:self.itemRows[indexPath.row-self.categoryRows.count][@"title"]];
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
        NSString *categoryName = self.categoryRows[indexPath.row];
        self.categoryRows = [[NSMutableArray alloc] init];
        [self filterForCat:categoryName];
    }
    // if its an item cell
    else {
        // grab the item
        Item *selectedItem = self.itemRows[indexPath.row - self.categoryRows.count];
        // pass it to the map view and dismiss the search view
    }
}

// filter the whole items array for only items within given category
- (void)filterForCat:(NSString *)categoryName {
    [self.delegate fetchItems];
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

@end
