//
//  PreviousViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PreviousViewController.h"
#import "CategoriesViewController.h"

@interface PreviousViewController ()

@end

@implementation PreviousViewController

- (IBAction)onTap:(id)sender {
    //    [self performSegueWithIdentifier:@"hi", sender];
    [self performSegueWithIdentifier:@"prevSegue" sender:(sender)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    CategoriesViewController *categoriesViewController = [segue destinationViewController];
    //    categoriesViewController.firstPage = YES;
//    UINavigationController *navVC = [segue destinationViewController];
//    CategoriesViewController *categoriesViewController = navVC.viewControllers[0];
//    categoriesViewController.firstPage = YES;
//    categoriesViewController.title = @"Categories";
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
