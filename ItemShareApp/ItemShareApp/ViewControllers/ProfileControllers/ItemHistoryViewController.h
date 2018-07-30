//
//  ItemHistoryViewController.h
//  item-share-app
//
//  Created by Tarini Singh on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *itemToFetch;
@property (weak, nonatomic) IBOutlet UIButton *itemCurrentFetch;
@property (weak, nonatomic) IBOutlet UIButton *itemPastFetch;
@property (weak, nonatomic) IBOutlet UIButton *itemsSelling;

@end
