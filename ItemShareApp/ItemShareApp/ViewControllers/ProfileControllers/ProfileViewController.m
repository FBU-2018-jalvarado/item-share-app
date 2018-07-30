//
//  ProfileViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/26/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileDetailViewController.h"
#import "ItemHistoryViewController.h"

@interface ProfileViewController () 

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSArray *profileCellArray;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileCellArray = @[@"Profile", @"Item History"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapProfileButto:(id)sender {
    [self performSegueWithIdentifier:@"ProfileDetail" sender:nil];
}
- (IBAction)didTapItemHistoryButton:(id)sender {
    [self performSegueWithIdentifier:@"ItemHistory" sender:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ProfileDetail"]){
        ProfileDetailViewController *next = [segue destinationViewController];
        next.user = (User *)[PFUser currentUser];
    }
    else if ([segue.identifier isEqualToString:@"ItemHistory"]){
        ItemHistoryViewController *next = [segue destinationViewController];
    }
}

@end
