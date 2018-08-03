//
//  CategoriesFlowLayout.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/30/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CategoriesFlowLayout.h"

@implementation CategoriesFlowLayout
- (id) init {
    if ((self = [super init])) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10000.0f;
    }
    return self;
}
@end
