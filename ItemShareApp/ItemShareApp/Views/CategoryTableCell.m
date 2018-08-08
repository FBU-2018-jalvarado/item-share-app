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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setCategory:(NSString *)categoryName {
    self.nameLabel.text = categoryName;
    
    Category *cat = [[Category alloc] init];
    cat.setCats;
    NSDictionary *iconDict = [[NSDictionary alloc] init];
    iconDict = [cat.iconDict copy];
    NSString *catvalstring = iconDict[[NSString stringWithFormat:@"%@", categoryName]];
    self.icon.image = [UIImage imageNamed:catvalstring];
}
@end
