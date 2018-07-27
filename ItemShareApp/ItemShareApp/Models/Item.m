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
@dynamic pickedUp;
@dynamic distanceToUser;
@dynamic price;

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

+ (void) postItem: ( NSString * _Nonnull )title withOwner:( User * _Nonnull )owner withLocation: ( CLLocation * _Nullable )location withAddress:( NSString * _Nullable )address withCategories:(NSMutableArray *_Nullable)categories withDescription:(NSString *_Nullable)descrip withImage:(UIImage *_Nullable)image withPickedUpBool:(NSString *_Nullable)pickedUp withDistance: (NSNumber *_Nullable)distanceToUser withPrice:(NSString *)price withCompletion:(void(^)(Item * item, NSError *error))completion {
    
    Item *newItem = [Item new];
    newItem.title = title;
    newItem.location = location;
    newItem.address = address;
    newItem.owner = owner;
    newItem.bookingsArray = [[NSMutableArray alloc] init];
    newItem.categories = [NSMutableArray arrayWithObjects:@"Instruments", @"Strings", @"Guitar and Similar", nil];
    newItem.descrip = descrip;
    newItem.image = [self getPFFileFromImage:image];
    newItem.pickedUp = pickedUp;
    newItem.price = price;
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
