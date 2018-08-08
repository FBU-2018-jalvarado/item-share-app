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

@end

@implementation CategoriesViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colors = [ColorScheme new];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    if([self.title isEqualToString:@"Categories"])
    {
        [self.delegate fetchItems];
//        [self.delegate filterInMap];
    }
    else {
        [self.delegate callChoseCat:self.title];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemarray = [[NSMutableArray alloc] init];
    self.categoryCollView.delegate = self;
    self.categoryCollView.dataSource = self;
    // Do any additional setup after loading the view.
    
    [self init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.colors setColors];
    
    //Cell organization and formatting
    //UICollectionViewFlowLayout *layout = [[CategoriesFlowLayout alloc] init];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.categoryCollView.collectionViewLayout;

    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;

    CGFloat postersPerLine = 3;
    CGFloat itemWidth = (self.categoryCollView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine-1)) / postersPerLine;
    CGFloat itemHeight = (self.categoryCollView.frame.size.height - layout.minimumInteritemSpacing) / 2;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    NSLog(@"%f", itemWidth);
    NSLog(@"%f", itemHeight);
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
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor orangeColor];
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
    [self.delegate showHUD];
    
    NSArray *arrayOfKeys = [self.categories allKeys];
    NSString *clickedKey = arrayOfKeys[indexPath.item];
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
    [self.delegate callChoseCat:clickedKey];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}

@end
