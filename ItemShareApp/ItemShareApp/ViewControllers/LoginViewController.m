//
//  LoginViewController.m
//  item-share-app
//
//  Created by Tarini Singh on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (IBAction)didTapLogin:(id)sender {
    // TODO OPTIONAL: alert if fields (username/pw) not filled in
    [self loginUser];
}
- (IBAction)didTapRegister:(id)sender {
    // TODO OPTIONAL: make clicking the register button take you to a different view controller to properly register with an email and stuff
    [self registerUser];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loginUser {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil)
        {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        }
         else
         {
            NSLog(@"User logged in successfully");
            // display view controller that needs to shown after successful login
//            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void) registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
//            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
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
