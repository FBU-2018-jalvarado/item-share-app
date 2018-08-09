//
//  PickUpPopUpController.m
//  item-share-app
//
//  Created by Nicolas Machado on 8/6/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PickUpPopUpController.h"
#import "ColorScheme.h"

@interface PickUpPopUpController ()

@property (weak, nonatomic) IBOutlet UIView *popUpView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (strong, nonatomic) ColorScheme *colorModel;

@end

@implementation PickUpPopUpController

- (void)awakeFromNib {
    self.colorModel = [ColorScheme new];
}

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
    self.okButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.okButton.layer.borderWidth = 3;
    self.okButton.layer.cornerRadius = 5;
    self.okButton.clipsToBounds = YES;
    self.popUpView.layer.borderWidth = 7;
    self.popUpView.layer.borderColor = self.colorModel.mainColor.CGColor;
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
