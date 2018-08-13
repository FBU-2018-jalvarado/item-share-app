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
    //light blue
//    UIColor *mainColor = [UIColor colorWithRed:116.0f/255.0f green:186.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    UIColor *mainColor = [UIColor colorWithRed:76.0f/255.0f green:213.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
    //cyan color
    UIColor *secondColor = [UIColor colorWithRed:74.0f/255.0f green:74.0f/255.0f blue:74.0f/255.0f alpha:1.0f];
    //darkblue
    UIColor *thirdColor = [UIColor colorWithRed:90.0f/255.0f green:111.0f/255.0f blue:140.0f/255.0f alpha:1.0f];
    [self setMainColor:mainColor];
    [self setSecondColor:secondColor];
    [self setThirdColor:thirdColor];
}

/*
 
 // yellow
 255, 180, 20
 [UIColor colorWithRed:255.0f/255.0f green:180.0f/255.0f blue:20.0f/255.0f alpha:1.0f];
 //pink
 255, 116, 20
 [UIColor colorWithRed:255.0f/255.0f green:116.0f/255.0f blue:20.0f/255.0f alpha:1.0f];
 //orange
 255, 0, 70
 
 //
 [UIColor colorWithRed:255.0f/255.0f green:78.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
 
 [UIColor colorWithRed:255.0f/255.0f green:140.0f/255.0f blue:122.0f/255.0f alpha:1.0f];
 
 //[UIColor colorWithRed:0.0f/255.0f green:186.0f/255.0f blue:149.0f/255.0f alpha:1.0f];
 
 [UIColor colorWithRed:0.0f/255.0f green:135.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
 
 //light blue
 [UIColor colorWithRed:2.0f/255.0f green:201.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
 
 // robin hood green
 [UIColor colorWithRed:2.0f/255.0f green:201.0f/255.0f blue:144.0f/255.0f alpha:1.0f];
 
 //robinhood highlight green
 [UIColor colorWithRed:53.0f/255.0f green:255.0f/255.0f blue:191.0f/255.0f alpha:1.0f];
 
 // purple
 [UIColor colorWithRed:108.0f/255.0f green:0.0f/255.0f blue:247.0f/255.0f alpha:1.0f];
 */

+ (ColorScheme *)defaultScheme
{
    ColorScheme *defaultScheme = [ColorScheme new];
    [defaultScheme setColors];
    return defaultScheme;
}

@end
