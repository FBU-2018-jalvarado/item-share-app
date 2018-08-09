//
//  DetailsViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "DetailsViewController.h"
#import "Booking.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Parse.h"
#import "timeModel.h"
#import "PopUpViewController.h"
#import "ColorScheme.h"
#import "iCarouselViewController.h"
#import "User.h"
#import <Passkit/Passkit.h>

@interface DetailsViewController () <CalendarViewControllerDelegate, popUpDelegate, PKPaymentAuthorizationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet PFImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceWeekLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *applePayButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel2;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel3;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property NSInteger numberOfPages;
@property (weak, nonatomic) IBOutlet UIPageControl *imagePageControl;
@property iCarouselViewController *icarVC;

@property (strong, nonatomic) ColorScheme *colors;
@property (strong, nonatomic) timeModel *timeModel;
@property (strong, nonatomic) PopUpViewController * popUpVC;
@property (strong, nonatomic) NSMutableArray *bookingsArray;

//apple pay
@property (strong, nonatomic) NSArray *supportedPaymentNetworks;
@property (strong, nonatomic) NSString *fetchMerchantID;

@end

@implementation DetailsViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.timeModel = [timeModel new];
    self.colors = [ColorScheme defaultScheme];
    self.supportedPaymentNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex];
    self.fetchMerchantID = @"merchant.com.nicolas.Fetch";
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.colors setColors];
    [self setUpUI];
    self.imagePageControl.numberOfPages = self.item.images.count;
    [self.icarVC reload];
    //check if payments are authorized. If not, the pay button will be hidden
    // self.applePayButton.hidden = ![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:self.supportedPaymentNetworks];
}

- (void)viewDidAppear:(BOOL)animated{
    [self setUpUI];
}

- (void)setUpUI {
    
    self.backButton.backgroundColor = [UIColor clearColor];
    self.backButton.layer.cornerRadius = 5;
    self.backButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backButton.layer.borderWidth = 1;
    //image setup
    self.itemImageView.file = [self.item.images firstObject];
    [self.itemImageView loadInBackground];
    
    //text setup
    self.titleLabel.text = self.item.title;
    self.addressLabel.text = self.item.address;
//    NSString *strng = [[[[self.item.categories[0] stringByAppendingString:@", "] stringByAppendingString:self.item.categories[1]] stringByAppendingString:@", "] stringByAppendingString:self.item.categories[2]];
//
//    self.categoryLabel.text = strng;
    self.categoryLabel.text = self.item.categories[0];
    self.categoryLabel2.text = self.item.categories[1];
    self.categoryLabel3.text = self.item.categories[2];
    self.priceLabel.text = self.item.price;
    self.priceWeekLabel.text = [@([self.item.price doubleValue] * 6) stringValue];
    self.priceMonthLabel.text = [@([self.item.price integerValue] * 22) stringValue];

    [self.descriptionLabel sizeToFit];
    self.descriptionLabel.text = self.item.descrip;
    
    self.applePayButton.layer.cornerRadius = 10;
    //self.selectDatesButton.layer.cornerRadius = 8;
    
    CGFloat contentWidth = self.scrollView.bounds.size.width;
    CGFloat contentHeight = self.scrollView.bounds.size.height *3;
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
}

- (void)updateDateUI {
    //date setup
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YY"];
    if(self.selectedStartDate){
       // self.startTimeLabel.text = [formatter stringFromDate:self.selectedStartDate];
    }
    if(self.selectedEndDate){
       // self.endTimeLabel.text = [formatter stringFromDate:self.selectedEndDate];
    }
    
    NSNumberFormatter *numfort = [[NSNumberFormatter alloc] init];
    [numfort setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numfort setCurrencySymbol:@""];

    if(self.selectedStartDate && self.selectedEndDate){
        NSInteger days = [self daysBetween:self.selectedStartDate and:self.selectedEndDate];
        if(days < 7){
            double price = days * [self.item.price integerValue];
            NSDecimalNumber *decnum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", price]];
            NSString *formattedPrice = [numfort stringFromNumber:decnum];
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%@", formattedPrice];
        }
        else if(days < 30){
            //NSInteger weeks = [@(days/7) integerValue];
            
            double weeks = (double)days/7;
            double price = weeks * 6 * [self.item.price integerValue];
            
            NSDecimalNumber *decnum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", price]];
            NSString *formattedPrice = [numfort stringFromNumber:decnum];
            self.totalPriceLabel.text = [NSString stringWithFormat:@"%@", formattedPrice];
        }
    }
}

- (NSInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    NSInteger daysBetween = labs([components day]);
    return daysBetween+1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)payButtonClicked:(id)sender { //apple pay button clicked
    //bookings already fetched, in array
    if([self isAvailable]){
        NSLog(@"TIME IS AVAILABLE");
        [self postCurrentBooking];
    }
    else{
        NSLog(@"TIME IS NOT AVAILABLE");
        [self presentAlert];
    }
}

- (BOOL)isAvailable{
    for(Booking *booking in self.bookingsArray){
        if(!([self.timeModel isTimeAvailable:self.selectedStartDate withBookings:booking] && [self.timeModel isTimeAvailable:self.selectedEndDate withBookings:booking])){
            return NO;
        }
    }
    return YES;
}

