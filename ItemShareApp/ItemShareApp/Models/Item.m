//
//  Item.m
//  ItemShareApp
//
//  Created by Stephanie Lampotang on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic title;
@dynamic owner;
@dynamic location;
@dynamic address;
@dynamic itemID;
@dynamic bookingsArray;
@dynamic categories;
@dynamic descrip;
@dynamic image;
@dynamic bookedNow;

+ (nonnull NSString *)parseClassName {
    return @"Item";
}


//- (BOOL)isAvailableOnDate:(NSDate *)date {
//    [FBUDateHelper dateConflicers:date1 yo: date];
//}

+ (void) postItem: ( NSString * _Nonnull )title withOwner:( PFUser * _Nonnull )owner withLocation: ( CLLocation * _Nullable )location withAddress:( NSString * _Nullable )address withCategories:(NSMutableArray *_Nullable)categories withDescription:(NSString *_Nullable)descrip withImage:(UIImage *_Nullable)image withBookedNowBool:(BOOL *_Nullable)bookedNow withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Item *newItem = [Item new];
    newItem.title = title;
    newItem.location = location;
    newItem.address = address;
    newItem.owner = owner;
    newItem.bookingsArray = [[NSMutableArray alloc] init];
    newItem.categories = categories;
    newItem.descrip = descrip;
    newItem.image = [self getPFFileFromImage:image];
    newItem.bookedNow = bookedNow;
    
    [newItem saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}

@end
