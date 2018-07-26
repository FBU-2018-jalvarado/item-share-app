//
//  LoginViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "ColorScheme.h"
#import "User.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) ColorScheme *colors;

@end

@implementation LoginViewController

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
    [self.colors setColors];
    [self setUpUI];
    [self setUpGradient];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogin:(id)sender {
    // TODO OPTIONAL: alert if fields (username/pw) not filled in
    [self loginUser];
}
- (IBAction)didTapRegister:(id)sender {
    // TODO OPTIONAL: make clicking the register button take you to a different view controller to properly register with an email and stuff
    [self registerUser];
}

- (void)setUpUI{
    self.usernameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.passwordTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.emailTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
}
- (void)setUpGradient{
    // Create the colors
    UIColor *color1 = self.colors.mainColor;
    UIColor *color2 = self.colors.secondColor;
    UIColor *color3 = self.colors.thirdColor;
    
    // Create the gradient
    CAGradientLayer *theViewGradient = [CAGradientLayer layer];
    theViewGradient.colors = [NSArray arrayWithObjects: (id)color2.CGColor, (id)color1.CGColor, (id)color3.CGColor, nil];
    theViewGradient.frame = self.view.bounds;
    
    //Add gradient to view
    [self.view.layer insertSublayer:theViewGradient atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [User logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil)
        {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        }
         else
         {
            NSLog(@"User logged in successfully");
             [self performSegueWithIdentifier:@"mapSegue" sender:nil];
        }
    }];
}

- (void) registerUser {
    // initialize a user object
    User *newUser = (User*)[PFUser user];
    newUser[@"customer_id"] = @"customer_id1";
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser.email = self.emailTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [User postUser:@"name" withEmail:newUser.email withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
                if(error){
                    NSLog(@"%@", error);
                }
                else{
                    [self performSegueWithIdentifier:@"mapSegue" sender:nil];
                }
            }];
        }
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
