//
//  AppDelegate.m
//  ItemShareApp
//
//  Created by Nicolas Machado on 7/6/18.
//  Copyright © 2018 Nicolas Machado. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
//#import <Stripe/Stripe.h>
#import "User.h"
@import GoogleMaps;
@import GooglePlaces;
#import "ColorScheme.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//secret key: sk_test_MjyFzJARb2W8Hv64H0S6xkDw
//"/v1/charges/ch_1CpUe7COBvIU783dD9UyWCWB/refunds"
//https://api.stripe.com


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [GMSServices provideAPIKey:@"AIzaSyDWcPqlz31jbQEqzivaqzfoFZc3BeJbqwk"]; //AIzaSyDWcPqlz31jbQEqzivaqzfoFZc3BeJbqwk is google map api key
    [GMSPlacesClient provideAPIKey:@"AIzaSyDWcPqlz31jbQEqzivaqzfoFZc3BeJbqwk"];
    
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        // set config keys etc.
        configuration.applicationId = @"itemshareId";
        configuration.clientKey = @"itemshareMaster";
        configuration.server = @"https://item-share.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    
    // if the user has already logged in then just go straight to feed
    if (PFUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CategoriesStoryboard" bundle:nil];
        
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    }
    
//    // Set up user ish
//    User *user = (User *)[PFUser currentUser];
//    user.email = @"purpleluvur@gmail.com";
//    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"error saving user");
//        }
//        else {
//            NSLog(@"user successfully saved");
//        }
//    }];
    
    //STRIPE
//    [Stripe setDefaultPublishableKey:@"pk_test_rb7fRQNGpRY8vrrc2EkQEfif"];
     UIColor *mainColor =  [UIColor colorWithRed:76.0f/255.0f green:213.0f/255.0f blue:175.0f/255.0f alpha:1.0f];
    //[[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_rb7fRQNGpRY8vrrc2EkQEfif"];
    // do any other necessary launch configuration
    //[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:mainColor];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
//    [[UINavigationBar appearance] setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont fontWithName:@"System-Bold" size:21]}];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
