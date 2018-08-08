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
@dynamic address;
@dynamic itemID;
@dynamic bookingsArray;
@dynamic categories;
@dynamic descrip;
@dynamic images;
@dynamic pickedUp;
@dynamic distanceToUser;
@dynamic price;
@dynamic location;
@dynamic point;

+ (nonnull NSString *)parseClassName {
    return @"Item";
}

-(BOOL) isPickedUp: (NSString*)pickedUp
{
    if (pickedUp != nil){
        if ([pickedUp isEqualToString:@"YES"]){
            return YES;
        }
        else {
            return NO;
        }
    }
    return NO;
}

//- (BOOL)isAvailableOnDate:(NSDate *)date {
//    [FBUDateHelper dateConflicers:date1 yo: date];
//}

+ (NSMutableArray *)imagesToFiles: (NSMutableArray *)images {
    NSMutableArray *pffiles = [[NSMutableArray alloc] init];
    for (UIImage* image in images)
    {
        [pffiles addObject:[Item getPFFileFromImage:image]];
    }
    return pffiles;
}

+ (void) postItem: ( NSString * _Nonnull )title withOwner:( User * _Nonnull )owner withLocation: ( CLLocation * _Nullable )location withAddress:( NSString * _Nullable )address withCategories:(NSMutableArray *_Nullable)categories withDescription:(NSString *_Nullable)descrip withImage:(NSMutableArray *_Nullable)images withPickedUpBool:(NSString *_Nullable)pickedUp withDistance: (NSNumber *_Nullable)distanceToUser withPrice:(NSString *)price withCompletion:(void(^)(Item * item, NSError *error))completion {
    
    Item *newItem = [Item new];
    newItem.title = title;
    newItem.location = location;
    newItem.address = address;
    newItem.owner = owner;
    newItem.bookingsArray = [[NSMutableArray alloc] init];
    newItem.categories = categories;
    newItem.descrip = descrip;
    newItem.images = [Item imagesToFiles:images];
    newItem.pickedUp = pickedUp;
    newItem.price = price;
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            CLPlacemark *placemark = [placemarks lastObject]; //always guaranteed to be at least one object
          //  newItem.location = placemark.location;
            PFGeoPoint *point = [PFGeoPoint geoPointWithLocation:(CLLocation *)placemark.location];
            newItem.point = point;
            
            [newItem saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if(error != nil)
                {
                    NSLog(@"ERROR GETTING THE ITEMS!");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(nil, error);
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(newItem, nil);
                    });
                }
            }];
            
        }
    }];
    //[newItem saveInBackgroundWithBlock: completion];
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
