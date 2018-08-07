//
//  ProfileDetailViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import <CCTextFieldEffects/CCTextFieldEffects.h>
#import <CCTextFieldEffects/CCTextField.h>

@interface ProfileDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *tile1;
@property (weak, nonatomic) IBOutlet UIView *tile2;
@property (weak, nonatomic) IBOutlet UIView *tile3;
@property (weak, nonatomic) IBOutlet UIView *tile4;
@property (weak, nonatomic) IBOutlet UIView *tab1;
@property (weak, nonatomic) IBOutlet UIView *tab2;
@property (weak, nonatomic) IBOutlet UIView *tab3;

@property (strong,nonatomic) UIImage *cameraPicture;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

@end

#define BOTTOM_VIEW_HEIGHT 240

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // when text fields are edited, info is not stored in database
    // Do any additional setup after loading the view.
//    self.firstNameTextField.text = self.user.firstName;
//    self.lastNameTextField.text = self.user.lastName;
//    self.addressTextField.text = @"1 Hacker Way, Menlo Park, CA";
//    self.paymentTextField.text = @"Visa **** **** **** ****";
//    self.emailTextField.text = self.user.email;
//    self.phoneTextField.text = self.user.phoneNumber;
//    self.memberTextField.text = @"Yes";
    
    [self setUpUI];
}


- (void)viewDidAppear:(BOOL)animated{
    [self setUpUI];
    [self connectInfo];
}

- (void)connectInfo {
    self.firstNameLabel.text = self.user.firstName;
    self.lastNameLabel.text = self.user.lastName;
    self.addressLabel.text = @"1 Hacker Way, Menlo Park, CA";
    self.emailLabel.text = self.user.email;
    self.phoneLabel.text = self.user.phoneNumber;
}

- (void)setUpUI {
    
    //tiles
    self.tile1.backgroundColor = [UIColor orangeColor];
    self.tile1.layer.cornerRadius = 2;
    
    self.tile2.backgroundColor = [UIColor orangeColor];
    self.tile2.layer.cornerRadius = 2;
    
    self.tile3.backgroundColor = [UIColor orangeColor];
    self.tile3.layer.cornerRadius = 2;
    
    self.tile4.backgroundColor = [UIColor orangeColor];
    self.tile4.layer.cornerRadius = 2;
    
    //tabs
    self.tab1.backgroundColor = [UIColor whiteColor];
    self.tab2.backgroundColor = [UIColor whiteColor];
    self.tab3.backgroundColor = [UIColor whiteColor];
    
    self.backButton.layer.borderWidth = 1;
    self.backButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backButton.titleLabel.textColor = [UIColor whiteColor];
    self.backButton.layer.cornerRadius = 5;
    
    self.editProfileButton.layer.borderWidth = 1;
    self.editProfileButton.layer.borderColor = [UIColor orangeColor].CGColor;
    self.editProfileButton.titleLabel.textColor = [UIColor orangeColor];
    
    if(self.user[@"profile_image"] != nil){
        self.profilePicture.file = self.user[@"profile_image"];
        [self.profilePicture loadInBackground];
    }
    
    self.profilePicture.layer.cornerRadius = 55;
    self.profilePicture.clipsToBounds = YES;
    
    
    self.line6.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:.1f].CGColor;
}

//update user profile information
- (IBAction)doneButtonPressed:(id)sender {
    PFUser *user = [PFUser currentUser];
    if(self.cameraPicture != nil){
        user[@"profile_image"] = [self getPFFileFromImage:self.cameraPicture];
    }
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"success");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)pictureDone{
    PFUser *user = [PFUser currentUser];
    if(self.cameraPicture != nil){
        user[@"profile_image"] = [self getPFFileFromImage:self.cameraPicture];
    }
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"success");
            [self setUpUI];
        }
    }];
}

- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    // check if image is not nil
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
}

- (IBAction)choosePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)takePictureButtonPressed:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera not available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.cameraPicture = editedImage;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    self.cameraPicture = [self resizeImage:self.cameraPicture withSize:CGSizeMake(screenWidth, screenWidth)];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    [self pictureDone];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
