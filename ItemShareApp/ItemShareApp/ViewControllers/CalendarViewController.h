//
//  CalendarViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarViewControllerDelegate

- (void)sendDates: (NSDate *)startDate withEndDate:(NSDate *)endDate;

@end

@interface CalendarViewController : UIViewController

@property (nonatomic, weak) id <CalendarViewControllerDelegate> calendarDelegate;

@end
