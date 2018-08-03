//
//  SellItemViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "SellItemViewController.h"
#import "Item.h"
#import "iCarouselViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "CategoriesViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ParseUI/ParseUI.h>

@interface SellItemViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemAddress;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *cat1;
@property (weak, nonatomic) IBOutlet UILabel *cat2;
@property (weak, nonatomic) IBOutlet UILabel *cat3;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *catLabel;
@property (weak, nonatomic) IBOutlet PFImageView *itemImage;
@property (strong, nonatomic) Item *thisItem;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *descripLabel;
@property iCarouselViewController *icarVC;
@property BOOL thisIsFirstPic;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation SellItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup UI
    self.backButton.backgroundColor = [UIColor clearColor];
    self.backButton.layer.cornerRadius = 5;
    self.backButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backButton.layer.borderWidth = 1;
    self.itemImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.itemImage.layer.borderWidth = 2;
    self.descripLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.descripLabel.layer.borderWidth = 1;
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height * 3;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
    // setting up initial info
    self.categoryArray = [[NSMutableArray alloc] init];
    self.thisIsFirstPic = YES;
    self.itemTitle.delegate = self;
    self.itemAddress.delegate = self;
    self.priceLabel.delegate = self;
    self.descripLabel.delegate = self;
    
    // Do any additional setup after loading the view.
    // TODO: make name field optional after login
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

//- (IBAction)categoryAvailable:(id)sender {
//    if(self.itemTitle.isFirstResponder)
//    {
//        [self.itemTitle resignFirstResponder];
//    }
//    if(self.itemAddress.isFirstResponder)
//    {
//        [self.itemAddress resignFirstResponder];
//    }
//    if(self.priceLabel.isFirstResponder)
//    {
//        [self.priceLabel resignFirstResponder];
//    }
//}

- (IBAction)sellOnTap:(id)sender {
    //create and set item and user objects
    Item *itemToBeSold = [Item new];
    User *owner = (User*)[PFUser currentUser];


    [Item postItem:self.itemTitle.text withOwner:owner withLocation:nil withAddress:self.itemAddress.text withCategories:self.categoryArray withDescription:self.descripLabel.text withImage:self.imageArray withPickedUpBool:@"NO" withDistance:nil withPrice:self.priceLabel.text withCompletion:^(Item *item, NSError *error) {
        if(error)
        {
            NSLog(@"Unable to post the item for sale");
            NSLog(@"%@", error);
        }
        else {
            NSLog(@"Posted the item for sale: ");
            self.thisItem = item;
            [self updateSellerInformation:item];
            self.cat1.text  = @"";
            self.cat2.text  = @"";
            self.cat3.text  = @"";
        }
        [self.categoryArray removeAllObjects];
        
    }];
}

- (void)updateSellerInformation: (Item *)item{
    User *seller = (User*) [PFUser currentUser];
    [seller.itemsSelling addObject:item];
    [seller setObject:seller.itemsSelling forKey:@"itemsSelling"];
    [seller saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error); //will not work. User cannot be saved unless they have been authenticated via logIn or signUp
            // https://stackoverflow.com/questions/31087679/edit-parse-user-information-when-logged-in-as-other-user-in-android
        }
        else{
            NSLog(@"updated seller itemsSelling array");
        }
    }];
}

- (IBAction)tapPhoto:(id)sender {
    [self choosePic:NO];
}

- (IBAction)tapImage:(id)sender {
    [self choosePic:NO];
}

- (void)choosePic:(BOOL) oldPic {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && !oldPic) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead -- or you chose upload");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    editedImage = [self resizeImage:editedImage withSize:CGSizeMake(250, 250)];
    self.itemImage.image = editedImage;
    if(self.thisIsFirstPic)
    {
        self.icarVC.images[0] = editedImage;
        self.thisIsFirstPic = NO;
    }
    else {
        [self.icarVC.images addObject:editedImage];
    }
    //save the image
    //self.itemImage.file = [Item getPFFileFromImage:editedImage];
    [self.itemImage loadInBackground];
    [self.icarVC reload];
    // Dismiss UIImagePickerVC to go back to your original VC
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// delegate function to keep track of categories an item falls under
- (void)addCategory:(NSString *)categoryName {
    [self.categoryArray addObject:categoryName];
    if(self.cat1.text.length == 0)
    {
        self.cat1.text = categoryName;
    }
    else {
        if(self.cat2.text.length == 0)
        {
            self.cat2.text = categoryName;
        }
        else {
            if(self.cat3.text.length == 0)
            {
                self.cat3.text = categoryName;
            }
        }
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"sellCategorySegue"])
     {
         UINavigationController *navVC = [segue destinationViewController];
         CategoriesViewController *categoriesViewController = [navVC.viewControllers firstObject];
         categoriesViewController.firstPage = YES;
         categoriesViewController.title = @"Categories";
         categoriesViewController.sellDelegate = self;
     }
     if([segue.identifier isEqualToString:@"imageCarouselSegue"])
     {
         iCarouselViewController *icarVC = [segue destinationViewController];
         self.imageArray = [[NSMutableArray alloc] init];
         [self.imageArray addObject:[UIImage imageNamed:@"placeholderImageSmall"]];
         icarVC.images = [[NSMutableArray alloc] init];
         icarVC.images = self.imageArray;
         icarVC.parentVC = @"sell";
         self.icarVC = icarVC;
     }
 }
 

@end
