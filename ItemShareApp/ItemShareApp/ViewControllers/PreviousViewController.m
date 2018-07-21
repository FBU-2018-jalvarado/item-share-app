//
//  PreviousViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PreviousViewController.h"
#import "CategoriesViewController.h"
#import "PlaceholdViewController.h"

@interface PreviousViewController ()
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation PreviousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tapToShowSearchView:(id)sender {
    self.searchView.alpha = 1;
//    [self.searchView performSegueWithIdentifier:@"showSearchViewSegue" sender:nil];
}

- (void)dismissToMap {
    self.searchView.alpha = 0;
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"showSearchViewSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        PlaceholdViewController *placeholdViewController = navVC.viewControllers[0];
        placeholdViewController.delegate = self;
    }
    //placeholdViewController.title = @"Categories";
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
