//
//  ItemCell.m
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

// D E P R E C A T E D

#import "ItemCell.h"

@implementation ItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(Item *)item{
    _item = item;
    self.nameLabel.text = item.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
