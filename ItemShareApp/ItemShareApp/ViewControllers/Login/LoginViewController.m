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
#import <FLAnimatedImage/FLAnimatedImage.h>

#define GIF_WIDTH 400
#define GIF_HEIGHT 400
#define SCALE 0.4

@interface LoginViewController () <UITextFieldDelegate>

@property (strong, nonatomic) HoshiTextField *usernameTextField;
@property (strong, nonatomic) HoshiTextField *passwordTextField;
@property (strong, nonatomic) ColorScheme *colors;

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *gifView;
@property (strong, nonnull) FLAnimatedImage *gifImage;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIView *coverUp;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *boardDissTap;
@property (weak, nonatomic) IBOutlet UILabel *fetchLabel;


@end

@implementation LoginViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self init];
    self.fetchLabel.frame = CGRectMake(self.fetchLabel.frame.origin.x, self.fetchLabel.frame.origin.y - 100, self.fetchLabel.frame.size.width, self.fetchLabel.frame.size.height);
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    [self.colors setColors];
    [self setUpUI];
//    [self setUpGradient];
    [self setUpUsernameField];
    [self setupPasswordField];
    [self setUpGifView];
    [UIView animateWithDuration:0.5 animations:^{
        self.fetchLabel.frame = CGRectMake(self.fetchLabel.frame.origin.x, self.fetchLabel.frame.origin.y + 100, self.fetchLabel.frame.size.width, self.fetchLabel.frame.size.height);
    }];
    self.loginButton.tintColor = self.colors.mainColor;
    self.signUpButton.tintColor = self.colors.mainColor;
}

//textdelegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
}


- (void) setUpGifView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.gifImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://i.gifer.com/9Ou7.gif"]]];
    //FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    self.gifView.animatedImage = self.gifImage;
    //imageView.frame = CGRectMake((width / 2) - ((GIF_WIDTH * SCALE) / 2), (height / 2) - ((GIF_HEIGHT * SCALE) / 2), (GIF_WIDTH * SCALE), (GIF_HEIGHT * SCALE));
    
    //self.gifView = imageView;
}

-(void) setUpUsernameField {
    // Recommended frame height is around 70.
    self.usernameTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(30, 400, 315, 70)];
    self.usernameTextField.placeholder = @"username";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.usernameTextField.placeholderFontScale = 1.2;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.usernameTextField.borderInactiveColor = [UIColor blackColor];
    
    // The color of the active border, default value is R106 G121 B137
    self.usernameTextField.borderActiveColor = self.colors.mainColor;
    
    // The color of the placeholder, default value is R185 G193 B202
    self.usernameTextField.placeholderColor = self.colors.mainColor;
    
    // The color of the cursor, default value is R89 G95 B110
    self.usernameTextField.cursorColor = self.colors.mainColor;
    
    // The color of the text, default value is R89 G95 B110
    self.usernameTextField.textColor = [UIColor blackColor];
    
    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.usernameTextField.didBeginEditingHandler = ^{
        if(self.coverUp.alpha == 0)
        {
            [UIView animateWithDuration:0.1 animations:^{
                self.coverUp.alpha = 1;
                if(self.usernameTextField.frame.origin.y == 400)
                {
                    self.usernameTextField.frame = CGRectMake(30, 220, 315, 70);
                }
                if(self.passwordTextField.frame.origin.y == 480)
                {
                    self.passwordTextField.frame = CGRectMake(30, 300, 315, 70);
                }
//                self.usernameTextField.frame = CGRectMake(30, 220, 315, 70);
            }];
        }
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.usernameTextField.didEndEditingHandler = ^{
        
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
    self.passwordTextField = [[HoshiTextField alloc] initWithFrame:CGRectMake(30, 480, 315, 70)];
    self.passwordTextField.placeholder = @"password";
    
    // The size of the placeholder label relative to the font size of the text field, default value is 0.65
    self.passwordTextField.placeholderFontScale = 1.2;
    
    // The color of the inactive border, default value is R185 G193 B202
    self.passwordTextField.borderInactiveColor = [UIColor blackColor];
    
    // The color of the active border, default value is R106 G121 B137
    self.passwordTextField.borderActiveColor = self.colors.mainColor;
    
    // The color of the placeholder, default value is R185 G193 B202
    self.passwordTextField.placeholderColor = self.colors.mainColor;
    
    // The color of the cursor, default value is R89 G95 B110
    self.passwordTextField.cursorColor = self.colors.mainColor;
    
    // The color of the text, default value is R89 G95 B110
    self.passwordTextField.textColor = [UIColor blackColor];
    
    // make it a secure entry text field
    [self.passwordTextField setSecureTextEntry:true];

    // The block excuted when the animation for obtaining focus has completed.
    // Do not use textFieldDidBeginEditing:
    self.passwordTextField.didBeginEditingHandler = ^{
        if(self.coverUp.alpha == 0)
        {
            [UIView animateWithDuration:0.1 animations:^{
                self.coverUp.alpha = 1;
                if(self.usernameTextField.frame.origin.y == 400)
                {
                    self.usernameTextField.frame = CGRectMake(30, 220, 315, 70);
                }
                if(self.passwordTextField.frame.origin.y == 480)
                {
                    self.passwordTextField.frame = CGRectMake(30, 300, 315, 70);
                }
            }];
        }
    };
    
    // The block excuted when the animation for losing focus has completed.
    // Do not use textFieldDidEndEditing:
    self.passwordTextField.didEndEditingHandler = ^{
        
    };
    
//    [self.passwordTextField isSecureTextEntry:TRUE];
    
    [self.view addSubview:self.passwordTextField];
}

- (IBAction)tapOut:(id)sender {
    if(self.coverUp.alpha == 1)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.coverUp.alpha = 0;
            if(self.usernameTextField.frame.origin.y == 220)
            {
                self.usernameTextField.frame = CGRectMake(30, 400, 315, 70);
            }
            if(self.passwordTextField.frame.origin.y == 300)
            {
                self.passwordTextField.frame = CGRectMake(30, 480, 315, 70);
            }
        }];
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
    else {
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
}

- (IBAction)didTapLogin:(id)sender {
    // TODO OPTIONAL: alert if fields (username/pw) not filled in
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self loginUser];
}
//- (IBAction)didTapRegister:(id)sender {
//    // TODO OPTIONAL: make clicking the register button take you to a different view controller to properly register with an email and stuff
//    [self registerUser];
//}

- (void)setUpUI{
    self.loginButton.layer.borderColor = self.colors.mainColor.CGColor;
//    self.signUpButton.layer.borderColor = [UIColor orangeColor].CGColor;
    self.loginButton.layer.borderWidth = 1;
    [self.loginButton setTitleColor:self.colors.mainColor forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:self.colors.mainColor forState:UIControlStateNormal];
    //self.loginButton.titleLabel.textColor = self.colors.mainColor;
//    self.signUpButton.layer.borderWidth = 1;
    self.loginButton.layer.cornerRadius = 5;
//    self.signUpButton.layer.cornerRadius = 5;
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
