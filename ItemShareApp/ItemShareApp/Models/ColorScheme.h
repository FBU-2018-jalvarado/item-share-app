//
//  Colorway.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/25/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorScheme : NSObject

@property (strong, nonatomic) UIColor *mainColor;
@property (strong, nonatomic) UIColor *secondColor;
@property (strong, nonatomic) UIColor *thirdColor;

- (void)setColors;
+ (ColorScheme *)defaultScheme;

@end
