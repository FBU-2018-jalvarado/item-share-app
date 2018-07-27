//
//  RegisterViewController.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/26/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "RegisterViewController.h"
#import "User.h"
#import "ColorScheme.h"

@interface RegisterViewController () <UITextFieldDelegate>

@property (strong, nonatomic) ColorScheme *colors;


@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation RegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colors = [ColorScheme new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self init];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.firstNameTextField.delegate = self;
    self.phoneTextField.delegate = self;
    
    [self.colors setColors];
    [self setUpUI];
    [self setUpGradient];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

- (void)setUpUI{
    self.firstNameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.lastNameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.passwordTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.emailTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.phoneTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.usernameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
}
- (void)setUpGradient{
    // Create the colors
    UIColor *color1 = self.colors.mainColor;
    UIColor *color2 = self.colors.secondColor;
    UIColor *color3 = self.colors.thirdColor;
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)color2.CGColor, (id)color1.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
}

- (void) registerUser {
    // initialize a user object
    User *newUser = (User*)[PFUser user];
    newUser[@"customer_id"] = @"customer_id1";
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.phoneNumber = self.phoneTextField.text;
    newUser.firstName = self.firstNameTextField.text;
    newUser.lastName = self.lastNameTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [User postUser:newUser.firstName withLastName:newUser.lastName withPhoneNumber:newUser.phoneNumber withEmail:newUser.email withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"%@", error);
                }
                else{
                    [self performSegueWithIdentifier:@"registerMapSegue" sender:nil];
                }
            }];
        }
    }];
}

- (IBAction)registerButtonPressed:(id)sender {
    [self registerUser];
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
