//
//  ItemHistoryViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "ItemHistoryViewController.h"
#import "ItemHistoryDetailViewController.h"

@interface ItemHistoryViewController ()

@end

@implementation ItemHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)didTapToFetch:(id)sender {
//    [self performSegueWithIdentifier:@"showItems" sender:self.itemToFetch];
}
- (IBAction)didTapCurrentFetch:(id)sender {
//    [self performSegueWithIdentifier:@"showItems" sender:self.itemCurrentFetch];
}
- (IBAction)didTapPreviousFetch:(id)sender {
//    [self performSegueWithIdentifier:@"showItems" sender:self.itemPastFetch];
}
- (IBAction)didTapItemsSell:(id)sender {
    [self performSegueWithIdentifier:@"showItems" sender:self.itemsSelling];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (sender) {
        ItemHistoryDetailViewController *next = [segue destinationViewController];
        UIButton *button = sender;
        NSString *buttonTitle = button.titleLabel.text;
        next.buttonTitle = buttonTitle;
        next.titleLabel.text = @"hello";
        if ([buttonTitle isEqualToString:@"items to fetch later"]){
            next.historyType = @"itemsFutureRent";
        }
        else if ([buttonTitle isEqualToString:@"items currently fetching"]){
            next.historyType = @"itemsCurrentRent";
        }
        else if ([buttonTitle isEqualToString:@"items previously fetched"]){
            next.historyType = @"itemsPreviousRent";
        }
        else if ([buttonTitle isEqualToString:@"items selling"]){
            next.historyType = @"itemsSelling";
        }
    }
  
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
