//
//  CategoriesViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoryViewCell.h"
#import "MapViewController.h"
#import "Category.h"

@interface CategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollView;
@property (strong, nonatomic) NSDictionary *testDictionary;
@property (strong, nonatomic) NSString *storedKey;
@property BOOL anotherCategory;
@property (strong, nonatomic) CategoryViewCell *viewCell;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryCollView.delegate = self;
    self.categoryCollView.dataSource = self;
    // Do any additional setup after loading the view.
    
    //Cell organization and formatting
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.categoryCollView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    
    CGFloat postersPerLine = 5;
    CGFloat itemWidth = (self.categoryCollView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
    CGFloat itemHeight = itemWidth*3 / 4;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    Category *category = [[Category alloc] init];
    [category setCats];
    //only set the Dictionary if it is the first page of categories
    if(self.firstPage)
    {
        self.categories = category.catDict;
    }
    //    NSLog(@"%@", self.categories);
    [self.categoryCollView reloadData];
}

- (IBAction)onTapMap:(id)sender {
    [self performSegueWithIdentifier:@"MapSegue" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nonnull __kindof CategoryViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCell" forIndexPath:indexPath];
    NSArray *arrayOfKeys = [self.categories allKeys];
    [cell setCategory:arrayOfKeys[indexPath.item]];
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrayOfKeys = [self.categories allKeys];
    NSString *clickedKey = arrayOfKeys[indexPath.item];
    if([self.categories[clickedKey] isKindOfClass:[NSString class]])
    {
        //[self dismissViewControllerAnimated:true completion:nil];
        //[self.delegate goToMap];
        [self.delegate goToMap];
    }
    else {
        CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
        categoriesViewController.categories = self.categories[(NSString *)clickedKey];
//        NSLog(@"%@", self.categories);
//        NSLog(@"midpoint");
//        NSLog(@"%@", categoriesViewController.categories);
        categoriesViewController.title = clickedKey;
        categoriesViewController.firstPage = NO;
        categoriesViewController.delegate = self.delegate;
        [self.navigationController pushViewController:categoriesViewController animated:YES];
    }
    [self.delegate callChoseCat:clickedKey];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //    if([segue.identifier isEqualToString:@"NextCategorySegue"])
    //    {
    //        CategoryViewCell *tappedCell = sender;
    //        NSIndexPath *indexPath = [self.categoryCollView indexPathForCell:tappedCell];
    //        NSArray *arrayOfKeys = [self.categories allKeys];
    //        NSString *clickedKey = arrayOfKeys[indexPath.item];
    //
    ////        // Decide if we have reached the lowest level
    //        self.storedKey = clickedKey;
    //        self.anotherCategory = [self shouldPerformSegueWithIdentifier:@"NextCategorySegue" sender:sender];
    //        if(self.anotherCategory)
    //        {
    //            // Deal with the next category view controller
    //            CategoriesViewController *categoriesViewController = [segue destinationViewController];
    //            categoriesViewController.categories = [[NSDictionary alloc] init];
    //            categoriesViewController.categories = self.categories[(NSString *)clickedKey];
    //            NSLog(@"%@", self.categories);
    //            NSLog(@"midpoint");
    //            NSLog(@"%@", categoriesViewController.categories);
    //            categoriesViewController.title = clickedKey;
    //            categoriesViewController.firstPage = NO;
    //        }
    //        else {
    //            [self performSegueWithIdentifier:@"MapSegue" sender:sender];
    //            //[segue.identifier isEqualToString:@"MapSegue"];
    ////            MapViewController *mapViewController = [segue destinationViewController];
    ////            self.mapView.showsUserLocation = YES;
    ////            [mapViewController.mapView setRegion:currentRegion animated:false];
    //        }
    //    }
    if([segue.identifier isEqualToString:@"MapSegue"])
    {
        // pass info to map view
        // should it be just clickedKey or entire dictionary below this point???
        NSArray *arrayOfKeys = [self.categories allKeys];
        NSString *clickedKey = self.title;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

// Checks if this is the last level
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if([self.categories[self.storedKey] isKindOfClass:[NSString class]])
//    {
//        return NO;
//    }
//    return YES;
//}

@end
