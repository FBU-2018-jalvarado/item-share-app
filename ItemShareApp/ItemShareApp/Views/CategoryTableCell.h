//
//  CategoryTableCell.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategoryTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) Category *cat;

- (void) setCategory:(NSString *)categoryName;

@end
