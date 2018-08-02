//
//  iCarouselViewController.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/31/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface iCarouselViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString *parentVC;
- (void)reload;
@end

