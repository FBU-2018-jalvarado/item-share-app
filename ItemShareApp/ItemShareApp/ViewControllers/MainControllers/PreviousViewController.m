
//
//  PreviousViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/18/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <FLAnimatedImage/FLAnimatedImage.h>
#import "PreviousViewController.h"
#import "CategoriesViewController.h"
#import "PlaceholdViewController.h"
#import "MapViewController.h"
#import "ProfileViewController.h"

#define GIF_WIDTH 450
#define GIF_HEIGHT 276
#define SCALE 0.4

@interface PreviousViewController () <MapViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic ) MapViewController *mapController;
@property (weak, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property PlaceholdViewController *placeholdViewController;
@property UIVisualEffectView *blurredView;
@property (weak, nonatomic) IBOutlet UIView *mapContainerView;
@property (nonatomic, strong) FLAnimatedImage *gifImage;
@property (nonatomic, strong) FLAnimatedImageView *gifView;
@property (weak, nonatomic) IBOutlet UIView *arrowView;
@property (weak, nonatomic) IBOutlet UIImageView *grayBar;
@property (weak, nonatomic) IBOutlet UIImageView *downArrow;
@property (weak, nonatomic) IBOutlet UIImageView *upArrow;

@end

//map rename
@implementation PreviousViewController

// adjust arrow view and search view origin.y
- (void)arrowAndSearchViewMove:(int)move {
    self.searchView.frame = CGRectMake(self.searchView.frame.origin.x, self.searchView.frame.origin.y +move, self.searchView.frame.size.width, self.searchView.frame.size.height);
    self.arrowView.frame = CGRectMake(self.arrowView.frame.origin.x, self.arrowView.frame.origin.y +move, self.arrowView.frame.size.width, self.arrowView.frame.size.height);
}

// adjust table view size
- (void)tableViewMove:(int)move {
    self.placeholdViewController.catAndItemTableViewController.catAndItemTableView.frame = CGRectMake(self.placeholdViewController.catAndItemTableViewController.catAndItemTableView.frame.origin.x, self.placeholdViewController.catAndItemTableViewController.catAndItemTableView.frame.origin.y, self.placeholdViewController.catAndItemTableViewController.catAndItemTableView.frame.size.width, self.placeholdViewController.catAndItemTableViewController.catAndItemTableView.frame.size.height+move);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // move searchView to bottom to raise to top when pressed
    [self arrowAndSearchViewMove:462];
    [self moveArrows:-468];
    // move profileView out of screen to bring in later
    self.profileView.frame = CGRectMake(self.profileView.frame.origin.x -297, self.profileView.frame.origin.y, self.profileView.frame.size.width, self.profileView.frame.size.height);
    // adjust table view size
    //[self tableViewMove:-462];
    self.grayBar.alpha = 0;
    self.upArrow.alpha = 1;
    self.downArrow.alpha = 0;
    
    // HUD
    [self showHUD];
    
    // BlurView
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurredView = blurEffectView;
    //always fill the view
    blurEffectView.frame = CGRectMake(self.mapContainerView.frame.origin.x, self.mapContainerView.frame.origin.y, self.blackView.frame.size.width, self.mapContainerView.frame.size.height);
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.mapContainerView addSubview:blurEffectView];
    //if you have more UIViews, use an insertSubview API to place it where needed
    blurEffectView.alpha = 0;
    // Do any additional setup after loading the view.
    self.arrowView.backgroundColor = UIColor.clearColor;
}

- (IBAction)swipeDown:(id)sender {
    if (self.blackView.alpha == 0){
        [self dismissToMap];
    }
}
- (IBAction)arrowUp:(id)sender {
    [self showSearchView];
}

- (IBAction)arrowDown:(id)sender {
    [self dismissToMap];
}

- (IBAction)tapArrow:(id)sender {
    if(self.searchView.frame.origin.y == 611)
    {
        [self showSearchView];
    }
    else
    {
        if(self.searchView.frame.origin.y == 149)
        {
            [self dismissToMap];
        }
    }
}

-(void) showHUD {
    if (self.gifView){
        self.gifView.alpha = 1;
    }
    else {
        [self setUpGifView];
        [self.view addSubview:self.gifView];
    }
}

-(void) dismissHUD {
    self.gifView.alpha = 0;
}

-(void) setUpGifView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    self.gifImage = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://cdn-images-1.medium.com/max/1600/1*dgfd5JaT0d7JT4VfhFEnzg.gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = self.gifImage;
    imageView.frame = CGRectMake((width / 2) - ((GIF_WIDTH * SCALE) / 2), (height / 2) - ((GIF_HEIGHT * SCALE) / 2), (GIF_WIDTH * SCALE), (GIF_HEIGHT * SCALE));
    
    self.gifView = imageView;
}

