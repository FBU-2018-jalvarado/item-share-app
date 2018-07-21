
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

@interface CalendarViewController () <JTCalendarDelegate>

@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;
@property (strong, nonatomic) NSDate *selectedDate;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    
    [self.calendarManager setMenuView:_calendarMenuView];
    [self.calendarManager setContentView:_calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
    
    //changing locale and time zone
    /*
     _calendarManager.dateHelper.calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"CDT"];
     _calendarManager.dateHelper.calendar.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
     [_calendarManager reload];
     */
}

//edit calendar
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:15];
    view.textLabel.textAlignment = NSTextAlignmentCenter;
    view.textLabel.textColor = [UIColor blackColor];
    view.backgroundColor = [UIColor whiteColor];
    self.calendarContentView.backgroundColor = [UIColor whiteColor];
//    view.layer.borderColor = [UIColor redColor].CGColor;
//    view.layer.borderWidth = 1;
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
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    //another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    //method to test if a date has an event (for example)
    if([self eventHasDayCheck:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (BOOL)eventHasDayCheck:(NSDate *)date {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
