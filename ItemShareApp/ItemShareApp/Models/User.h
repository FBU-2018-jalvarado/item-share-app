//
//  User.h
//  item-share-app
//
//  Created by Tarini Singh on 7/24/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PFUser.h"

@interface User : PFUser

@property (nonatomic, strong) NSString *_Nonnull firstName;
@property (nonatomic, strong) NSString *_Nonnull lastName;
@property (nonatomic, strong) NSString *_Nonnull phoneNumber;
@property (nonatomic, strong) NSString *_Nullable email;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsSelling;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsPreviousRent;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsCurrentRent;
@property (nonatomic, strong) NSMutableArray *_Nullable itemsFutureRent;

+ (void) postUser: ( NSString * _Nullable )firstName withLastName:( NSString * _Nullable )lastName withPhoneNumber:( NSString * _Nullable )phoneNumber withEmail:( NSString * _Nullable )email withCompletion: (PFBooleanResultBlock  _Nullable)completion;
    
@end
