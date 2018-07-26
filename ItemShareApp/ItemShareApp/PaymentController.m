////
////  PaymentController.m
////  item-share-app
////
////  Created by Nicolas Machado on 7/25/18.
////  Copyright © 2018 FBU-2018. All rights reserved.
////
//
//#import "PaymentController.h"
//
//@interface PaymentController () <STPPaymentCardTextFieldDelegate, STPEphemeralKeyProvider>
//@property (strong, nonatomic) STPPaymentCardTextField *paymentCardTextField;
//@property (strong, nonatomic) UIButton *payButton;
//@property (strong, nonatomic) STPCard *card;
//@property (strong, nonatomic) STPCardParams *params;
//@property (strong, nonatomic) NSString *baseURLString;
//@property (strong, nonatomic) NSURL *baseURL;
//@property (strong, nonatomic) NSString *secretKey;
//@property (strong, nonatomic) UIButton *buyButton;
////@property (strong, nonatomic) NSString *hey = @"hey";
//
//
////secret key: sk_test_MjyFzJARb2W8Hv64H0S6xkDw
////"/v1/charges/ch_1CpUe7COBvIU783dD9UyWCWB/refunds"
////https://api.stripe.com
//
//@end
//
//@implementation PaymentController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // Setup payment card text field
//    self.paymentCardTextField = [[STPPaymentCardTextField alloc] init];
//    self.paymentCardTextField.delegate = self;
//    
//    // Add payment card text field to view
//    [self.view addSubview:self.paymentCardTextField];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark STPPaymentCardTextFieldDelegate
//
//- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField {
//    // Toggle buy button state
//    self.buyButton.enabled = textField.isValid;
//}
//
//
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
////(void(^)(NSArray<Item *> *bookings, NSError *error))completion{
//- (void)submitTokenToBackend: (STPToken*)token completion:(void(^)(NSError *error))completion {
//    
//}
//
//- (void)handlePaymentMethodsButtonTapped {
//    // Setup customer context
//   // STPCustomerContext *customerContext = [[STPCustomerContext alloc] initWithKeyProvider:[MyKeyProvider shared]];
//    
//    // Setup payment methods view controller
//  //  STPPaymentMethodsViewController *paymentMethodsViewController = [[STPPaymentMethodsViewController alloc] initWithConfiguration:[STPPaymentConfiguration sharedConfiguration] theme:[STPTheme defaultTheme] customerContext:customerContext delegate:self];
//    
//    // Present payment methods view controller
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:paymentMethodsViewController];
//    [self presentViewController:navigationController animated:YES completion:nil];
//}
//
//#pragma mark STPPaymentMethodsViewControllerDelegate
//
//- (void)paymentMethodsViewController:(STPPaymentMethodsViewController *)paymentMethodsViewController didFailToLoadWithError:(NSError *)error {
//    // Dismiss payment methods view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    // Present error to user...
//}
//
//- (void)paymentMethodsViewControllerDidCancel:(STPPaymentMethodsViewController *)paymentMethodsViewController {
//    // Dismiss payment methods view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)paymentMethodsViewControllerDidFinish:(STPPaymentMethodsViewController *)paymentMethodsViewController {
//    // Dismiss payment methods view controller
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)paymentMethodsViewController:(STPPaymentMethodsViewController *)paymentMethodsViewController didSelectPaymentMethod:(id<STPPaymentMethod>)paymentMethod {
//    // Save selected payment method
//  //  self.selectedPaymentMethod = paymentMethod;
//}
//
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
//- (void)createCustomerKeyWithAPIVersion:(nonnull NSString *)apiVersion completion:(nonnull STPJSONResponseCompletionBlock)completion {
//    //hji
//}
//@end
