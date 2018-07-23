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
    self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y +450, self.searchView.frame.size.width, self.searchView.frame.size.height);
    // Do any additional setup after loading the view.
}

- (IBAction)swipeDown:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y +450, self.searchView.frame.size.width, self.searchView.frame.size.height);
    }];
}

- (IBAction)swipeUp:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y -450, self.searchView.frame.size.width, self.searchView.frame.size.height);
    }];
}

- (void)dismissToMap {
    [UIView animateWithDuration:1.0 animations:^{self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y +450, self.searchView.frame.size.width, self.searchView.frame.size.height);
    }];
    //self.searchView.alpha = 0;
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
//        UINavigationController *navVC = [segue destinationViewController];
//        PlaceholdViewController *placeholdViewController = navVC.viewControllers[0];
        PlaceholdViewController *placeholdViewController =
[segue destinationViewController];        placeholdViewController.delegate = self;
    }
    //placeholdViewController.title = @"Categories";
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
