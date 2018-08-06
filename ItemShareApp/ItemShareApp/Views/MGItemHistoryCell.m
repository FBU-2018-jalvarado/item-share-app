//
//  MGItemHistoryCell.m
//  item-share-app
//
//  Created by Tarini Singh on 8/1/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "MGItemHistoryCell.h"

@implementation MGItemHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setItem:(Item *)item {
    _item = item;
    self.itemTitle.text = self.item.title;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", self.item.price];
    self.addressLabel.text = self.item.address;
    self.descriptionLabel.text = self.item.descrip;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
