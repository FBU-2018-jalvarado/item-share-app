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
//    self.addressLabel.text = self.item.address;
    [self setUpAddressLabel];
    self.descriptionLabel.text = self.item.descrip;
    if(item[@"images"] != nil){
        self.iconView.file = [item.images firstObject];
        [self.iconView loadInBackground];
        self.iconView.layer.cornerRadius = 5;
        self.iconView.clipsToBounds = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setUpAddressLabel {
    NSArray *formattedAddressarr = [self.item.address componentsSeparatedByString:@", "];
    self.addressLabel.text = formattedAddressarr[0];
    self.cityStateZipLabel.text = [NSString stringWithFormat:@"%@, %@",  formattedAddressarr[1], formattedAddressarr[2]];
    if ([self.itemTitle.text isEqualToString: @"Me"]) {
        NSLog(@"%@", formattedAddressarr);
    }
}

@end
