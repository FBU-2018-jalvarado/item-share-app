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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CalendarViewController *calendarController = [segue destinationViewController];
    calendarController.calendarDelegate = self;
}

- (void)sendDates:(NSDate *)startDate withEndDate:(NSDate *)endDate {
    self.selectedStartDate = startDate;
    self.selectedEndDate = endDate;
}


@end
