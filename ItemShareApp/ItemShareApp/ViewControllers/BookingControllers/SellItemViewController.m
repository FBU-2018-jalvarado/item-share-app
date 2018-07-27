//
//  SellItemViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/17/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "SellItemViewController.h"
#import "Item.h"
#import <Parse/Parse.h>
#import "User.h"

@interface SellItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemAddress;

@end

@implementation SellItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // TODO: make name field optional after login
}

- (IBAction)sellOnTap:(id)sender {
    //create and set item and user objects
    Item *itemToBeSold = [Item new];
    User *owner = (User*)[PFUser currentUser];

    [Item postItem:self.itemTitle.text withOwner:owner withLocation:nil withAddress:self.itemAddress.text withCategories:nil withDescription:nil withImage:nil withPickedUpBool:@"NO" withDistance:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Unable to post the item for sale");
        }
        else {
            NSLog(@"Posted the item for sale: ");
            [self updateSellerInformation:itemToBeSold];
        }
    }];
}

- (void)updateSellerInformation: (Item *)item{
    User *seller = (User*) [PFUser currentUser];
    [seller.itemsSelling addObject:item];
    [seller setObject:seller.itemsSelling forKey:@"itemsSelling"];
    [seller saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error); //will not work. User cannot be saved unless they have been authenticated via logIn or signUp
            // https://stackoverflow.com/questions/31087679/edit-parse-user-information-when-logged-in-as-other-user-in-android
        }
        else{
            NSLog(@"updated seller itemsSelling array");
        }
    }];
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
