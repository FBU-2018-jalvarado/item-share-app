
//
//  iCarouselViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/31/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "iCarouselViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ParseUI/ParseUI.h>

@interface iCarouselViewController () <UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *car;
//@property (nonatomic, strong, readonly) NSArray *indexesForVisibleItems;
//@property (nonatomic, assign) NSInteger currentItemIndex;
@end

@implementation iCarouselViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen

}
- (void)tapImage {
    if([self.parentVC isEqualToString:@"sell"])
    {
        [self.delegate choosePic:NO];
    }
}

//- (void)dealloc
//{
//    //it's a good idea to set these to nil here to avoid
//    //sending messages to a deallocated viewcontroller
//    //this is true even if your project is using ARC, unless
//    //you are targeting iOS 5 as a minimum deployment target
//    _carousel.delegate = nil;
//    _carousel.dataSource = nil;
//}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.car.layer.cornerRadius = 15;
    //configure carousel
    _carousel.type = iCarouselTypeLinear;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.pagingEnabled = YES;
    //self.images = [[NSMutableArray alloc] init];
    [_carousel reloadData];
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//
//    //free up memory by releasing subviews
//    self.carousel = nil;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
//    if([_images count] <= 2)
//    {
//        _carousel.type = iCarouselTypeLinear;
//    }
//    else {
//        _carousel.type = iCarouselTypeRotary;
//    }
    //return the total number of items in the carousel
    return [_images count];
}

- (PFImageView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(PFImageView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
//        view = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 375.0f, 375.0f)];
        view = [[PFImageView alloc] initWithFrame:CGRectMake(15, 15, 345.0f, 345.0f)];
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 5;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
        
        if([self.parentVC isEqualToString:@"detail"])
        {
            view.file = self.images[index];
        }
        if([self.parentVC isEqualToString:@"sell"])
        {
            view.image = self.images[index];
        }
        [view loadInBackground];
//        view.contentMode = UIViewContentModeCenter;
        view.contentMode = UIViewContentModeScaleAspectFill;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        view.frame = CGRectMake(0, 0, 375.0f, 375.0f);
        view.contentMode = UIViewContentModeScaleAspectFill;
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [_images[index] stringValue];
    
    return view;
}

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel
{
    [self.delegate updatePage:[_carousel currentItemIndex]];
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    if (option == iCarouselOptionWrap)
    {
        return value * 1.1;
    }
    return value;
}

- (void)reload {
    [self.carousel reloadData];
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
