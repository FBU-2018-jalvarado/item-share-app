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
#import "ColorScheme.h"

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
@property (weak, nonatomic) IBOutlet UIView *realView;
@property (strong,nonatomic) UIImage *cameraPicture;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) SaeTextField *saeAddressTextField;
@property (strong, nonatomic) ColorScheme *colors;

@end

#define BOTTOM_VIEW_HEIGHT 240

@implementation ProfileDetailViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

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
    [self connectInfo];
    [self setUpAddressTextField];
}

- (void) setUpAddressTextField {
    // Recommended frame height is around 70.
    // Frame width should be shorter than other tpyes of text field.
    self.saeAddressTextField = [[SaeTextField alloc] initWithFrame:CGRectMake(104, 372, 225, 70)];
    self.saeAddressTextField.placeholder = @"ht";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.8
    self.saeAddressTextField.placeholderFontScale = 0.8;
    
    // The color of the lower border, default value is R255 G255 B255
    self.saeAddressTextField.borderColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:1];
    
    // The color of the placeholder, default value is R0 G0 B0 Alpha0.4
    self.saeAddressTextField.placeholderColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:1];
    
    // The color of the cursor, default value is R255 G255 B255
    self.saeAddressTextField.cursorColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:1];
    
    // The color of the text, default value is R255 G255 B255
    self.saeAddressTextField.textColor = [UIColor colorWithRed:(0/255) green:(0/255) blue:(0/255) alpha:1];
    
    // The image in the right-down corner, default value is a pencil icon. The color of the image is determined by borderColor.
//    self.saeAddressTextField.image = <#UIImage#>;
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.saeAddressTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.saeAddressTextField.didEndEditingHandler = ^{
        // ...
    };
    
    [self.realView addSubview:self.saeAddressTextField];
}

- (void)viewDidAppear:(BOOL)animated{
//    [self setUpUI];
    
}

- (void)connectInfo {
    self.firstNameLabel.text = [NSString stringWithFormat:@"%@ %@",  self.user.firstName, self.user.lastName];
    self.addressTextField.text = @"1 Hacker Way, Menlo Park, CA";
    self.emailTextField.text = self.user.email;
    self.phoneTextField.text = self.user.phoneNumber;
    self.paymentLabel.text = @"VISA **** **** **** 3432";
}

- (void)setUpUI {
    // profile pic
    self.profilePicture.layer.cornerRadius = 55;
    self.profilePicture.layer.masksToBounds = YES;
    
    //tiles
    self.tile1.backgroundColor = self.colors.mainColor;
    self.tile1.layer.cornerRadius = 2;
    
    self.tile2.backgroundColor = self.colors.mainColor;
    self.tile2.layer.cornerRadius = 2;
    
    self.tile3.backgroundColor = self.colors.mainColor;
    self.tile3.layer.cornerRadius = 2;
    
    self.tile4.backgroundColor = self.colors.mainColor;
    self.tile4.layer.cornerRadius = 2;
    
    //tabs
    self.tab1.backgroundColor = [UIColor whiteColor];
    self.tab2.backgroundColor = [UIColor whiteColor];
    self.tab3.backgroundColor = [UIColor whiteColor];
    
    // butons
    self.backButton.layer.borderWidth = 1.5;
    self.backButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.backButton.titleLabel.textColor = [UIColor whiteColor];
    self.backButton.layer.cornerRadius = 5;
    
    self.editProfileButton.layer.borderWidth = 1;
    self.editProfileButton.layer.borderColor = self.colors.mainColor.CGColor;
    self.editProfileButton.titleLabel.textColor = self.colors.mainColor;
    
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
//    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
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
