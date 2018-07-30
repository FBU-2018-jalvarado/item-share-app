//
//  ProfileDetailViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ProfileDetailViewController.h"

@interface ProfileDetailViewController ()

@end

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstNameLabel.text = [NSString stringWithFormat:@"First Name: %@", self.user.firstName];
    self.lastNameLabel.text = [NSString stringWithFormat:@"Last Name: %@", self.user.lastName];
    self.emailLabel.text = [NSString stringWithFormat:@"Email: %@", self.user.email];
    self.numberLabel.text = [NSString stringWithFormat:@"Phone: %@", self.user.phoneNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
