//
//  DetailsViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmPickupButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpUI];
}

- (void)setUpUI {
    self.titleLabel.text = self.item.title;
    self.addressLabel.text = self.item.address;
    self.startTimePicker.datePickerMode = UIDatePickerModeDate;
    self.endTimePicker.datePickerMode = UIDatePickerModeDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
