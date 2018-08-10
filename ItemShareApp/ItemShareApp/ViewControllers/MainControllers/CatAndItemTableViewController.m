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
#import "UIScrollView+EmptyDataSet.h"
#import "ColorScheme.h"
#import "Category.h"
//#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>



@interface CatAndItemTableViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) ColorScheme *colors;
@property (strong, nonatomic) NSArray *lastCats;
@end

@implementation CatAndItemTableViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    Category *cat = [[Category alloc] init];
    [cat setCats];
    self.lastCats = cat.lastLevel;
    self.catAndItemTableView.delegate = self;
    self.catAndItemTableView.dataSource = self;
    self.catAndItemTableView.emptyDataSetSource = self;
    self.catAndItemTableView.emptyDataSetDelegate = self;
    
    self.catAndItemTableView.rowHeight = UITableViewAutomaticDimension;

    //remove cell separators
    self.catAndItemTableView.tableFooterView = [UIView new];
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

//empty table view implementation

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 150;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"orange_f"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString* text = @"No items available to rent";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return  [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Please return to your search to find other items categories. Thanks!";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//either this or image for button
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:@"Back to Search" attributes:attributes];
}

//- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    return [UIImage imageNamed:@"orange_f"];
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIColor whiteColor];
}

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView {
    return YES;
}


- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
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
        categoriesViewController.title = @"What are you looking for?";
        categoriesViewController.delegate = self.delegate;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(indexPath.row < self.categoryRows.count){
        CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategorySearchCell"];
        [cell setCategory:self.categoryRows[indexPath.row]];
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = self.colors.mainColor;
        cell.selectedBackgroundView = selectionColor;
        return cell;
    }
        else {
            ItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemSearchCell"];
            [cell setItem:self.itemRows[indexPath.row-self.categoryRows.count]];
            UIView *selectionColor = [[UIView alloc] init];
            selectionColor.backgroundColor = self.colors.mainColor;
            cell.selectedBackgroundView = selectionColor;
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
        [self.delegate goToMap:YES];
    }
    // if its an item cell
    else {
        // grab the item
        Item *selectedItem = self.itemRows[indexPath.row - self.categoryRows.count];
        // pass it to the map view
        NSMutableArray *theOneItemArray = [[NSMutableArray alloc] init];
        [theOneItemArray addObject:selectedItem];
        [self.delegate filterInMap:theOneItemArray];
        [self.catAndItemTableView deselectRowAtIndexPath:indexPath animated:YES];
        // dismiss the search view
        [self.delegate goToMap:NO];
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
            [self.delegate dismissHUD];
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
                [self.delegate dismissHUD];
            }
        }
    }];
}
@end
