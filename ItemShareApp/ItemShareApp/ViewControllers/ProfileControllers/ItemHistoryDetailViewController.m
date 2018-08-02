//
//  ItemHistoryDetailViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/30/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ItemHistoryDetailViewController.h"
#import "MGItemHistoryCell.h"
#import "Item.h"
#import "User.h"

@interface ItemHistoryDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation ItemHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.titleLabel.text = self.buttonTitle;
//    self.itemsArray = [PFUser currentUser][[NSString stringWithFormat:@"%@", self.historyType]];
    [self fetchUserItemsWithCompletion:(User *)[PFUser currentUser] withCompletion:^(NSArray<User *> *items, NSError *error) {
        if (error) {
            NSLog(@"Error fetching objects: %@", error);
        }
        else {
            self.itemsArray = items;
            [self.tableview reloadData];
        }
    }];
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// fetches items selling
- (void)fetchUserItemsWithCompletion:(User *)user withCompletion:(void(^)(NSArray<User *> *items, NSError *error))completion {
    if (user){
        PFQuery *itemQuery = [Item query];
        [itemQuery orderByDescending:@"createdAt"];
        [itemQuery includeKey:@"title"];
        [itemQuery includeKey:@"location"];
        [itemQuery includeKey:@"title"];
        [itemQuery includeKey:@"owner"];
        [itemQuery includeKey:@"address"];
        itemQuery.limit = 20;
        
        [itemQuery whereKey:@"owner" equalTo:user];
        
        [itemQuery findObjectsInBackgroundWithBlock:^(NSArray<User *> * _Nullable items, NSError * _Nullable error) {
            if(error != nil)
            {
                NSLog(@"Error finding objects: %@", error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(items, nil);
                });
            }
        }];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    MGItemHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historyCell"];
    Item *item = self.itemsArray[indexPath.row];
//    NSString *itemTitle = item.title;
    cell.item = item;
    
    // swipe config
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"bin"] backgroundColor:[UIColor redColor]]];
    cell.leftSwipeSettings.transition = MGSwipeTransition3D;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

@end
