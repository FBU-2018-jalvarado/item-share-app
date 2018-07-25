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

@interface DetailsViewController : UIViewController

@property (strong, nonatomic) Item *item;
@property (strong, nonatomic) NSDate *selectedStartDate;
@property (strong, nonatomic) NSDate *selectedEndDate;


@end
