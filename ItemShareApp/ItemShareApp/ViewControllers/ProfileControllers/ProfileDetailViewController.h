//
//  ProfileDetailViewController.h
//  item-share-app
//
//  Created by Tarini Singh on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <ParseUI/ParseUI.h>
#import "Parse.h"

@interface ProfileDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) User* user;

@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;

@end
