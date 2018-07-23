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
#import "Item.h"
#import "Parse.h"

@interface DetailsViewController () <CalendarViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmPickupButton;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
    //self.item = [Item new];
    
    Item *toBeSold = [Item new];
    PFUser *owner = [PFUser currentUser];
//    [Item postItem:@"itemName" withOwner:owner withLocation:nil withAddress:@"901 N Alpine Dr, BEVERLY HILLS, CA 90210" withBooking:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error)
//        {
//            NSLog(@"Unable to post the item for sale");
//        }
//        else {
//            NSLog(@"Posted the item for sale: ");
//            NSLog(@"%@", toBeSold);
//        }
//    }];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self setUpUI];
}

- (void)setUpUI {
    self.titleLabel.text = self.item.title;
    self.addressLabel.text = self.item.address;
    self.startTimePicker.datePickerMode = UIDatePickerModeDate;
    self.endTimePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-YY"];
    if(self.selectedStartDate){
    self.startTimeLabel.text = [formatter stringFromDate:self.selectedStartDate];
    }
    if(self.selectedEndDate){
    self.endTimeLabel.text = [formatter stringFromDate:self.selectedEndDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirmButtonClicked:(id)sender {
    [self postCurrentBooking];
}

//set booking
- (void)postCurrentBooking{
    PFUser *renter = [PFUser currentUser];
//    [Booking postBooking:self.item withSeller:nil withRenter:renter withAddress:self.item.address withStartTime:self.selectedStartDate withEndTime:self.selectedEndDate withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error){
//            NSLog(@"error");
//        }
//        else{
//            NSLog(@"posted booking");
//        }
//    }];
    
    Booking *newBooking = [Booking new];
    newBooking.item = self.item;
    newBooking.seller = nil;
    newBooking.renter = renter;
    newBooking.address = self.item.address;
    newBooking.startTime = self.selectedStartDate;
    newBooking.endTime = self.selectedEndDate;
    
    [self.item.bookingsArray addObject:newBooking];
    [self.item setObject:self.item.bookingsArray forKey:@"bookingsArray"];
    [self.item saveInBackground];
    NSLog(@"booking added!");
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CalendarViewController *calendarController = [segue destinationViewController];
    calendarController.calendarDelegate = self;
}






- (void)sendDates:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    self.selectedStartDate = startDate;
    self.selectedEndDate = endDate;
}


@end
