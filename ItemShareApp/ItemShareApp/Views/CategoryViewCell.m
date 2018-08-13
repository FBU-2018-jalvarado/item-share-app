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
    
    
    
   self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.3].CGColor;
//    self.layer.cornerRadius = 5;
    self.categoryLabel.text = keyString;
    [self setIcon:keyString];
    self.layer.cornerRadius = 10.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:10].CGPath;
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
