//
//  timeModel.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/23/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "timeModel.h"
#import "Parse.h"

@implementation timeModel




- (BOOL)isBetweenDates:(NSDate *)startDate withEndDate:(NSDate *)endDate withCurrDate: (NSDate *)currDate {
    //currDate = [NSDate date];
    if ([currDate compare:startDate] == NSOrderedAscending)
        return NO;
    
    if ([currDate compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

@end
