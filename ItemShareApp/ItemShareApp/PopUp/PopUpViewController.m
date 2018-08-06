//
//  PopUpViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/25/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PopUpViewController.h"
#import "ColorScheme.h"

@interface PopUpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *directionsButton;
@property (strong, nonatomic) ColorScheme *colorModel;
@end

@implementation PopUpViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colorModel = [ColorScheme new];
    }
    return self;
}

- (void)viewDidLoad {
    [self init];
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.popUpView.backgroundColor = [UIColor whiteColor];
    self.popUpView.layer.cornerRadius = 5;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    self.buttonLabel.layer.cornerRadius = 5;
//    self.nameLabel.textColor = [UIColor blackColor];
//    self.messageLabel.textColor = [UIColor blackColor];
    
    self.popUpView.layer.borderWidth = 7;
    self.popUpView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    self.directionsButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.directionsButton.layer.borderWidth = 1;
    self.directionsButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:13];
    self.buttonLabel.layer.borderColor = [UIColor blueColor].CGColor;
    self.buttonLabel.layer.borderWidth = 1;
    self.buttonLabel.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:13];
   // [self.buttonLabel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
     [self.buttonLabel setTitleColor:self.colorModel.mainColor forState:UIControlStateNormal];
    
    self.nameLabel.text = self.item.title;
    self.firstNameLabel.text = self.owner.firstName;
    self.lastNameLabel.text = self.owner.lastName;
    self.phoneLabel.text = self.owner.phoneNumber;
    self.addressLabel.text = self.item.address;
    
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
    [self.popUpDelegate dismiss];
    
}

- (IBAction)directionsPressed:(id)sender {
    [self.popUpDelegate askedForDirections];
}

- (IBAction)close:(id)sender {
    NSLog(@"tapped");
    [self removeAnimate];
    [self.popUpDelegate dismiss];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
    if (animated) {
        [self showAnimate];
    }
}

@end
