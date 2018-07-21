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

@interface CatAndItemTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *catAndItemTableView;
@property (strong, nonatomic) NSMutableArray *itemRows;
@property (strong, nonatomic) NSMutableArray *categoryRows;


@end

@implementation CatAndItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catAndItemTableView.delegate = self;
    self.catAndItemTableView.dataSource = self;
//    self.itemRows = [[NSMutableArray alloc] init];
//    self.categoryRows = [[NSMutableArray alloc] init];
    self.itemRows = [NSMutableArray arrayWithObjects:@"ione", @"itwo", @"ithree", @"ifour", @"ifive", nil];
    self.categoryRows = [NSMutableArray arrayWithObjects:@"cat1", @"cat2", @"cat3", nil];
    [self.catAndItemTableView reloadData];
    // Do any additional setup after loading the view.
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
            [cell setItem:self.itemRows[indexPath.row-self.categoryRows.count]];
            return cell;
        }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemRows.count + self.categoryRows.count;
}

@end
