//
//  PlaceholdViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PlaceholdViewController.h"
#import "CategoriesViewController.h"

@interface PlaceholdViewController ()
@property (weak, nonatomic) IBOutlet UIView *categoryCollV;
@property (weak, nonatomic) IBOutlet UIView *catAndItemTableV;


@end

@implementation PlaceholdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.categoryCollV.view
    // Do any additional setup after loading the view.
}

- (IBAction)onTapMap:(id)sender {
    [self performSegueWithIdentifier:@"MapSegue" sender:sender];
}

- (void)goToMap {
    [self performSegueWithIdentifier:@"MapSegue" sender:nil];
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
    if([segue.identifier isEqualToString:@"CategoryCollectionSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        CategoriesViewController *categoriesViewController = navVC.viewControllers[0];
        categoriesViewController.firstPage = YES;
        categoriesViewController.title = @"Categories";
        categoriesViewController.delegate = self;
    }
}


@end
