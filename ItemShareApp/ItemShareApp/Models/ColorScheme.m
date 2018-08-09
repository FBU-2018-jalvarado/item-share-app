//
//  Colorway.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/25/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ColorScheme.h"

@implementation ColorScheme

//to implement: init the model property and call setColors
- (void)setColors{
    //main COLOR
    //
    UIColor *mainColor = [UIColor colorWithRed:255.0f/255.0f green:98.0f/255.0f blue:68.0f/255.0f alpha:1.0f];
    //cyan color
    UIColor *secondColor = [UIColor colorWithRed:202.0f/255.0f green:255.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    //darkblue
    UIColor *thirdColor = [UIColor colorWithRed:90.0f/255.0f green:111.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    [self setMainColor:mainColor];
    [self setSecondColor:secondColor];
    [self setThirdColor:thirdColor];
}

+ (ColorScheme *)defaultScheme
{
    ColorScheme *defaultScheme = [ColorScheme new];
    [defaultScheme setColors];
    return defaultScheme;
}

@end
