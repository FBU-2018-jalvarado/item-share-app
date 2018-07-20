
//
//  CalendarViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calendarManager = [JTCalendarManager new];
    self.calendarManager.delegate = self;
    
    [self.calendarManager setMenuView:self.calendarMenuView];
    [self.calendarManager setContentView:self.calendarContentView];
    [self.calendarManager setDate:[NSDate date]];
    
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
