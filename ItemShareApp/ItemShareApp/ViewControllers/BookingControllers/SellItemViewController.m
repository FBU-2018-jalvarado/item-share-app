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
#import <GooglePlaces/GooglePlaces.h>
#import <CCTextFieldEffects/CCTextFieldEffects.h>
#import <CCTextFieldEffects/CCTextField.h>
#import "ColorScheme.h"


@interface SellItemViewController () <UITextViewDelegate, iCarouselViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemAddress;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (weak, nonatomic) IBOutlet UITextField *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *cat1;
@property (weak, nonatomic) IBOutlet UILabel *cat2;
@property (weak, nonatomic) IBOutlet UILabel *cat3;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *catLabel;
@property (weak, nonatomic) IBOutlet PFImageView *itemImage;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property (strong, nonatomic) Item *thisItem;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *descripLabel;
@property iCarouselViewController *icarVC;
//@property NYTPhotosViewController *nytPhotoVC;
@property BOOL thisIsFirstPic;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property int numberOfPages;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZipLabel;
@property (strong, nonatomic) HoshiTextField *itemTextField;
@property (strong, nonatomic) HoshiTextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (strong, nonatomic) NSString *formattedAddress;
@property (weak, nonatomic) IBOutlet UIButton *postButton;


@property (strong, nonatomic) ColorScheme *colors;
@end

@implementation SellItemViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup UI
//    self.backButton.backgroundColor = self.colors.mainColor;
    self.backButton.layer.cornerRadius = 5;
    self.postButton.layer.cornerRadius = 5;
//    self.backButton.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.backButton.layer.borderWidth = 1;
    self.itemImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.itemImage.layer.borderWidth = 2;
    self.descripLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.descripLabel.layer.borderWidth = 1;
    self.descripLabel.layer.cornerRadius = 5;
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height * 3;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    //self.categoryView.backgroundColor = self.colors.mainColor;
    [self setUpItemTextField];
    [self setUpPriceTextField];
    
    // setting up initial info
    self.categoryArray = [[NSMutableArray alloc] init];
    self.thisIsFirstPic = YES;
    self.itemTitle.delegate = self;
    self.itemTitle.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.itemAddress.delegate = self;
    self.itemAddress.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.priceLabel.delegate = self;
    self.descripLabel.delegate = self;
    self.numberOfPages = 0;
    self.imagePageControl.numberOfPages = self.numberOfPages;
    User *user = [PFUser currentUser];
    //self.addressLabel.text = user.address;
    NSArray *formattedAddressarr = [user.address componentsSeparatedByString:@", "];
    self.addressLabel.text = formattedAddressarr[0];
    self.cityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@",  formattedAddressarr[1], formattedAddressarr[2]];
    // Do any additional setup after loading the view.
    // TODO: make name field optional after login
    
    [self setUpGradient];
}

- (void)setUpGradient{
    CAGradientLayer *topGradient = [CAGradientLayer layer];
    topGradient.frame = self.topView.bounds;
    topGradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor colorWithWhite:1 alpha:0].CGColor, nil];
    // used for testing
//    topGradient.colors = [NSArray arrayWithObjects:(id)[UIColor blueColor].CGColor, (id) [UIColor blackColor], nil];
//    topGradient.locations = @[@0.0, @1.0];
    //Add gradient to view
    [self.topView.layer addSublayer:topGradient];
}

-(void) setUpItemTextField {
    // Recommended frame height is around 70.
    self.itemTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(150, 444, 200, 70)];
    self.itemTextField.placeholder = @"";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.itemTextField.placeholderFontScale = 0.65;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.itemTextField.borderInactiveColor = [UIColor colorWithRed:(185 / 255) green:(193 / 255) blue:(202 / 255) alpha:1];
    
    // The color of the active border, default value is R106 G121 B137
    self.itemTextField.borderActiveColor = [UIColor colorWithRed:(106/255) green:(121/255) blue:(137/255) alpha:1];
    
    // The color of the placeholder, default value is R185 G193 B202
    self.itemTextField.placeholderColor = [UIColor colorWithRed:(185/255) green:(193/255) blue:(202/255) alpha:1];
    
    // The color of the cursor, default value is R89 G95 B110
    self.itemTextField.cursorColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    // The color of the text, default value is R89 G95 B110
    self.itemTextField.textColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    self.itemTextField.font = [UIFont fontWithName:@"System" size:14];
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.itemTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.itemTextField.didEndEditingHandler = ^{
        // ...
    };
    
    [self.scrollView addSubview:self.itemTextField];
}

