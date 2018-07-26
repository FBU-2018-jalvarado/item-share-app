//
//  User.h
//  item-share-app
//
//  Created by Tarini Singh on 7/24/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PFUser.h"

@interface User : PFUser

@property (nonatomic, strong) NSString *_Nonnull name;
@property (nonatomic, strong) NSString *_Nullable email;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsSelling;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsPreviousRent;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsCurrentRent;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsFutureRent;

@end
