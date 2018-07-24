//
//  PlaceholdViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceholderViewControllerDelegate

- (void)dismissToMap;

@end

@interface PlaceholdViewController : UIViewController
@property (nonatomic, weak) id <PlaceholderViewControllerDelegate> delegate;


@end
