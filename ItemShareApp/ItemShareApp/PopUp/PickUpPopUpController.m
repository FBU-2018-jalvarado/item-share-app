//
//  PickUpPopUpController.m
//  item-share-app
//
//  Created by Nicolas Machado on 8/6/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PickUpPopUpController.h"

@interface PickUpPopUpController ()

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@end

@implementation PickUpPopUpController


- (void)viewDidLoad {
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.backgroundColor = [UIColor whiteColor];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    self.itemLabel.text = self.itemName;
}


- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)closePopup:(id)sender {
    NSLog(@"YEEt");
    [self removeAnimate];
    [self.pickUpPopUpDelegate dismiss];
}

- (IBAction)close:(id)sender {
    NSLog(@"tapped");
    [self removeAnimate];
    [self.pickUpPopUpDelegate dismiss];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

@end