//set booking
- (void)postCurrentBooking{
    User *renter = (User*)[PFUser currentUser];

    Booking *newBooking = [Booking new];
    newBooking.item = self.item;
    newBooking.seller = nil;
    newBooking.renter = renter;
    newBooking.address = self.item.address;
    newBooking.startTime = self.selectedStartDate;
    newBooking.endTime = self.selectedEndDate;
    
    [newBooking saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            [self.item.bookingsArray addObject:newBooking];
            [self.item setObject:self.item.bookingsArray forKey:@"bookingsArray"];
            [self.item saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"%@", error);                }
                else{
                    NSLog(@"updated item successfully/ booking added");
                    [self updateRenterInformation];
                    [self makePurchase];
                }
            }];
        }
    }];
}

- (void)makePurchase{
    //pressing cancel crashes
    PKPaymentRequest *request = [PKPaymentRequest new];
    
    request.merchantIdentifier = self.fetchMerchantID; //used to decrypt the cryptogram on backend
    request.supportedNetworks = self.supportedPaymentNetworks; //request which networks you support
    request.merchantCapabilities = PKMerchantCapability3DS; //security standard you want to use. 3DS most popular in US
    request.countryCode = @"US"; //add more if want international transactions
    request.currencyCode = @"USD";
    
    self.supportedPaymentNetworks = @[PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex];
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:self.totalPriceLabel.text];
    request.paymentSummaryItems = @[[PKPaymentSummaryItem summaryItemWithLabel:self.titleLabel.text amount:price], [PKPaymentSummaryItem summaryItemWithLabel:@"Fetch&Co" amount:price]];
    
    PKPaymentAuthorizationViewController *appleVC = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:request];
    appleVC.delegate = self;
    [self presentViewController:appleVC animated:YES completion:nil];
}

- (void)updateRenterInformation{
    User *renter = (User*)[PFUser currentUser];
    [renter.itemsFutureRent addObject:self.item];
    [renter setObject:renter.itemsFutureRent forKey:@"itemsFutureRent"];
    [renter saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"updated renter itemsFutureRent array");
        }
    }];
}

- (void)postPopUp {
    self.popUpVC = [[PopUpViewController alloc] initWithNibName:@"PopUpViewController" bundle:nil];
    self.popUpVC.popUpDelegate = self;
    [self.popUpVC setName:self.item.title];
    [self.popUpVC setItem:self.item];
    [self.popUpVC setOwner:self.item.owner];
    [self.popUpVC setPhoneNumber:self.item.owner.phoneNumber];
    [self.popUpVC showInView:self.view animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"embedSegue"]){
        CalendarViewController *calendarController = [segue destinationViewController];
        calendarController.calendarDelegate = self;
        calendarController.item = self.item;
        //calendarController.bookingsArray = self.bookingsArray;
    }
    if([segue.identifier isEqualToString:@"CarouselSegue"])
    {
        iCarouselViewController *icarVC = [segue destinationViewController];
        //self.imageArray = [[NSMutableArray alloc] init];
        //[self.imageArray addObject:[UIImage imageNamed:@"placeholderImageSmall"]];
        icarVC.delegate = self;
        icarVC.images = [[NSMutableArray alloc] init];
        icarVC.images = self.item.images;
        icarVC.parentVC = @"detail";
      //  self.icarVC = icarVC;
        [icarVC reload];
    }
}

//delegate methods

- (void)sendDates:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    self.selectedStartDate = startDate;
    self.selectedEndDate = endDate;
    
    [self updateDateUI];
    //date setup
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MM-dd-YY"];
//    if(self.selectedStartDate){
//        self.startTimeLabel.text = [formatter stringFromDate:self.selectedStartDate];
//    }
//    if(self.selectedEndDate){
//        self.endTimeLabel.text = [formatter stringFromDate:self.selectedEndDate];
//    }
}

- (void)sendBookings: (NSMutableArray *)bookings{
    self.bookingsArray = bookings;
}

- (void)presentAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Chosen booking dates are not available. Please choose another booking date." preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { // handle response here.
    }];
    // add the OK action to the alert controller
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


//delegate extension

- (void)paymentAuthorizationViewControllerDidFinish:(nonnull PKPaymentAuthorizationViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

//how to see entire method in autofill
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment handler:(void (^)(PKPaymentAuthorizationResult * _Nonnull))completion{
    completion(PKPaymentAuthorizationStatusSuccess);
    [self performSelector:@selector(bookingFinished) withObject:nil afterDelay:2.0];

}

- (void)bookingFinished {
    [self postPopUp];
    // [self performSelector:@selector(postPopUp) withObject:nil afterDelay:3.0 ];
    //[self dismissViewControllerAnimated:YES completion:nil];
   // [self performSelector:@selector(postPopUp) withObject:nil afterDelay:3.0 ];
}

- (void)askedForDirections {
    [self.detailsDelegate sendDirectionRequestToMap:self.item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updatePage:(NSInteger)index {
    self.imagePageControl.currentPage = index;
}

@end

