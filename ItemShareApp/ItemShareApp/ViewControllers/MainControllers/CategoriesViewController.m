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
#import "ColorScheme.h"
#import "CategoriesFlowLayout.h"
#import "Category.h"

@interface CategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *categoryCollView;
@property (strong, nonatomic) NSDictionary *testDictionary;
@property (strong, nonatomic) NSString *storedKey;
@property (strong, nonatomic) NSMutableArray *categoriesArray;
@property BOOL anotherCategory;
@property (strong, nonatomic) CategoryViewCell *viewCell;
@property (strong, nonatomic) ColorScheme *colors;
@property (strong, nonatomic) NSMutableArray *arrayOfKeys;
@property (strong, nonatomic) NSMutableArray *itemarray;
@property (weak, nonatomic) IBOutlet UIView *searchResultsView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *catView;

@property (strong, nonatomic) NSArray *lastCats;


@end

@implementation CategoriesViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.colors = [ColorScheme defaultScheme];
}

- (void)viewDidAppear:(BOOL)animated {
    if([self.title isEqualToString:@"What are you looking for?"] || [self.title isEqualToString:@"Classify the item"])
    {
        //[self.delegate showHUD];
        [self.delegate fetchItems];
//        [self.delegate filterInMap];
    }
    else {
        [self.delegate callChoseCat:self.title];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Category *cat = [Category new];
    [cat setCats];
    self.lastCats = cat.lastLevel;
    //self.catView.backgroundColor = self.colors.mainColor;
    
    self.itemarray = [[NSMutableArray alloc] init];
    self.categoryCollView.delegate = self;
    self.categoryCollView.dataSource = self;
    //self.categoryCollView.backgroundColor = self.colors.mainColor;
    //self.view.backgroundColor = self.colors.mainColor;
    //self.searchResultsView.backgroundColor = [self.colors.mainColor colorWithAlphaComponent:0.8];
    self.searchResultsView.layer.cornerRadius = 8;
    //self.topView.backgroundColor = self.colors.mainColor;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.colors setColors];
    
    //Cell organization and formatting
    //UICollectionViewFlowLayout *layout = [[CategoriesFlowLayout alloc] init];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.categoryCollView.collectionViewLayout;

    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

    CGFloat postersPerLine = 3;
    CGFloat itemWidth = ((self.categoryCollView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine-1) - 10) / postersPerLine);
    CGFloat itemHeight = ((self.categoryCollView.frame.size.height - layout.minimumInteritemSpacing - 10) / 2);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // try
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.categoryCollView.collectionViewLayout;
//
//    CGFloat itemWidth = (self.categoryCollView.frame.size.width / 2.5);
//    CGFloat itemHeight = self.categoryCollView.frame.size.height-15;
//    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    Category *category = [[Category alloc] init];
    [category setCats];
    //only set the Dictionary if it is the first page of categories
    if(self.firstPage)
    {
        self.categories = category.catDict;
    }
    NSArray *arrayOfKeysNM = [self.categories allKeys];
    self.arrayOfKeys = [[NSMutableArray alloc] init];
    for(NSString *name in arrayOfKeysNM)
    {
        [self.arrayOfKeys addObject:name];
    }
    self.arrayOfKeys = [self sortCats:self.arrayOfKeys];
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
//    if(![[self.arrayOfKeys firstObject] isEqualToString:@"Back"])
//    {
//        [self.arrayOfKeys insertObject:@"Back" atIndex:0];
//    }
    [cell setCategory:self.arrayOfKeys[indexPath.item]];
//    NSMutableArray *sortedKeys = [[NSMutableArray alloc] init];
//    sortedKeys = [self sortCats:self.arrayOfKeys];
//    [cell setCategory:sortedKeys[indexPath.item]];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = self.colors.mainColor;
    cell.selectedBackgroundView = selectionColor;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    // if they click on the back category
//    if(indexPath.item == 0)
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//
    [self.view endEditing:YES];
    //[self.delegate showHUD];
    
    NSArray *arrayOfKeys = [self.categories allKeys];
    NSString *clickedKey = arrayOfKeys[indexPath.item];
    if([self.lastCats containsObject:clickedKey]) {
        [self.delegate callChoseCat:clickedKey];
        [self.delegate goToMap:YES];
    }
    
    if([self.categories[clickedKey] isKindOfClass:[NSString class]])
    {
        if(self.sellDelegate)
        {
            [self.sellDelegate addCategory:clickedKey];
        }
//        [self.delegate goToMap];
    }
    else {
        CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
        categoriesViewController.categories = self.categories[(NSString *)clickedKey];
        [self.sellDelegate addCategory:clickedKey];
        categoriesViewController.title = clickedKey;
        categoriesViewController.firstPage = NO;
        categoriesViewController.delegate = self.delegate;
        categoriesViewController.sellDelegate = self.sellDelegate;
        [self.navigationController pushViewController:categoriesViewController animated:YES];
        [self.categoryCollView deselectItemAtIndexPath:indexPath animated:YES];
    }
    //[self.delegate callChoseCat:clickedKey];
}

- (NSMutableArray *)sortCats:(NSMutableArray *)catNames {
    BOOL otherIsACategory = NO;
    NSString *other;
    NSString *test;
    NSMutableArray *sorted = [[NSMutableArray alloc] init];
    for(NSString *str in catNames)
    {
        if(str.length >= 5)
        {
            test = [str substringWithRange:NSMakeRange(0,5)];
        }
        else {
            test = @"nope";
        }
        if([test isEqualToString:@"Other"])
        {
            other = str;
            otherIsACategory = YES;
        }
        else {
            if(str)
            {
                [sorted addObject:str];
            }
        }
    }
    if(other)
    {
        [sorted addObject:other];
    }
    return sorted;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
