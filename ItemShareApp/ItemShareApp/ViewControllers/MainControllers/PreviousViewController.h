//
//  PreviousViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PreviousControllerDelegate

- (void)zoomOutMap;

@end

@interface PreviousViewController : UIViewController

@property (nonatomic, weak) id <PreviousControllerDelegate> previousDelegate;
@end
