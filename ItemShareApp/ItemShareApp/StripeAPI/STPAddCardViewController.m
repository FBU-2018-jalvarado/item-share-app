////
////  STPAddCardViewController.m
////  item-share-app
////
////  Created by Tarini Singh on 7/25/18.
////  Copyright © 2018 FBU-2018. All rights reserved.
////
//
//#import "STPAddCardViewController.h"
//#import <Stripe/Stripe.h>
//
//@interface STPAddCardViewController ()
//
//@end
//
//@implementation STPAddCardViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)handleAddPaymentMethodButtonTapped {
//    // Setup add card view controller
//    STPAddCardViewController *addCardViewController = [[STPAddCardViewController alloc] init];
//    addCardViewController.delegate = self;
//
//    // Present add card view controller
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addCardViewController];
//    [self presentViewController:navigationController animated:YES completion:nil];
//}
//
//#pragma mark STPAddCardViewControllerDelegate
//
//- (void)addCardViewControllerDidCancel:(STPAddCardViewController *)addCardViewController {
//    // Dismiss add card view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)addCardViewController:(STPAddCardViewController *)addCardViewController didCreateToken:(STPToken *)token completion:(STPErrorBlock)completion {
//    [self submitTokenToBackend:token completion:^(NSError *error) {
//        if (error) {
//            // Show error in add card view controller
//            completion(error);
//        }
//        else {
//            // Notify add card view controller that token creation was handled successfully
//            completion(nil);
//
//            // Dismiss add card view controller
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
