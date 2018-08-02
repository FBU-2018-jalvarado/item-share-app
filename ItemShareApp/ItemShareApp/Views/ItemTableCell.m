//
//  ItemTableCell.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ItemTableCell.h"

@implementation ItemTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.icon.layer.cornerRadius = 17;
    self.icon.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setItem:(NSString *)itemName  withAddress:(NSString *)address{
    self.nameLabel.text = itemName;
    self.distanceLabel.text = @"0.2 miles";
}
@end
