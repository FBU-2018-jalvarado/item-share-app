//
//  CategoryViewCell.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CategoryViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CategoryViewCell

- (void) setCategory:(NSString *)keyString {
    self.layer.borderWidth = 2;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.blackTint.layer.cornerRadius = 10;
//    self.blackTint.layer.borderColor = [[UIColor blackColor] CGColor];
    self.categoryLabel.text = keyString;
    [self setIcon:keyString];
    
//    if([keyString isEqualToString:@"Clothing"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"notification"];
//    }
//    if([keyString isEqualToString:@"Instruments"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"history"];
//    }
//    if([keyString isEqualToString:@"Home"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"history"];
//    }
//    if([keyString isEqualToString:@"Electronics"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"notification"];
//    }
//    if([keyString isEqualToString:@"Sports and Outdoors"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"notification"];
//    }
//    if([keyString isEqualToString:@"Vehicles"])
//    {
//        self.backImage.image = [UIImage imageNamed: @"history"];
//    }
}

- (void) setIcon:(NSString *)categoryTitle{
    if (!self.cat){
        [self setUpCat];
    }
    NSString *iconTitleValue = self.cat.iconDict[[NSString stringWithFormat:@"%@", categoryTitle]];
    self.backImage.image = [UIImage imageNamed:iconTitleValue];
}

- (void) setUpCat {
    self.cat = [[Category alloc] init];
    [self.cat setCats];
}
@end