// make and display HUD
//-(void) makeHUD {
//    self.HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
//    self.HUD.animation = [[JGProgressHUDFadeZoomAnimation alloc] init];
//    self.HUD.textLabel.text = @"Loading";
//    [self.HUD showInView:self.view];
//    self.placeholdViewController.HUD = self.HUD;
//    self.placeholdViewController.catAndItemTableViewController.categoriesViewController.HUD = self.HUD;
//}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)openSideProfile {
    
    if (self.profileView.frame.origin.x == -297) {
        [UIView animateWithDuration:0.5 animations:^{self.profileView.frame = CGRectMake(self.profileView.frame.origin.x +297, self.profileView.frame.origin.y, self.profileView.frame.size.width, self.profileView.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.blackView.alpha = 0.6;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{self.profileView.frame = CGRectMake(self.profileView.frame.origin.x -297, self.profileView.frame.origin.y, self.profileView.frame.size.width, self.profileView.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.blackView.alpha = 0;
        }];
    }
}

- (IBAction)swipeUp:(id)sender {
    if(self.searchView.frame.origin.y == 611)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self arrowAndSearchViewMove:-462];
            self.upArrow.alpha = 0;
            self.downArrow.alpha = 1;
            [self moveArrows:462];
            [self.placeholdViewController.searchBar becomeFirstResponder];
        }];
//        [UIView animateWithDuration:0.8 animations:^{
//            [self.placeholdViewController.searchBar becomeFirstResponder];
//        }];
        [self createBlur];
        [self.placeholdViewController showSearch];
    }
}

- (void)showSearchView {
        if(self.searchView.frame.origin.y == 611)
        {
            [UIView animateWithDuration:0.5 animations:^{
                [self arrowAndSearchViewMove:-462];
                self.upArrow.alpha = 0;
                self.downArrow.alpha = 1;
                [self moveArrows:462];
                [self.placeholdViewController.searchBar becomeFirstResponder];
            }];
            if(self.placeholdViewController.fetchView.frame.origin.x == 0)
            {
                [self.placeholdViewController showSearch];
            }
//            [UIView animateWithDuration:0.8 animations:^{
//                [self.placeholdViewController.searchBar becomeFirstResponder];
//            }];
            [self createBlur];
        }
}

- (void)dismissToMap {
    if(self.searchView.frame.origin.y == 149)
    {
        [UIView animateWithDuration:0.5 animations:^{
            [self arrowAndSearchViewMove:462];
            self.downArrow.alpha = 0;
            self.upArrow.alpha = 1;
            self.blurredView.alpha = 0;
            [self moveArrows:-462];
        }
        completion:^(BOOL finished){
            if (finished) {
                // Do your method here after your animation.
                //[self.blurredView removeFromSuperview];
            }
        }];
        [self.placeholdViewController hideSearch];
    }
    [self.view endEditing:YES];
}

- (void)moveArrows:(int)num {
    self.grayBar.frame = CGRectMake(self.grayBar.frame.origin.x, self.grayBar.frame.origin.y - num, self.grayBar.frame.size.width, self.grayBar.frame.size.height);
    self.upArrow.frame = CGRectMake(self.upArrow.frame.origin.x, self.upArrow.frame.origin.y - num, self.upArrow.frame.size.width, self.upArrow.frame.size.height);
    self.downArrow.frame = CGRectMake(self.downArrow.frame.origin.x, self.downArrow.frame.origin.y - num, self.downArrow.frame.size.width, self.downArrow.frame.size.height);
}

- (void)createBlur {
    //only apply the blur if the user hasn't disabled transparency effects
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        //self.view.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.5 animations:^{
            self.blurredView.alpha = 1;
        }];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (IBAction)didTapProfile:(id)sender {
    if (self.profileView.frame.origin.x == -297) {
        [UIView animateWithDuration:0.5 animations:^{self.profileView.frame = CGRectMake(self.profileView.frame.origin.x +297, self.profileView.frame.origin.y, self.profileView.frame.size.width, self.profileView.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.blackView.alpha = 0.6;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{self.profileView.frame = CGRectMake(self.profileView.frame.origin.x -297, self.profileView.frame.origin.y, self.profileView.frame.size.width, self.profileView.frame.size.height);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.blackView.alpha = 0;
        }];
    }
}

- (IBAction)didTapBlack:(id)sender {
    [self didTapProfile:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"showSearchViewSegue"])
    {
        PlaceholdViewController *placeholdViewController = [segue destinationViewController];
        placeholdViewController.placeholderDelegate = self;
        placeholdViewController.placeholderDelegateMap = self;
        self.placeholdViewController = placeholdViewController;
    }
    else if([segue.identifier isEqualToString:@"mapSegue"]){
        self.mapController = [segue destinationViewController];
        self.mapController.mapDelegate = self;
    }
}


- (void)addAnnotationsInMap:(NSMutableArray*)filteredItemArray {
    [self.mapController addMarkers:filteredItemArray];
}

- (void)removeAnnotationsInMap{
    [self.mapController removeAllMarkersButUserLocation];
}
    

@end
