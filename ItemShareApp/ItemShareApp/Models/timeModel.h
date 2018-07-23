//
//  timeModel.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/23/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface timeModel : NSObject

- (BOOL)isTimeAvailable:(NSDate *)date withItem:(Item *)item;
    
@end
