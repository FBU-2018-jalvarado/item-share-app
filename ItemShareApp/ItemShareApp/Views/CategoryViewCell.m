//
//  CategoryViewCell.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CategoryViewCell.h"

@implementation CategoryViewCell

- (void) setCategory:(NSString *)keyString {
        self.categoryLabel.text = keyString;
}

@end
