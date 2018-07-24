//
//  PlaceholdViewController.m
//  item-share-app
//
//  Created by Stephanie Lampotang on 7/20/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "PlaceholdViewController.h"
#import "CategoriesViewController.h"

@interface PlaceholdViewController ()
@property (weak, nonatomic) IBOutlet UIView *categoryCollV;
@property (weak, nonatomic) IBOutlet UIView *catAndItemTableV;


@end

@implementation PlaceholdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.categoryCollV.view
    // Do any additional setup after loading the view.
    NSArray *allCategories = @[@"Clothing", @"Costumes", @"Halloween/Party/Event", @"Performance/Stage", @"Formal Wear", @"Girls", @"Boys", @"Women", @"Men", \
                               @"Instruments", @"Strings", @"Guitar and Similar", @"Orchestral", @"Other Strings", @"Pianos/Keys", @"Acoustic", @"Digital/Electric", \
                               @"Drums/Percussion", @"Drums", @"Percussion", @"Tech and Equipment", @"DJ", @"Amps/Effects", @"Mics/Recording", @"Band", @"Brass", \
                               @"Winds/Woodwinds", @"Other Instrumental Stuff", @"Accessories", @"Other Instruments/Equipment", @"Home", @"Furniture", @"Chairs", @"Desks", \
                               @"Tables", @"Other Furniture", @"Kitchen/Dinign", @"Cookware", @"Bakeware", @"Kitchen Appliances", @"Arts/Crafts Tools", @"Scrapbooking Tools", \
                               @"Sewing Tools and Machines", @"Printmaking Tools", @"Beading/Jewelry Making Tools", @"Other Arts/Crafts Tools", @"Cleaning Tools", @"Brushes", \
                               @"Dusting", @"Mopping", @"Sweeping", @"Cleaning Appliances", @"Other Cleaning Tools", @"Garden/Outdoor", @"Grills and Similar", @"Lawn Mowers", \
                               @"Pool/Hot Tub", @"Farming", @"Other Garden/Outdoor", @"Toys/Games", @"Toys", @"Games", @"Electronics", @"TV/Video/Theater", @"TV", @"Video", \
                               @"Theater", @"Audio/Speakers/Headphones", @"Speakers", @"Headphones", @"Other Audio", @"Photography/Videography", @"Photography", @"Videography", \
                               @"Video Game Consoles", @"PlayStation", @"Xbox", @"Nintendo DS/Switch", @"Wii", @"Other Consoles", @"Sports and Outdoors", @"Sports", \
                               @"Exercise/Fitness", @"Hunting/Fishing", @"Team Sports", @"Water Sports", @"Winter Sports", @"Other Sports", @"Outdoors", @"Camping/Hiking", \
                               @"Bikes and Other Wheels", @"Climbing", @"Extreme Sports", @"Other Outdoor", @"Vehicles", @"Water Vehicles", @"Boats", @"Other Water Vehicles", \
                               @"Land Vehicles", @"Cars", @"Motorcycles", @"Trucks", @"Other Land Vehicles", @"Air Vehicles", @"Planes", @"Other Air Vehicles"];
    NSDictionary *catDict = @{@"Clothing" : @{
                                      @"Costumes" : @{
                                              @"Halloween/Party/Event" : @"Halloween/Party/Event",
                                              @"Performance/Stage"     : @"Performance/Stage"
                                              },
                                      @"Formal Wear" :@{
                                              @"Girls" : @"Girls",
                                              @"Boys"  : @"Boys",
                                              @"Women" : @"Women",
                                              @"Men"   : @"Men"
                                              }
                                      },
                              @"Instruments" : @{
                                      @"Strings" : @{
                                              @"Guitar and Similar": @"Guitar and Similar",
                                              @"Orchestral"        : @"Orchestral",
                                              @"Other Strings"     : @"Other Strings"
                                              },
                                      @"Pianos/Keys" : @{
                                              @"Acoustic"         : @"Acoustic",
                                              @"Digital/Electric" : @"Digital/Electric"
                                              },
                                      @"Drums/Percussion" : @{
                                              @"Drums"      : @"Drums",
                                              @"Percussion" : @"Percussion"
                                              },
                                      @"Tech and Equipment" : @{
                                              @"DJ"             : @"DJ",
                                              @"Amps/Effects"   : @"Amps/Effects",
                                              @"Mics/Recording" : @"Mics/Recording"
                                              },
                                      @"Band" : @{
                                              @"Brass"           : @"Brass",
                                              @"Winds/Woodwinds" : @"Winds/Woodwinds"
                                              },
                                      @"Other Instrumental Stuff" : @{
                                              @"Accessories"                 : @"Accessories",
                                              @"Other Instruments/Equipment" : @"Other Instruments/Equipment"
                                              }
                                      },
                              @"Home" : @{
                                      @"Furniture" : @{
                                              @"Chairs"          : @"Chairs",
                                              @"Desks"           : @"Desks",
                                              @"Tables"          : @"Tables",
                                              @"Other Furniture" : @"Other Furniture"
                                              },
                                      @"Kitchen/Dining" : @{
                                              @"Cookware"           : @"Cookware",
                                              @"Bakeware"           : @"Bakeware",
                                              @"Kitchen Appliances" : @"Kitchen Appliances"
                                              },
                                      @"Arts/Crafts Tools" : @{
                                              @"Scrapbooking Tools"           : @"Scrapbooking Tools",
                                              @"Sewing Tools and Machines"    : @"Sewing Tools and Machines",
                                              @"Printmaking Tools"            : @"Printmaking Tools",
                                              @"Beading/Jewelry Making Tools" : @"Beading/Jewelry Making Tools",
                                              @"Other Arts/Crafts Tools"      : @"Other Arts/Crafts Tools"
                                              },
                                      @"Cleaning Tools" : @{
                                              @"Brushes"              : @"Brushes",
                                              @"Dusting"              : @"Dusting",
                                              @"Mopping"              : @"Mopping",
                                              @"Sweeping"             : @"Sweeping",
                                              @"Cleaning Appliances"  : @"Cleaning Appliances",
                                              @"Other Cleaning Tools" : @"Other Cleaning Tools"
                                              },
                                      @"Garden/Outdoor" : @{
                                              @"Grills and Similar"   : @"Grills and Similar",
                                              @"Lawn Mowers"          : @"Lawn Mowers",
                                              @"Pool/Hot Tub"         : @"Pool/Hot Tub",
                                              @"Farming"              : @"Farming",
                                              @"Other Garden/Outdoor" : @"Other Garden/Outdoor"
                                              },
                                      @"Toys/Games" : @{
                                              @"Toys"  : @"Toys",
                                              @"Games" : @"Games"
                                              },
                                      @"Tools" : @{
                                              @"Power" : @"Power",
                                              @"Hand"  : @"Hand"
                                              }
                                      },
                              @"Electronics" : @{
                                      @"TV/Video/Theater" : @{
                                              @"TV"      : @"TV",
                                              @"Video"   : @"Video",
                                              @"Theater" : @"Theater"
                                              },
                                      @"Audio/Speakers/Headphones" : @{
                                              @"Speakers"    : @"Speakers",
                                              @"Headphones"  : @"Headphones",
                                              @"Other Audio" : @"Other Audio"
                                              },
                                      @"Photography/Videography" : @{
                                              @"Photography" : @"Photography",
                                              @"Videography" : @"Videography"
                                              },
                                      @"Video Game Consoles"        : @{
                                              @"PlayStation"        : @"PlayStation",
                                              @"Xbox"               : @"Xbox",
                                              @"Nintendo DS/Switch" : @"Nintendo DS/Switch",
                                              @"Wii"                : @"Wii",
                                              @"Other Consoles"     : @"Other Consoles"
                                              }
                                      },
                              @"Sports and Outdoors" : @{
                                      @"Sports" : @{
                                              @"Exercise/Fitness" : @"Exercise/Fitness",
                                              @"Hunting/Fishing"  : @"Hunting/Fishing",
                                              @"Team Sports"      : @"Team Sports",
                                              @"Water Sports"     : @"Water Sports",
                                              @"Winter Sports"    : @"Winter Sports",
                                              @"Other Sports"     : @"Other Sports"
                                              },
                                      @"Outdoors" : @{
                                              @"Camping/Hiking"         : @"Camping/Hiking",
                                              @"Bikes and Other Wheels" : @"Bikes and Other Wheels",
                                              @"Climbing"               : @"Climbing",
                                              @"Extreme Sports"         : @"Extreme Sports",
                                              @"Other Outdoor"          : @"Other Outdoor"
                                              }
                                      },
                              @"Vehicles" : @{
                                      @"Water" : @{
                                              @"Boats"                : @"Boats",
                                              @"Other Water Vehicles" : @"Other Water Vehicles"
                                              },
                                      @"Land" : @{
                                              @"Cars"                : @"Cars",
                                              @"Motorcycles"         : @"Motocycles",
                                              @"Trucks"              : @"Trucks",
                                              @"Other Land Vehicles" : @"Other Land Vehicles"
                                              },
                                      @"Air" : @{
                                              @"Planes"             : @"Planes",
                                              @"Other Air Vehicles" : @"Other Air Vehicles"
                                              }
                                      }
                              };
}

- (IBAction)onTapMap:(id)sender {
//    [self performSegueWithIdentifier:@"MapSegue" sender:sender];
    //[self dismissViewControllerAnimated:true completion:nil];
    [self.delegate dismissToMap];
}

- (void)goToMap {
//    [self performSegueWithIdentifier:@"MapSegue" sender:nil];
    //[self dismissViewControllerAnimated:true completion:nil];
    [self.delegate dismissToMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"CategoryCollectionSegue"])
    {
        UINavigationController *navVC = [segue destinationViewController];
        CategoriesViewController *categoriesViewController = navVC.viewControllers[0];
        categoriesViewController.firstPage = YES;
        categoriesViewController.title = @"Categories";
        categoriesViewController.delegate = self;
    }
}


@end
