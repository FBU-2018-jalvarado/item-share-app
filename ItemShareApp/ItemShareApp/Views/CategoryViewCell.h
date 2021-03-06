//
//  CategoryViewCell.h
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

@interface CategoryViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *blackTint;
@property (strong, nonatomic) Category *cat;

- (void) setCategory:(NSString *)keyString;
@end
