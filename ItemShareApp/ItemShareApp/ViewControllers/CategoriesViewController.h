//
//  CategoriesViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoriesViewControllerDelegate

- (void)goToMap;

@end

@interface CategoriesViewController : UIViewController

@property (strong, nonatomic) NSDictionary *categories;
@property BOOL firstPage;
@property (nonatomic, weak) id <CategoriesViewControllerDelegate> delegate;


@end
