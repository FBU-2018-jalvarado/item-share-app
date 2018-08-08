//
//  Category.m
//  item-share-app
//
//  Created by Tarini Singh on 7/24/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "Category.h"

@implementation Category

// sets array and dict to constant data
- (void) setCats {
    // setting dict
    self.catDict =            @{@"Clothing" : @{
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
                                        @"Other Instrumental" : @{
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
                                                @"Bikes"                  : @"Bikes",
                                                @"Climbing"               : @"Climbing",
                                                @"Extreme Sports"         : @"Extreme Sports",
                                                @"Other Outdoor"          : @"Other Outdoor"
                                                }
                                        },
                                @"Vehicles" : @{
                                        @"Water Vehicles" : @{
                                                @"Boats"                : @"Boats",
                                                @"Other Water Vehicles" : @"Other Water Vehicles"
                                                },
                                        @"Land Vehicles" : @{
                                                @"Cars"                : @"Cars",
                                                @"Motorcycles"         : @"Motocycles",
                                                @"Trucks"              : @"Trucks",
                                                @"Other Land Vehicles" : @"Other Land Vehicles"
                                                },
                                        @"Air Vehicles" : @{
                                                @"Planes"             : @"Planes",
                                                @"Other Air Vehicles" : @"Other Air Vehicles"
                                                }
                                        }
                                };
    // setting array
    self.catArray =            @[@"Clothing", @"Costumes", @"Halloween/Party/Event", @"Performance/Stage", @"Formal Wear", @"Girls", @"Boys", @"Women", @"Men", \
                                 @"Instruments", @"Strings", @"Guitar and Similar", @"Orchestral", @"Other Strings", @"Pianos/Keys", @"Acoustic", @"Digital/Electric", \
                                 @"Drums/Percussion", @"Drums", @"Percussion", @"Tech and Equipment", @"DJ", @"Amps/Effects", @"Mics/Recording", @"Band", @"Brass", \
                                 @"Winds/Woodwinds", @"Other Instrumental", @"Accessories", @"Other Instruments/Equipment", @"Home", @"Furniture", @"Chairs", @"Desks", \
                                 @"Tables", @"Other Furniture", @"Kitchen/Dining", @"Cookware", @"Bakeware", @"Kitchen Appliances", @"Arts/Crafts Tools", @"Scrapbooking Tools", \
                                 @"Sewing Tools and Machines", @"Printmaking Tools", @"Beading/Jewelry Making Tools", @"Other Arts/Crafts Tools", @"Cleaning Tools", @"Brushes", \
                                 @"Dusting", @"Mopping", @"Sweeping", @"Cleaning Appliances", @"Other Cleaning Tools", @"Garden/Outdoor", @"Grills and Similar", @"Lawn Mowers", \
                                 @"Pool/Hot Tub", @"Farming", @"Other Garden/Outdoor", @"Toys/Games", @"Toys", @"Games", @"Tools",  @"Power", @"Hand", @"Electronics", @"TV/Video/Theater", @"TV", @"Video", \
                                 @"Theater", @"Audio/Speakers/Headphones", @"Speakers", @"Headphones", @"Other Audio", @"Photography/Videography", @"Photography", @"Videography", \
                                 @"Video Game Consoles", @"PlayStation", @"Xbox", @"Nintendo DS/Switch", @"Wii", @"Other Consoles", @"Sports and Outdoors", @"Sports", \
                                 @"Exercise/Fitness", @"Hunting/Fishing", @"Team Sports", @"Water Sports", @"Winter Sports", @"Other Sports", @"Outdoors", @"Camping/Hiking", \
                                 @"Bikes", @"Climbing", @"Extreme Sports", @"Other Outdoor", @"Vehicles", @"Water Vehicles", @"Boats", @"Other Water Vehicles", \
                                 @"Land Vehicles", @"Cars", @"Motorcycles", @"Trucks", @"Other Land Vehicles", @"Air Vehicles", @"Planes", @"Other Air Vehicles"];
    
    /*
     placeholders:
     first level:  @"instruments"
     second level: @"clothing"
     third level:  @"vehicles"
     */
    
    self.iconDict =     @{@"Clothing"                     : @"hanger",
                          @"Costumes"                     : @"mask",
                          @"Halloween/Party/Event"        : @"batmanmask",
                          @"Performance/Stage"            : @"happysad",
                          @"Formal Wear"                  : @"suit",
                          @"Girls"                        : @"girl",
                          @"Boys"                         : @"boy",
                          @"Women"                        : @"woman",
                          @"Men"                          : @"man",
                          //
                          @"Instruments"                  : @"instruments",
                          @"Strings"                      : @"violin",
                          @"Guitar and Similar"           : @"guitarAndSimilar",
                          @"Orchestral"                   : @"conductor",
                          @"Other Strings"                : @"harp",
                          @"Pianos/Keys"                  : @"keyboard",
                          @"Acoustic"                     : @"piano",
                          @"Digital/Electric"             : @"digitalPiano",
                          @"Drums/Percussion"             : @"drum-set",
                          @"Drums"                        : @"drum",
                          @"Percussion"                   : @"xylophone",
                          //
                          @"Tech and Equipment"           : @"clothing",
                          @"DJ"                           : @"dj",
                          //
                          @"Amps/Effects"                 : @"vehicles",
                          @"Mics/Recording"               : @"mic",
                          //
                          @"Band"                         : @"clothing",
                          @"Brass"                        : @"trumpet",
                          @"Winds/Woodwinds"              : @"flute",
                          //
                          @"Other Instrumental"           : @"clothing",
                          //
                          @"Accessories"                  : @"vehicles",
                          //
                          @"Other Instruments/Equipment"  : @"vehicles",
                          @"Home"                         : @"home",
                          @"Furniture"                    : @"sofa",
                          @"Chairs"                       : @"chair",
                          //
                          @"Desks"                        : @"vehicles",
                          @"Tables"                       : @"table",
                          //
                          @"Other Furniture"              : @"vehicles",
                          @"Kitchen/Dining"               : @"chef",
                          @"Cookware"                     : @"cook",
                          @"Bakeware"                     : @"oven",
                          @"Kitchen Appliances"           : @"mixer",
                          @"Arts/Crafts Tools"            : @"scissor",
                          @"Scrapbooking Tools"           : @"scrapbook",
                          @"Sewing Tools and Machines"    : @"sewing",
                          @"Printmaking Tools"            : @"printer",
                          @"Beading/Jewelry Making Tools" : @"beads",
                          //
                          @"Other Arts/Crafts Tools"      : @"vehicles",
                          @"Cleaning Tools"               : @"soap",
                          @"Brushes"                      : @"brush",
                          @"Dusting"                      : @"duster",
                          @"Mopping"                      : @"mop",
                          @"Sweeping"                     : @"broom",
                          @"Cleaning Appliances"          : @"vacuum",
                          //
                          @"Other Cleaning Tools"         : @"vehicles",
                          @"Garden/Outdoor"               : @"clothing",
                          @"Grills and Similar"           : @"vehicles",
                          @"Lawn Mowers"                  : @"vehicles",
                          @"Pool/Hot Tub"                 : @"vehicles",
                          @"Farming"                      : @"vehicles",
                          @"Other Garden/Outdoor"         : @"vehicles",
                          @"Toys/Games"                   : @"clothing",
                          @"Toys"                         : @"vehicles",
                          @"Games"                        : @"vehicles",
                          @"Tools"                        : @"clothing",
                          @"Power"                        : @"vehicles",
                          @"Hand"                         : @"vehicles",
                          @"Electronics"                  : @"instruments",
                          @"TV/Video/Theater"             : @"clothing",
                          @"TV"                           : @"vehicles",
                          @"Video"                        : @"vehicles",
                          @"Theater"                      : @"vehicles",
                          @"Audio/Speakers/Headphones"    : @"clothing",
                          @"Speakers"                     : @"vehicles",
                          @"Headphones"                   : @"vehicles",
                          @"Other Audio"                  : @"vehicles",
                          @"Photography/Videography"      : @"clothing",
                          @"Photography"                  : @"vehicles",
                          @"Videography"                  : @"vehicles",
                          @"Video Game Consoles"          : @"clothing",
                          @"PlayStation"                  : @"vehicles",
                          @"Xbox"                         : @"vehicles",
                          @"Nintendo DS/Switch"           : @"vehicles",
                          @"Wii"                          : @"vehicles",
                          @"Other Consoles"               : @"vehicles",
                          @"Sports and Outdoors"          : @"instruments",
                          @"Sports"                       : @"clothing",
                          @"Exercise/Fitness"             : @"vehicles",
                          @"Hunting/Fishing"              : @"vehicles",
                          @"Team Sports"                  : @"vehicles",
                          @"Water Sports"                 : @"vehicles",
                          @"Winter Sports"                : @"vehicles",
                          @"Other Sports"                 : @"vehicles",
                          @"Outdoors"                     : @"clothing",
                          @"Camping/Hiking"               : @"vehicles",
                          @"Bikes"                        : @"vehicles",
                          @"Climbing"                     : @"vehicles",
                          @"Extreme Sports"               : @"vehicles",
                          @"Other Outdoor"                : @"vehicles",
                          @"Vehicles"                     : @"instruments",
                          @"Water Vehicles"               : @"clothing",
                          @"Boats"                        : @"vehicles",
                          @"Other Water Vehicles"         : @"vehicles",
                          @"Land Vehicles"                : @"clothing",
                          @"Cars"                         : @"vehicles",
                          @"Motorcycles"                  : @"vehicles",
                          @"Trucks"                       : @"vehicles",
                          @"Other Land Vehicles"          : @"vehicles",
                          @"Air Vehicles"                 : @"clothing",
                          @"Planes"                       : @"vehicles",
                          @"Other Air Vehicles"           : @"vehicles"
                          };
}

@end
