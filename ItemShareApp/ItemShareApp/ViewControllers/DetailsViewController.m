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

@interface DetailsViewController () <CalendarViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmPickupButton;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (strong, nonatomic) timeModel *timeModel;


@end

@implementation DetailsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeModel = [[timeModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    PFUser *owner = [PFUser currentUser];
//   [Item postItem:@"TEST" withOwner:owner withLocation:nil withAddress:@"New York, NY" withBooking:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error)
//        {
//            NSLog(@"Unable to post the item for sale");
//        }
//        else {
//            NSLog(@"Posted the item for sale: ");
//        }
//    }];
    
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
    if([self.timeModel isTimeAvailable:self.selectedStartDate withItem:self.item] && [self.timeModel isTimeAvailable:self.selectedEndDate withItem:self.item]){
        
        NSLog(@"TIME IS AVAILABLE");
        [self postCurrentBooking];
    }
    else{
    NSLog(@"TIME IS NOT AVAILABLE");
    }
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
    
    [newBooking saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"error saving booking");
        }
        else{
            [self.item.bookingsArray addObject:newBooking];
            [self.item setObject:self.item.bookingsArray forKey:@"bookingsArray"];
            [self.item saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"error saving item");                }
                else{
                    NSLog(@"updated item successfully");
                }
            }];
            NSLog(@"booking added!");
        }
    }];
//    [self.item.bookingsArray addObject:newBooking];
//    [self.item setObject:self.item.bookingsArray forKey:@"bookingsArray"];
//    [self.item saveInBackground];
//    NSLog(@"booking added!");
    
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
