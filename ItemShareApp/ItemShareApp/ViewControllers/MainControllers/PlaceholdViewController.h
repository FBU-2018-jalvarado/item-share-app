//
//  PlaceholdViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CatAndItemTableViewController.h"

@protocol PlaceholderViewControllerDelegate

- (void)dismissToMap: (BOOL)zoom;
- (void)showSearchView;
- (void)dismissKeyboard;
- (void)showHUD;
- (void)dismissHUD;

@end

@protocol PlaceHolderViewControllerDelegateMap

- (void)addAnnotationsInMap:(NSMutableArray*)filteredItemArray;
- (void)removeAnnotationsInMap;


@end

@interface PlaceholdViewController : UIViewController
@property (nonatomic, weak) id <PlaceholderViewControllerDelegate> placeholderDelegate;
@property (nonatomic, weak) id <PlaceHolderViewControllerDelegateMap> placeholderDelegateMap;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;
//@property (weak, nonatomic) IBOutlet UIImageView *downArrow;
@property CatAndItemTableViewController *catAndItemTableViewController;
//@property (weak, nonatomic) IBOutlet UIImageView *grayBar;
@property (weak, nonatomic) IBOutlet UIView *fetchView;
- (void)showSearch;
- (void)hideSearch;

@end
