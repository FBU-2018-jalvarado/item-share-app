//
//  CategoryTableCell.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CategoryTableCell.h"
#import "Category.h"

@implementation CategoryTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cat = [[Category alloc] init];
    [self.cat setCats];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCategory:(NSString *)categoryName {
    self.nameLabel.text = categoryName;
    NSString *catvalstring = self.cat.iconDict[[NSString stringWithFormat:@"%@", categoryName]];
    self.icon.image = [UIImage imageNamed:catvalstring];
}
@end
