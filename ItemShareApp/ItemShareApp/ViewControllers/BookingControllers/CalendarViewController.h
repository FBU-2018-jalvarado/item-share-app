//
//  CalendarViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol CalendarViewControllerDelegate

- (void)sendDates: (NSDate *)startDate withEndDate:(NSDate *)endDate;
- (void)sendBookings: (NSMutableArray *)bookings;

@end

@interface CalendarViewController : UIViewController

@property (nonatomic, weak) id <CalendarViewControllerDelegate> calendarDelegate;
@property (strong, nonatomic) NSMutableArray *bookingsArray;
@property (strong, nonatomic) Item *item;

@end
