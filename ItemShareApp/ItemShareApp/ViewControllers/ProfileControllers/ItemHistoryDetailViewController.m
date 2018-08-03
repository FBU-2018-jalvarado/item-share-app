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

@interface ItemHistoryDetailViewController () <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) NSMutableArray *itemsIdArray;
@property (strong, nonatomic) NSDictionary *itemsIdDictionary;
@property (strong, nonatomic) NSString *objectId;
@end

@implementation ItemHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.titleLabel.text = self.buttonTitle;

    //
    self.itemsIdArray = [PFUser currentUser][[NSString stringWithFormat:@"%@", self.historyType]];
    NSLog(@"%@", self.itemsIdArray);
    self.itemsIdDictionary = self.itemsIdArray[0];
    NSLog(@"%@", self.itemsIdDictionary);
    self.objectId = self.itemsIdDictionary[@"objectId"];
    [self fetchUserItemsWithCompletion:(User *)[PFUser currentUser] withCompletion:^(NSArray<User *> *items, NSError *error) {
        if (error) {
            NSLog(@"Error fetching objects: %@", error);
        }
        else {
            self.itemsArray = [items mutableCopy];
            [self.tableview reloadData];
        }
    }];
    
    self.tableview.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// fetch items by id
-(void) fetchItemsByIdsWithCompletion:(NSArray<NSString *> *)idArray withCompletion:(void(^)(NSArray<User *> *items, NSError *error))completion {
    
    for (NSString *itemID in idArray) {
        [[Item query] getObjectInBackgroundWithId:itemID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            //
        }];
    }
    
     
}

// fetches items selling
- (void)fetchUserItemsWithCompletion:(User *)user withCompletion:(void(^)(NSArray<User *> *items, NSError *error))completion {
    if (user){
        PFQuery *itemQuery = [Item query];
        [itemQuery orderByDescending:@"createdAt"];
        [itemQuery includeKey:@"title"];
        [itemQuery includeKey:@"location"];
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
    cell.delegate = self;
    Item *item = self.itemsArray[indexPath.row];
//    NSString *itemTitle = item.title;
    cell.item = item;
    
    // basic swipe config
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"bin"] backgroundColor:[UIColor redColor]],
                          [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"more"] backgroundColor:[UIColor grayColor]]];
    cell.rightSwipeSettings.transition = MGSwipeTransition3D;
    
    // expansion config
    cell.rightExpansion.buttonIndex = 0;
    cell.rightExpansion.fillOnTrigger = YES;
    cell.rightExpansion.threshold = 1.5;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion {
    
    NSIndexPath * path = [_tableview indexPathForCell:cell];
    
    // trash button
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        // remove item from Parse
        MGItemHistoryCell *histCell = [self.tableview cellForRowAtIndexPath:path];
        [self removeObjectFromDatabase:histCell.item];
        // remove item from table
        [self.itemsArray removeObjectAtIndex:path.row];
        [_tableview deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }
    // more button
    else if (direction == MGSwipeDirectionRightToLeft && index == 1) {
        // TO DO: make popup appear with more options/perform segue to detailed view
    }
    return YES;
}

- (void) removeObjectFromDatabase: (Item *) item {
    [item deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to delete item: %@", error);
        }
        else {
            NSLog(@"Successfully deleted item!");
        }
    }];
}

@end
