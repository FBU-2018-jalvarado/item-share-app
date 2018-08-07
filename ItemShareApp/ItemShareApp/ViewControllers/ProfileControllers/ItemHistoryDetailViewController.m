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
#import "QRPopUpController.h"

@interface ItemHistoryDetailViewController () <UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) QRPopUpController * QRPopUpVC;
@property (strong, nonatomic) NSMutableArray *itemsIdArray;

@end

@implementation ItemHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemsIdArray = [[NSMutableArray alloc] init];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    self.titleLabel.text = self.buttonTitle;
    [self getItemsIdArray];
    [self fetchItemsByIds:self.itemsIdArray];
    
    
//    [self fetchUserItemsWithCompletion:(User *)[PFUser currentUser] withCompletion:^(NSArray<User *> *items, NSError *error) {
//        if (error) {
//            NSLog(@"Error fetching objects: %@", error);
//        }
//        else {
//            self.itemsArray = [items mutableCopy];
//            [self.tableview reloadData];
//        }
//    }];
//
//    self.tableview.rowHeight = UITableViewAutomaticDimension;
}

-(void) getItemsIdArray {
    NSMutableArray *itemsPointerArr = [PFUser currentUser][[NSString stringWithFormat:@"%@", self.historyType]];
    Item *item = [[Item alloc] init];
    for (int i = 0; i < [itemsPointerArr count]; i++) {
        item = itemsPointerArr[i];
        [self.itemsIdArray addObject:item.objectId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// fetch items by id
-(void) fetchItemsByIds:(NSArray<NSString *> *)idArray {
    self.itemsArray = [[NSMutableArray alloc] init];

    for (NSString *itemID in idArray) {
//        PFQuery *itemQuery = [Item query];
        [[Item query] getObjectInBackgroundWithId:itemID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error finding object with itemID %@: %@", itemID, error);
            }
            else if (object){
                [self.itemsArray addObject:object];
                if (self.itemsArray.count == self.itemsIdArray.count){
                    [self.tableview reloadData];
                }
            }
        }];
    }
}

// only fetches items selling
- (void)fetchUserItemsWithCompletion:(User *)user withCompletion:(void(^)(NSArray<User *> *items, NSError *error))completion {
    if (user){
        PFQuery *itemQuery = [Item query];
        [itemQuery orderByDescending:@"createdAt"];
        [itemQuery includeKey:@"title"];
        [itemQuery includeKey:@"location"];
        [itemQuery includeKey:@"owner"];
        [itemQuery includeKey:@"address"];
        [itemQuery includeKey:@"images"];
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
                          [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"qrcoderealrealrealreal"] backgroundColor:[UIColor colorWithRed:(211/255) green:(211/255) blue:(211/255) alpha:.2]]];
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
        [self postQRCode:self.itemsArray[path.row]];
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

- (void)postQRCode: (Item *)item {
    self.QRPopUpVC = [[QRPopUpController alloc] initWithNibName:@"QRPopUpController" bundle:nil];
    // self.QRPopUpVC.popUpDelegate = self;
    // [self.QRPopUpVC setName:self.item.title];
    [self.QRPopUpVC setItem:item];
    [self.QRPopUpVC setOwner:item.owner];
    //[self.popUpVC setPhoneNumber:self.item.owner.phoneNumber];
    
    [self.QRPopUpVC showInView:self.view animated:YES];
}

@end
