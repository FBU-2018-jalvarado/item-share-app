
//
//  CalendarViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CalendarViewController.h"
#import <JTCalendar/JTCalendar.h>
#import <JTCalendar/JTCalendar.h>
#import "DetailsViewController.h"
#import "timeModel.h"
#import "Booking.h"

@interface CalendarViewController () <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) timeModel *timeModel;

@end

@implementation CalendarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeModel = [[timeModel alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self fetchBookings];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
   // [self fetchBookings];

    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    
    [self.calendarManager setMenuView:_calendarMenuView];
    [self.calendarManager setContentView:_calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
}

//edits contentView (month view)
- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Avenir-Medium" size:25];
    return label;
}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
    }
    return view;
}

//edit calendar within only the day view
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    view.textLabel.textAlignment = NSTextAlignmentCenter;
    view.textLabel.textColor = [UIColor blackColor];
    view.backgroundColor = [UIColor whiteColor];
    view.circleRatio = .8;
    //view.dotRatio = 1. / .9;
    self.calendarContentView.backgroundColor = [UIColor whiteColor];
    return view;
}

    

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView{
    self.selectedDate = dayView.date;
    
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView duration:.3 options:0 animations:^{
        dayView.circleView.transform = CGAffineTransformIdentity;
        [self.calendarManager reload];
    } completion:nil];
    
    //load or prev or next page if touch a day from another month
    if(![self.calendarManager.dateHelper date:self.calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([self.calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [self.calendarContentView loadNextPageWithAnimation];
        }
        else{
            [self.calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView{
    dayView.hidden = NO;
    
    //today
    if([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //selected date
    else if(self.selectedDate && [self.calendarManager.dateHelper date:self.selectedDate isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //other month
    else if(![self.calendarManager.dateHelper date:self.calendarContentView.date isTheSameMonthThan:dayView.date]){
        
        if([self dayIsBooked:dayView.date]){
            //make it gray or something
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor lightGrayColor];
           // dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor whiteColor];
        }
        else{
            //make it normal
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor lightGrayColor];
        }

    }
    //another day of the current month
    else{
        if([self dayIsBooked:dayView.date]){
        //make it gray or something
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor lightGrayColor];
          //  dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor blackColor];
        }
        else{
        //make it normal
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
        }
    }
    
    //method to test if a date has an event (for example)
    if([self dayHasEventCheck:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (BOOL)dayHasEventCheck:(NSDate *)date {
    return YES;
}

- (BOOL)dayIsBooked: (NSDate *)date {
    for(Booking *booking in self.bookingsArray){
        if(![self.timeModel isTimeAvailable:date withBookings:booking]) {
            return YES;
        }
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)startTimeButtonPressed:(id)sender {
    self.startDate = self.selectedDate;
    [self.startTimeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)endTimeButtonPressed:(id)sender {
    self.endDate = self.selectedDate;
    [self.endTimeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)doneButtonPressed:(id)sender {
    //[self performSegueWithIdentifier:@"detailsBackSegue" sender:nil];
    [self.calendarDelegate sendDates:self.startDate withEndDate:self.endDate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailsBackSegue"]){
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.selectedStartDate = self.startDate;
        detailsViewController.selectedEndDate = self.endDate;
        //didnt work (want to change UI of picker)
        detailsViewController.startTimePicker.date = self.selectedDate;
        detailsViewController.endTimePicker.date = self.selectedDate;
    }
}

- (void)fetchBookings {
    [self.timeModel fetchAllBookingsWithCompletion:^(NSArray<Item *> *bookings, NSError *error) {
        if(error){
            NSLog(@"error");
        }
        else{
            self.bookingsArray = [bookings mutableCopy];
        }
    }];
}

//implementing this with nothing present nothing in contentview of calendar
//- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UIView *)menuItemView date:(NSDate *)date{
//    //idk how to implement
//}

//tips for pod

//to change to week mode
/*
 self.calendarManager.settings.weekModeEnabled = YES;
 [self.calendarManager reload];
 */

//changing locale and time zone
/*
 _calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"CDT"];
 _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
 [_calendarManager reload];
 */


@end
