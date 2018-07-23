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
- (BOOL)isTimeAvailable:(NSDate *)date withItem:(Item *)item {
    
   //Item *item = [Item new];
    for(Booking *booking in item.bookingsArray){
        [booking fetchIfNeeded];
        NSDate *startTime = booking.startTime;
        NSDate *endTime = booking.endTime;
        
        if (([date compare:startTime] == NSOrderedDescending) && ([date compare:endTime] == NSOrderedAscending))
            return NO;
    }
    return YES;
}

- (void)fetchBookingsWithCompletion:(void(^)(NSArray<Item *> *items, NSError *error))completion
{
    PFQuery *query = [Booking query];
    //PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"location"];
    //[query whereKey:@"author" equalTo:self.user];
    // fetch data asynchronously
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Item *> * _Nullable items, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"ERROR GETTING THE ITEMS!");
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(items, nil);
            });
        }
    }];
}


@end
