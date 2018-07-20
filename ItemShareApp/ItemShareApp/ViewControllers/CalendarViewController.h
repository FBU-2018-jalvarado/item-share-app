//
//  CalendarViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>


@interface CalendarViewController : UIViewController <JTCalendarDelegate>
@property (weak, nonatomic) IBOutlet UIView *calendarMenuView;
@property (weak, nonatomic) IBOutlet UIView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
