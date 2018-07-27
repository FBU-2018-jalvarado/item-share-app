//
//  SellItemViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "SellItemViewController.h"
#import "Item.h"
#import <Parse/Parse.h>
#import "User.h"
#import "CategoriesViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import <ParseUI/ParseUI.h>

@interface SellItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemAddress;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cat1;
@property (weak, nonatomic) IBOutlet UILabel *cat2;
@property (weak, nonatomic) IBOutlet UILabel *cat3;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *catLabel;
//@property (weak, nonatomic) IBOutlet PFImageView *itemImage;


@end

@implementation SellItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.categoryView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.categoryView.layer.borderWidth = 1;
    // Do any additional setup after loading the view.
    // TODO: make name field optional after login
    self.categoryView.userInteractionEnabled = NO;
    self.cat1.userInteractionEnabled = NO;
    self.cat1.userInteractionEnabled = NO;
    self.cat1.userInteractionEnabled = NO;
    self.catLabel.userInteractionEnabled = NO;
    self.label1.userInteractionEnabled = NO;
    self.label2.userInteractionEnabled = NO;
    self.label3.userInteractionEnabled = NO;
    self.categoryView.alpha = 0;
    self.cat1.alpha = 0;
    self.cat1.alpha = 0;
    self.cat1.alpha = 0;
    self.catLabel.alpha = 0;
    self.label1.alpha = 0;
    self.label2.alpha = 0;
    self.label3.alpha = 0;
}

- (IBAction)categoryAvailable:(id)sender {
    self.categoryView.userInteractionEnabled = YES;
    self.cat1.userInteractionEnabled = YES;
    self.cat1.userInteractionEnabled = YES;
    self.cat1.userInteractionEnabled = YES;
    self.catLabel.userInteractionEnabled = YES;
    self.label1.userInteractionEnabled = YES;
    self.label2.userInteractionEnabled = YES;
    self.label3.userInteractionEnabled = YES;
    self.categoryView.alpha = 1;
    self.cat1.alpha = 1;
    self.cat1.alpha = 1;
    self.cat1.alpha = 1;
    self.catLabel.alpha = 1;
    self.label1.alpha = 1;
    self.label2.alpha = 1;
    self.label3.alpha = 1;
    if(self.itemTitle.isFirstResponder)
    {
        [self.itemTitle resignFirstResponder];
    }
    if(self.itemAddress.isFirstResponder)
    {
        [self.itemAddress resignFirstResponder];
    }
    if(self.priceLabel.isFirstResponder)
    {
        [self.priceLabel resignFirstResponder];
    }
}

- (IBAction)sellOnTap:(id)sender {
    //create and set item and user objects
    Item *itemToBeSold = [Item new];
    User *owner = (User*)[PFUser currentUser];

    [Item postItem:self.itemTitle.text withOwner:owner withLocation:nil withAddress:self.itemAddress.text withCategories:self.categoryArray withDescription:nil withImage:nil withPickedUpBool:@"NO" withDistance:nil withPrice:self.priceLabel.text withCompletion:^(Item *item, NSError *error) {
        if(error)
        {
            NSLog(@"Unable to post the item for sale");
        }
        else {
            NSLog(@"Posted the item for sale: ");
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
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    
//    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
//    //editedImage = [editedImage resizeImage]
//    self.itemImage.image = editedImage;
//    
//    //save the image
//    PFUser *user = PFUser.currentUser;
//    user[@"image"] = [Post getPFFileFromImage:editedImage];
//    [user saveInBackground];
//    
//    //now show the image chosen
//    // load photo for current user
//    self.ppImage.file = user[@"image"];
//    // if its for another user then load their photo
//    if(self.user)
//    {
//        self.ppImage.file = self.user[@"image"];
//    }
//    [self.ppImage loadInBackground];
//    // Dismiss UIImagePickerController to go back to your original view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

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
 }
 

@end
