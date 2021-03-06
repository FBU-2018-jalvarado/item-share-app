
//
//  CalendarViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CalendarViewController.h"
#import <JTCalendar/JTCalendar.h>
#import "DetailsViewController.h"
#import "timeModel.h"
#import "Booking.h"
#import "ColorScheme.h"
#import "Item.h"

@interface CalendarViewController () <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) timeModel *timeModel;
@property (strong, nonatomic) ColorScheme *colors;
@property (nonatomic) BOOL firstClick;

@end

@implementation CalendarViewController

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.timeModel = [[timeModel alloc] init];
//        self.colors = [ColorScheme new];
//
//    }
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.colors = [ColorScheme new];
    self.timeModel = [timeModel new];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.colors setColors];
    [self setUpUI];
    [self fetchBookings];
    
    
    
    
//    [self.colors setColors];
//    [self setUpUI];
//    [self finishSetup];
//    [self fetchBookings];
}

- (void)finishSetup {
    
    self.firstClick = YES;
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    
  //  [self.calendarManager setMenuView:_calendarMenuView];
    [self.calendarManager setContentView:_calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
}

- (void)fetchBookings {
    [self.timeModel fetchItemBookingsWithCompletion:self.item withCompletion:^(NSArray<Item *> *bookings, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        if (bookings) {
            self.bookingsArray = [bookings mutableCopy];
            [self.calendarDelegate sendBookings:self.bookingsArray];
            [self finishSetup];
            
        } else {
            // HANDLE NO ITEMS
        }
    }];
}

- (void)setUpUI {

}

//edits contentView (month view)
//- (UIView *)calendarBuildMenuItemView:(JTCalendarManager *)calendar{
//    UILabel *label = [UILabel new];
//    label.backgroundColor = [UIColor redColor];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font = [UIFont fontWithName:@"Avenir-Medium" size:25];
//    [label setTextColor:[UIColor blackColor]];
//    //label.textColor = [UIColor blackColor];
//    return label;
////    UILabel *label = [UILabel new];
////
////    label.textAlignment = NSTextAlignmentCenter;
////    label.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
////
////    return label;
//}

- (UIView<JTCalendarWeekDay> *)calendarBuildWeekDayView:(JTCalendarManager *)calendar{
    JTCalendarWeekDayView *view = [JTCalendarWeekDayView new];
    for(UILabel *label in view.dayViews){
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Avenir-Light" size:14];
    }
    return view;
}

//edit calendar day boxes
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
    
    if(self.firstClick){ //picking start date
        self.firstClick = NO;
        self.startDate = self.selectedDate;
        self.endDate = nil;
    }
    else{ //picking end date
        if(self.startDate != nil){ //if a start date is selected already
            if([self firstDayIsAfter:dayView.date withSecondDate:self.startDate]){ //if the end date selected is before the currently selected start date, select that date as start date
                self.endDate = self.selectedDate;
                self.firstClick = YES;
                //update date labels
                [self.calendarDelegate sendDates:self.startDate withEndDate:self.endDate];
            }
            else{
                self.startDate = self.selectedDate;
                self.endDate = nil;
                self.firstClick = NO;
            }
        }
    }
    
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView duration:.3 options:0 animations:^{
        dayView.circleView.transform = CGAffineTransformIdentity;
        [self.calendarManager reload];
    } completion:nil];
    
    //load or prev or next page if touch a day from another month
    if(![self.calendarManager.dateHelper date:self.calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([self.calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [self.calendarContentView loadNextPageWithAnimation];
           // [self.calendarManager setMenuView:_calendarMenuView];
        }
        else{
            [self.calendarContentView loadPreviousPageWithAnimation];
            //[self.calendarManager setMenuView:_calendarMenuView];
        }
    }
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView{
    dayView.hidden = NO;
    
    UIColor *color = self.colors.mainColor;
    
    //today
    if([self.calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = self.colors.secondColor;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //startDate
    else if(self.startDate && [self.calendarManager.dateHelper date:self.startDate isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = color;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //endDate
    else if(self.endDate && [self.calendarManager.dateHelper date:self.endDate isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = color;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //other month
    else if(![self.calendarManager.dateHelper date:self.calendarContentView.date isTheSameMonthThan:dayView.date]){
        
        if([self dayIsBooked:dayView.date]){
            //make it gray or something
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor whiteColor];
           // dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5f];
        }
        else{
            //make it normal
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor whiteColor];
            dayView.textLabel.textColor = [UIColor darkGrayColor];
        }

    }
    //in between selected dates
    else if([self isBetweenDates:dayView.date withStartDate:self.startDate withEndDate:self.endDate] && (self.startDate != nil && self.endDate != nil)){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = color;
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    //another day of the current month
    else{
        if([self dayIsBooked:dayView.date]){
        //make it gray or something
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor whiteColor];
          //  dayView.dotView.backgroundColor = [UIColor redColor];
            dayView.textLabel.textColor = [UIColor darkGrayColor];
        }
        else{
        //make it normal
            dayView.circleView.hidden = YES;
            dayView.dotView.backgroundColor = [UIColor blueColor];
            dayView.textLabel.textColor = color;
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
    return NO;
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

- (IBAction)doneButtonPressed:(id)sender {
    [self.calendarDelegate sendDates:self.startDate withEndDate:self.endDate];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detailsBackSegue"]){
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.selectedStartDate = self.startDate;
        detailsViewController.selectedEndDate = self.endDate;
    }
}

//- (void)fetchBookings {
//    [self.timeModel fetchAllBookingsWithCompletion:^(NSArray<Item *> *bookings, NSError *error) {
//        if(error){
//            NSLog(@"error");
//        }
//        else{
//            self.bookingsArray = [bookings mutableCopy];
//        }
//    }];
//}

- (BOOL)isBetweenDates:(NSDate *)date withStartDate: (NSDate *)startTime withEndDate:(NSDate*)endTime {
    if (([date compare:startTime] == NSOrderedDescending) && ([date compare:endTime] == NSOrderedAscending)){
        return YES;
    }
    return NO;
}

- (BOOL)firstDayIsAfter: (NSDate*)firstDate withSecondDate: (NSDate *)secondDate {
    return [firstDate compare:secondDate] == NSOrderedDescending;
}

- (BOOL)firstDayisBefore: (NSDate*)firstDate withSecondDate: (NSDate *)secondDate {
    return [firstDate compare:secondDate] == NSOrderedDescending;
}
//implementing this with nothing present nothing in contentview of calendar
//- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UIView *)menuItemView date:(NSDate *)date{
//    static NSDateFormatter *dateFormatter;
//    if(!dateFormatter){
//        dateFormatter = [NSDateFormatter new];
//        dateFormatter.dateFormat = @"MMMM";
//        
//        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
//        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
//    }
//    
//    self.monthLabel.text = [dateFormatter stringFromDate:date];
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
