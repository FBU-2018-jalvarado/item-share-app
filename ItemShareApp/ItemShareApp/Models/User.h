//
//  User.h
//  ItemShareApp
//
//  Created by Stephanie Lampotang on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "PFUser.h"

@interface User : PFUser

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *itemsForSale;

@end
