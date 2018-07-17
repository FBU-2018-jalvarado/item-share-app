//
//  ItemCell.h
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/16/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

//@property (strong, nonatomic) Item *item;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) NSString *name;

- (void)setItem:(NSString *)name;

@end