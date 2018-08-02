//
//  CatAndItemTableViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesViewController.h"

@protocol CatAndItemTableViewControllerDelegate

-(void)callPrevVCtoDismissKeyboard;
-(void)fetchItems;
-(void)goToMap;
-(void)clearSearchBar;
-(void)filterInMap:(NSMutableArray *)listOfItems;
-(void)dismissHUD;

@end

@interface CatAndItemTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *categoryCollView;
@property (weak, nonatomic) IBOutlet UITableView *catAndItemTableView;
@property (strong, nonatomic) NSMutableArray *itemRows;
@property (strong, nonatomic) NSMutableArray *categoryRows;
@property CategoriesViewController *categoriesViewController;
@property (nonatomic, weak) id <CatAndItemTableViewControllerDelegate> delegate;
- (void)choseCat:(NSString *)categoryName;

@end
