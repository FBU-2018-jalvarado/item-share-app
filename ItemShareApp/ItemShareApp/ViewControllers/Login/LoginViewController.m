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
#import <CCTextFieldEffects/CCTextFieldEffects.h>
#import <CCTextFieldEffects/CCTextField.h>

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) HoshiTextField *usernameTextField;
@property (strong, nonatomic) HoshiTextField *passwordTextField;
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
    // Do any additional setup after loading the view.
    [self init];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.colors setColors];
//    [self setUpUI];
//    [self setUpGradient];
    [self setUpUsernameField];
    [self setupPasswordField];
}

-(void) setUpUsernameField {
    // Recommended frame height is around 70.
    self.usernameTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(30, 124, 315, 70)];
    self.usernameTextField.placeholder = @"username";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.usernameTextField.placeholderFontScale = 0.65;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.usernameTextField.borderInactiveColor = [UIColor colorWithRed:(185 / 255) green:(193 / 255) blue:(202 / 255) alpha:1];
    
    // The color of the active border, default value is R106 G121 B137
    self.usernameTextField.borderActiveColor = [UIColor colorWithRed:(106/255) green:(121/255) blue:(137/255) alpha:1];
    
    // The color of the placeholder, default value is R185 G193 B202
    self.usernameTextField.placeholderColor = [UIColor colorWithRed:(185/255) green:(193/255) blue:(202/255) alpha:1];
    
    // The color of the cursor, default value is R89 G95 B110
    self.usernameTextField.cursorColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    // The color of the text, default value is R89 G95 B110
    self.usernameTextField.textColor = [UIColor colorWithRed:(89/255) green:(95/255) blue:(110/255) alpha:1];
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.usernameTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.usernameTextField.didEndEditingHandler = ^{
        // ...
    };
    
    [self.view addSubview:self.usernameTextField];
}

- (void) setupPasswordField {
    /* summary of colors for easy distinction of different parts of text field:
     inactive border = red
     active border = green
     placeholder = blue
     cursor = blue + red = purple
     text = red + green = yellow (?)
     */
    
    // Recommended frame height is around 70.
    self.passwordTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(30, 210, 315, 70)];
    self.passwordTextField.placeholder = @"password";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.passwordTextField.placeholderFontScale = 0.65;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.passwordTextField.borderInactiveColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    // The color of the active border, default value is R106 G121 B137
    self.passwordTextField.borderActiveColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
    
    // The color of the placeholder, default value is R185 G193 B202
    self.passwordTextField.placeholderColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    
    // The color of the cursor, default value is R89 G95 B110
    self.passwordTextField.cursorColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:1];
    
    // The color of the text, default value is R89 G95 B110
    self.passwordTextField.textColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
    
    // make it a secure entry text field
    [self.passwordTextField setSecureTextEntry:true];

    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.passwordTextField.didBeginEditingHandler = ^{
        // ...
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.passwordTextField.didEndEditingHandler = ^{
        // ...
    };
    
//    [self.passwordTextField isSecureTextEntry:TRUE];
    
    [self.view addSubview:self.passwordTextField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


- (IBAction)didTapLogin:(id)sender {
    // TODO OPTIONAL: alert if fields (username/pw) not filled in
    [self loginUser];
}
//- (IBAction)didTapRegister:(id)sender {
//    // TODO OPTIONAL: make clicking the register button take you to a different view controller to properly register with an email and stuff
//    [self registerUser];
//}

- (void)setUpUI{
//    self.usernameTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
    self.passwordTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
//    self.emailTextField.layer.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.2f].CGColor;
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

//- (void) registerUser {
//    // initialize a user object
//    User *newUser = (User*)[PFUser user];
//    newUser[@"customer_id"] = @"customer_id1";
//    
//    // set user properties
//    newUser.username = self.usernameTextField.text;
//    newUser.password = self.passwordTextField.text;
//    newUser.email = self.emailTextField.text;
//    
//    // call sign up function on the object
//    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
//        if (error != nil) {
//            NSLog(@"Error: %@", error.localizedDescription);
//        } else {
//            NSLog(@"User registered successfully");
//            [User postUser:@"name" withEmail:newUser.email withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//                if(error){
//                    NSLog(@"%@", error);
//                }
//                else{
//                    [self performSegueWithIdentifier:@"mapSegue" sender:nil];
//                }
//            }];
//        }
//    }];
//}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
