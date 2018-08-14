//
//  MapModel.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/19/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "MapModel.h"
#import "Item.h"
#import "Parse.h"

@implementation MapModel

- (void)fetchItemsWithCompletion:(void(^)(NSArray<Item *> *items, NSError *error))completion
{
    PFQuery *itemQuery = [Item query];
    //PFQuery *itemQuery = [PFQuery queryWithClassName:@"Item"];
    [itemQuery orderByDescending:@"createdAt"];
    [itemQuery includeKey:@"location"];
    [itemQuery includeKey:@"title"];
    [itemQuery includeKey:@"owner"];
    [itemQuery includeKey:@"address"];
    [itemQuery includeKey:@"point"];
    itemQuery.limit = 20;
    // fetch data asynchronously
    
    [itemQuery findObjectsInBackgroundWithBlock:^(NSArray<Item *> * _Nullable items, NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"%@", error);
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
