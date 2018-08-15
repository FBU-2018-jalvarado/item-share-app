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
#import "QRPopUpController.h"
#import "ItemHistoryDetailViewController.h"
#import "ColorScheme.h"

@interface ProfileViewController () 

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePicture;
@property (strong, nonatomic) QRPopUpController * QRPopUpVC;
@property (weak, nonatomic) IBOutlet UIButton *itemsSelling;
@property (weak, nonatomic) IBOutlet UIButton *itemsBooked;
@property (weak, nonatomic) IBOutlet UIView *viewProfile;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (strong, nonatomic) NSArray *profileCellArray;
@property (strong, nonatomic) ColorScheme *colors;
@end

@implementation ProfileViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileCellArray = @[@"Profile", @"Item History"];
//    self.viewProfile.backgroundColor = self.colors.mainColor;
    User *user = (User *)[PFUser currentUser];
    if(user[@"profile_image"] != nil){
        self.profilePicture.file = user[@"profile_image"];
        [self.profilePicture loadInBackground];
    }
    self.profilePicture.layer.cornerRadius = 35;
    self.profilePicture.clipsToBounds = YES;
    self.firstNameLabel.text = [NSString stringWithFormat: @"%@", user.firstName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapProfileButto:(id)sender {
    [self performSegueWithIdentifier:@"ProfileDetail" sender:nil];
}
- (IBAction)didTapItemsSelling:(id)sender {
    [self performSegueWithIdentifier:@"ItemHistory" sender:self.itemsSelling];
}
- (IBAction)didTapItemsBooked:(id)sender {
    [self performSegueWithIdentifier:@"ItemHistory" sender:self.itemsBooked];
}

- (IBAction)confirmSellButtonPressed:(id)sender {
    [self postQRCode];
}

- (void)postQRCode {
    self.QRPopUpVC = [[QRPopUpController alloc] initWithNibName:@"QRPopUpController" bundle:nil];
    // self.QRPopUpVC.popUpDelegate = self;
    // [self.QRPopUpVC setName:self.item.title];
    Item *item = [Item new];
    item.title = @"baseball";
    [self.QRPopUpVC setItem:item];
    //[self.QRPopUpVC setOwner:self.item.owner];
    //[self.popUpVC setPhoneNumber:self.item.owner.phoneNumber];
    
    [self.QRPopUpVC showInView:self.view animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender){
        ItemHistoryDetailViewController *next = [segue destinationViewController];
        UIButton *button = sender;
        NSString *buttonTitle = button.titleLabel.text;
        next.buttonTitle = buttonTitle;
        if ([buttonTitle isEqualToString:@"Items Posted"]){
            next.historyType = @"itemsSelling";
        }
        else if ([buttonTitle isEqualToString:@"Items Booked"]){
            next.historyType = @"itemsFutureRent";
        }
    }
    
    else if ([segue.identifier isEqualToString:@"ProfileDetail"]){
        ProfileDetailViewController *next = [segue destinationViewController];
        next.user = (User *)[PFUser currentUser];
    }
}



@end
