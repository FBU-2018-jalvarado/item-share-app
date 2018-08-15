
//
//  SellItemViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SellItemViewControllerDelegate

- (void)fetchItems;

@end

@interface SellItemViewController : UIViewController

@property (nonatomic, weak) id <SellItemViewControllerDelegate> sellItemDelegate;

@end
