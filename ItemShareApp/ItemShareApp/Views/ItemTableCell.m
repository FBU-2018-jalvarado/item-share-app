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
    self.cat = [[Category alloc] init];
    [self.cat setCats];
    
    self.icon.layer.cornerRadius = 0;
    self.icon.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setItem:(Item *)item{
    _item = item;
    self.nameLabel.text = item.title;
    self.addressLabel.text = item.address;
    [self setIconWithItem:item];
}
- (void) setIconWithItem: (Item *)item {
    NSString *catString = item.categories[2];
    NSString *iconNameString = self.cat.iconDict[[NSString stringWithFormat:@"%@", catString]];
    self.icon.image = [UIImage imageNamed:iconNameString];
}

@end
