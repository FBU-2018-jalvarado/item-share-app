//
//  MGItemHistoryCell.h
//  item-share-app
//
//  Created by Tarini Singh on 8/1/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "MGSwipeTableCell.h"
#import "Item.h"
#import <ParseUI/ParseUI.h>

@interface MGItemHistoryCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *iconView;

@property (strong, nonatomic) Item *item;
@end
