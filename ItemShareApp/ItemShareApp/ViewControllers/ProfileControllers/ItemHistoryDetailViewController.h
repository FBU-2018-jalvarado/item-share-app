//
//  ItemHistoryDetailViewController.h
//  item-share-app
//
//  Created by Tarini Singh on 7/30/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemHistoryDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSString *buttonTitle;
@property (strong, nonatomic) NSString *historyType;
@end
