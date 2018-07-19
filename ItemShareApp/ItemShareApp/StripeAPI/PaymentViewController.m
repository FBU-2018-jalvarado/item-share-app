//
//  PaymentViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/19/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController () <STPPaymentCardTextFieldDelegate, STPEphemeralKeyProvider>

@property (strong, nonatomic) STPPaymentCardTextField *paymentTextField;
@property (strong, nonatomic) UIButton *payButton;
@property (strong, nonatomic) STPCard *card;
@property (strong, nonatomic) STPCardParams *params;
@property (strong, nonatomic) NSString *baseURLString;
@property (strong, nonatomic) NSURL *baseURL;
@property (strong, nonatomic) NSString *secretKey;
//@property (strong, nonatomic) NSString *hey = @"hey";


//secret key: sk_test_MjyFzJARb2W8Hv64H0S6xkDw
//"/v1/charges/ch_1CpUe7COBvIU783dD9UyWCWB/refunds"
//https://api.stripe.com

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    self.baseURLString = @"https://api.stripe.com";
    self.secretKey = @"sk_test_MjyFzJARb2W8Hv64H0S6xkDw";
    self.baseURL = [NSURL URLWithString:self.baseURLString];
    [super viewDidLoad];
    
    //add payment text field
    CGRect frame1 = CGRectMake(20, 150, self.view.frame.size.width - 40, 80);
    self.paymentTextField = [[STPPaymentCardTextField alloc] initWithFrame:frame1];
    self.paymentTextField.center = self.view.center;
    self.paymentTextField.delegate = self;
    [self.view addSubview:self.paymentTextField];
    
    // add pay button
    CGRect frame2 = CGRectMake(20, 450, self.view.frame.size.width - 40, 80);
    self.payButton = [[UIButton alloc] initWithFrame:frame2];
    [self.payButton setTitle:@"Pay $20" forState:UIControlStateNormal];
    self.payButton.backgroundColor = [UIColor greenColor];
    [self.payButton addTarget:self action:@selector(createToken) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.payButton];
    
    
    
}

- (void)createToken{
    self.params = [[STPCardParams alloc] init];
    self.params.number = self.paymentTextField.cardNumber;
    self.params.cvc = self.paymentTextField.cvc;
    self.params.expMonth = self.paymentTextField.expirationMonth;
    self.params.expYear = self.paymentTextField.expirationYear;
    
    //check if card is valid
    if([STPCardValidator validationStateForCard:self.params] == STPCardValidationStateValid){
        [self performStripeOperation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performStripeOperation{
    //get stripe token for current card
//    [[STPPaymentConfiguration sharedConfiguration];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

     - (void)createCustomerKeyWithAPIVersion:(nonnull NSString *)apiVersion completion:(nonnull STPJSONResponseCompletionBlock)completion {
         NSURL *url = [self.baseURL URLByAppendingPathComponent:@"ephemeral_keys"];
         AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
         [manager POST:url.absoluteString
            parameters:@{@"api_version": apiVersion}
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   completion(responseObject, nil);
               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                   completion(nil, error);
               }];
     }

     @end
