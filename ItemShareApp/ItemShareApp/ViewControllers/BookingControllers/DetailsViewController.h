//
//  DetailsViewController.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "CalendarViewController.h"

@protocol DetailsViewControllerDelegate

- (void)sendDirectionRequestToMap: (Item *)item;

@end

@interface DetailsViewController : UIViewController

@property (nonatomic, weak) id <DetailsViewControllerDelegate> detailsDelegate;
@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSDate *selectedStartDate;
@property (strong, nonatomic) NSDate *selectedEndDate;


@end