-(void) setUpPriceTextField {
    // Recommended frame height is around 70.
    self.priceTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(150, 507, 200, 70)];
    self.priceTextField.placeholder = @"";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.priceTextField.placeholderFontScale = 0.65;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.priceTextField.borderInactiveColor = [UIColor colorWithRed:(185 / 255) green:(193 / 255) blue:(202 / 255) alpha:1];
    
    // The color of the active border, default value is R106 G121 B137
    self.priceTextField.borderActiveColor = [UIColor colorWithRed:(106/255) green:(121/255) blue:(137/255) alpha:1];
    
    // The color of the placeholder, default value is R185 G193 B202
    self.priceTextField.placeholderColor = [UIColor colorWithRed:(185/255) green:(193/255) blue:(202/255) alpha:1];
    
    // The color of the cursor, default value is R89 G95 B110
    self.priceTextField.cursorColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    // The color of the text, default value is R89 G95 B110
    self.priceTextField.textColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    self.priceTextField.font = [UIFont fontWithName:@"System" size:14];
    self.priceTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.priceTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.priceTextField.didEndEditingHandler = ^{
        // ...
    };
    
    [self.scrollView addSubview:self.priceTextField];
}

// Present the autocomplete view controller when the locationView is pressed.
- (IBAction)didTapLocation:(id)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    self.formattedAddress = place.formattedAddress;
    NSArray *formattedAddressarr = [place.formattedAddress componentsSeparatedByString:@", "];
    self.addressLabel.text = formattedAddressarr[0];
    self.cityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@",  formattedAddressarr[1], formattedAddressarr[2]];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}



// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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


    [Item postItem:self.itemTextField.text withOwner:owner withLocation:nil withAddress:self.formattedAddress withCategories:self.categoryArray withDescription:self.descripLabel.text withImage:self.imageArray withPickedUpBool:@"NO" withDistance:nil withPrice:self.priceTextField.text withCompletion:^(Item *item, NSError *error) {
        if(error)
        {
            NSLog(@"Unable to post the item for sale");
            NSLog(@"%@", error);
            [self.categoryArray removeAllObjects];
        }
        else {
            NSLog(@"Posted the item for sale: ");
            self.thisItem = item;
            [self updateSellerInformation:item];
            self.cat1.text  = @"";
            self.cat2.text  = @"";
            self.cat3.text  = @"";
            [self.categoryArray removeAllObjects];
            [self.sellItemDelegate fetchItems];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] && !oldPic) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
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
    //editedImage = [self resizeImage:editedImage withSize:CGSizeMake(250, 250)];
    self.itemImage.image = editedImage;
    self.imagePageControl.numberOfPages = self.imagePageControl.numberOfPages + 1;
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
         categoriesViewController.title = @"Classify the item";
         categoriesViewController.sellDelegate = self;
     }
     if([segue.identifier isEqualToString:@"imageCarouselSegue"])
     {
         iCarouselViewController *icarVC = [segue destinationViewController];
         self.imageArray = [[NSMutableArray alloc] init];
         [self.imageArray addObject:[UIImage imageNamed:@"placeholderImageBlack"]];
         icarVC.images = [[NSMutableArray alloc] init];
         icarVC.images = self.imageArray;
         icarVC.parentVC = @"sell";
         icarVC.delegate = self;
         self.icarVC = icarVC;
     }
//     if([segue.identifier isEqualToString:@"NYTPhotoSegue"])
//     {
//         NYTPhotosViewController *nytPhotoVC = [segue destinationViewController];
//         NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithDataSource:self.dataSource initialPhoto:nil delegate:self];
//         photo
//
//         [self presentViewController:photosViewController animated:YES completion:nil];
////         self.imageArray = [[NSMutableArray alloc] init];
////         [self.imageArray addObject:[UIImage imageNamed:@"placeholderImageSmall"]];
////         nytPhotoVC.photos = [[NSMutableArray alloc] init];
////         icarVC.images = self.imageArray;
////         icarVC.parentVC = @"sell";
//         self.nytPhotoVC = nytPhotoVC;
//     }
 }

- (void)updatePage:(NSInteger)index {
    self.imagePageControl.currentPage = index;
}

@end
