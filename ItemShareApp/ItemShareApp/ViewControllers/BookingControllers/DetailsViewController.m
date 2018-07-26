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
#import "Parse.h"
#import "timeModel.h"
#import "PopUpViewController.h"
#import "ColorScheme.h"
#import "User.h"

@interface DetailsViewController () <CalendarViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmPickupButton;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) PopUpViewController * popUpVC;
@property (strong, nonatomic) NSMutableArray *bookingsArray;
@property (weak, nonatomic) IBOutlet UIButton *selectDatesButton;
@property (weak, nonatomic) IBOutlet UILabel *tolabel;


@property (weak, nonatomic) IBOutlet UIView *insideView;
//for design
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricePerHourLabel;

@property (strong, nonatomic) ColorScheme *colors;
@property (strong, nonatomic) timeModel *timeModel;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation DetailsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeModel = [[timeModel alloc] init];
        self.colors = [ColorScheme new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    [self.colors setColors];
    [self fetchBookings];
    [self setUpUI];
    //[self postPopUp];
}

- (void)viewDidAppear:(BOOL)animated{
    [self setUpUI];
}

- (void)setUpUI {
    //text setup
    self.titleLabel.text = self.item.title;
    self.addressLabel.text = self.item.address;
    
    //date setup
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YY"];
    if(self.selectedStartDate){
    self.startTimeLabel.text = [formatter stringFromDate:self.selectedStartDate];
    }
    if(self.selectedEndDate){
    self.endTimeLabel.text = [formatter stringFromDate:self.selectedEndDate];
    }
    
    self.insideView.layer.cornerRadius = 10;
    self.confirmPickupButton.layer.cornerRadius = 10;
    self.selectDatesButton.layer.cornerRadius = 8;
    self.backButton.layer.cornerRadius = 5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmButtonClicked:(id)sender {
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

- (void)fetchBookings {
    [self.timeModel fetchItemBookingsWithCompletion:self.item withCompletion:^(NSArray<Item *> *bookings, NSError *error) {
        if (error) {
            return;
        }
        if (bookings) {
            self.bookingsArray = [bookings mutableCopy];
        } else {
            // HANDLE NO ITEMS
        }
    }];
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
                    [self updateSellerInformation];
                    [self postPopUp];
                }
            }];
        }
    }];
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

- (void)updateSellerInformation{
//    User *seller = self.item.owner;
//    [seller.itemsSelling addObject:self.item];
//    [seller setObject:seller.itemsSelling forKey:@"itemsSelling"];
//    [seller saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"%@", error); //will not work. User cannot be saved unless they have been authenticated via logIn or signUp
//            // https://stackoverflow.com/questions/31087679/edit-parse-user-information-when-logged-in-as-other-user-in-android
//        }
//        else{
//            NSLog(@"updated seller itemsFutureRent array");
//        }
//    }];
}

- (void)postPopUp {
    self.popUpVC = [[PopUpViewController alloc] initWithNibName:@"PopUpViewController" bundle:nil];
    [self.popUpVC setName:self.item.title];
    [self.popUpVC showInView:self.view animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"calendarSegue"]){
    CalendarViewController *calendarController = [segue destinationViewController];
    calendarController.calendarDelegate = self;
        calendarController.bookingsArray = self.bookingsArray;
    }
}

- (void)sendDates:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    self.selectedStartDate = startDate;
    self.selectedEndDate = endDate;
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

@end
