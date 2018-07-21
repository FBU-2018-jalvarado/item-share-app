
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
}

//edit calendar
- (UIView<JTCalendarDay> *)calendarBuildDayView:(JTCalendarManager *)calendar{
    JTCalendarDayView *view = [JTCalendarDayView new];
    view.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    view.textLabel.textColor = [UIColor redColor];
  //  view.backgroundColor = [UIColor blackColor];
//    view.layer.borderColor = [UIColor redColor].CGColor;
//    view.layer.borderWidth = 1;
    return view;
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView{
    NSLog(@"hi");
    self.selectedDate = dayView.date;
    
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView duration:.3 options:0 animations:^{
        dayView.circleView.transform = CGAffineTransformIdentity;
        [self.calendarManager reload];
    } completion:nil];
    
}

- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(UIView<JTCalendarDay> *)dayView{
//    NSLog(@"bye");
    
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
