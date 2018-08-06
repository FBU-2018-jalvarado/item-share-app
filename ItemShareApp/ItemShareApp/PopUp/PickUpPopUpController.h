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

@protocol pickUpPopUpDelegate

- (void)dismiss;
- (void)askedForDirections;

@end


@interface PickUpPopUpController : UIViewController

@property (nonatomic, weak) id <pickUpPopUpDelegate> pickUpPopUpDelegate;
@property (strong, nonatomic) User *owner;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSString *itemName;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
