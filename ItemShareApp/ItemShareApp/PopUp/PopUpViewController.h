//
//  PopUpViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/25/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "User.h"

@protocol popUpDelegate

- (void)dismiss;
- (void)askedForDirections;

@end

@interface PopUpViewController : UIViewController

@property (nonatomic, weak) id <popUpDelegate> popUpDelegate;

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) User *owner;
@property (strong, nonatomic) Item *item;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;

@end
