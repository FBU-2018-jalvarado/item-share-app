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
#import "CategoriesViewController.h"

@interface SellItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *itemTitle;
@property (weak, nonatomic) IBOutlet UITextField *itemAddress;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (weak, nonatomic) IBOutlet UILabel *cat1;
@property (weak, nonatomic) IBOutlet UILabel *cat2;
@property (weak, nonatomic) IBOutlet UILabel *cat3;


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

    [Item postItem:self.itemTitle.text withOwner:owner withLocation:nil withAddress:self.itemAddress.text withCategories:self.categoryArray withDescription:nil withImage:nil withPickedUpBool:@"NO" withDistance:nil withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Unable to post the item for sale");
        }
        else {
            NSLog(@"Posted the item for sale: ");
            [self updateSellerInformation:itemToBeSold];
        }
        [self.categoryArray removeAllObjects];
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

// delegate function to keep track of categories an item falls under
- (void)addCategory:(NSString *)categoryName {
    [self.categoryArray addObject:categoryName];
    if(self.cat1.text == 0)
    {
        self.cat1.text = categoryName;
    }
    else {
        if(self.cat2.text == 0)
        {
            self.cat2.text = categoryName;
        }
        else {
            if(self.cat3.text == 0)
            {
                self.cat3.text = categoryName;
            }
        }
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"sellCategorySegue"])
     {
         UINavigationController *navVC = [segue destinationViewController];
         CategoriesViewController *categoriesViewController = [navVC.viewControllers firstObject];
         categoriesViewController.firstPage = YES;
         categoriesViewController.title = @"Categories";
         categoriesViewController.sellDelegate = self;
     }
 }
 

@end
