//
//  PickUpPopUpController.h
//  item-share-app
//
//  Created by Nicolas Machado on 8/6/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "User.h"

@interface PickUpPopUpController : UIViewController

@property (strong, nonatomic) User *owner;
@property (strong, nonatomic) Item *item;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
