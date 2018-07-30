//
//  ItemHistoryCell.h
//  item-share-app
//
//  Created by Tarini Singh on 7/30/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ItemHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (strong, nonatomic) Item *item;
@end
