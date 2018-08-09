//
//  Category.h
//  item-share-app
//
//  Created by Tarini Singh on 7/24/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>


// this is not a model for categories. an instance of this model is not a category. instead, it is a way to easily store and use the hard coded array and dictionary of categories

@interface Category : NSObject

@property (nonatomic, strong) NSArray *catArray;
@property (nonatomic, strong) NSDictionary *catDict;
@property (nonatomic, strong) NSDictionary *iconDict;
@property (nonatomic, strong) NSArray *lastLevel;

- (void) setCats;

@end
