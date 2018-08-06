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
@property (strong, nonatomic) User* user;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;

@end
