//
//  timeModel.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/23/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "timeModel.h"
#import "Parse.h"
#import "Item.h"
#import "Booking.h"

@implementation timeModel

//if the current time is not booked (date passed in is not within any booking ranges
- (BOOL)isTimeAvailable:(NSDate *)date withBookings:(Booking *)booking {
    NSDate *startTime = booking.startTime;
    NSDate *endTime = booking.endTime;
    if (([date compare:startTime] == NSOrderedDescending) && ([date compare:endTime] == NSOrderedAscending)){
        return NO;
    }
    return YES;
}

- (void)method: (NSDate *)date{
    for(Booking *booking in self.bookingsArray){
        NSLog(@"inside");
            NSDate *startTime = booking.startTime;
            NSDate *endTime = booking.endTime;
            if (([date compare:startTime] == NSOrderedDescending) && ([date compare:endTime] == NSOrderedAscending)){
                self.availableTime = NO;
            }
    }
}

- (void)fetchBookingsWithCompletion:(Item *)item withCompletion:(void(^)(NSArray<Item *> *bookings, NSError *error))completion
{
    if(item){
    PFQuery *query = [Booking query];
    //PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"location"];
    NSString *bookingItemID = [@"Item$" stringByAppendingString:item.objectId];
    NSLog(@"%@",bookingItemID);
    [query whereKey:@"address" equalTo:item.address]; //Item$   a8cJfHGT0s //_p_item did not work
    //[query whereKey:@"author" equalTo:self.user];
    // fetch data asynchronously
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Item *> * _Nullable bookings, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(bookings, nil);
            });
        }
    }];
    }
}


@end
