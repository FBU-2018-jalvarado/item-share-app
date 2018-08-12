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
                                                @"Girl's Clothes" : @"Girl's Clothes",
                                                @"Boy's Clothes"  : @"Boy's Clothes",
                                                @"Women's Clothes" : @"Women's Clothes",
                                                @"Men's Clothes"   : @"Men's Clothes"
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
                                        @"Brass and Wind" : @{
                                                @"Brass"           : @"Brass",
                                                @"Winds/Woodwinds" : @"Winds/Woodwinds"
                                                },
                                        @"Other Instrumental" : @{
                                                @"Instrument Accessories"      : @"Instrument Accessories",
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
                                                @"Yard Work"            : @"Yard Work",
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
    self.catArray =            @[@"Clothing", @"Costumes", @"Halloween/Party/Event", @"Performance/Stage", @"Formal Wear", @"Girl's Clothes", @"Boy's Clothes", @"Women's Clothes", @"Men's Clothes", \
                                 @"Instruments", @"Strings", @"Guitar and Similar", @"Orchestral", @"Other Strings", @"Pianos/Keys", @"Acoustic", @"Digital/Electric", \
                                 @"Drums/Percussion", @"Drums", @"Percussion", @"Tech and Equipment", @"DJ", @"Amps/Effects", @"Mics/Recording", @"Brass and Wind", @"Brass", \
                                 @"Winds/Woodwinds", @"Other Instrumental", @"Instrument Accessories", @"Other Instruments/Equipment", @"Home", @"Furniture", @"Chairs", @"Desks", \
                                 @"Tables", @"Other Furniture", @"Kitchen/Dining", @"Cookware", @"Bakeware", @"Kitchen Appliances", @"Arts/Crafts Tools", @"Scrapbooking Tools", \
                                 @"Sewing Tools and Machines", @"Printmaking Tools", @"Beading/Jewelry Making Tools", @"Other Arts/Crafts Tools", @"Cleaning Tools", @"Brushes", \
                                 @"Dusting", @"Mopping", @"Sweeping", @"Cleaning Appliances", @"Other Cleaning Tools", @"Garden/Outdoor", @"Grills and Similar", @"Yard Work", \
                                 @"Pool/Hot Tub", @"Farming", @"Other Garden/Outdoor", @"Toys/Games", @"Toys", @"Games", @"Tools",  @"Power", @"Hand", @"Electronics", @"TV/Video/Theater", @"TV", @"Video", \
                                 @"Theater", @"Audio/Speakers/Headphones", @"Speakers", @"Headphones", @"Other Audio", @"Photography/Videography", @"Photography", @"Videography", \
                                 @"Video Game Consoles", @"PlayStation", @"Xbox", @"Nintendo DS/Switch", @"Wii", @"Other Consoles", @"Sports and Outdoors", @"Sports", \
                                 @"Exercise/Fitness", @"Hunting/Fishing", @"Team Sports", @"Water Sports", @"Winter Sports", @"Other Sports", @"Outdoors", @"Camping/Hiking", \
                                 @"Bikes", @"Climbing", @"Extreme Sports", @"Other Outdoor", @"Vehicles", @"Water Vehicles", @"Boats", @"Other Water Vehicles", \
                                 @"Land Vehicles", @"Cars", @"Motorcycles", @"Trucks", @"Other Land Vehicles", @"Air Vehicles", @"Planes", @"Other Air Vehicles"];
    
    
    // the lowest level categories array
    self.lastLevel =            @[@"Halloween/Party/Event", @"Performance/Stage", @"Girl's Clothes", @"Boy's Clothes", @"Women's Clothes", @"Men's Clothes", @"Guitar and Similar", @"Orchestral", @"Other Strings", @"Acoustic", @"Digital/Electric", @"Orchestral", @"Other Strings", @"Acoustic", @"Digital/Electric", @"Drums", @"Percussion", @"DJ", @"Amps/Effects", @"Mics/Recording", @"Brass", @"Winds/Woodwinds", @"Instrument Accessories", @"Other Instruments/Equipment", @"Chairs", @"Desks", @"Tables", @"Other Furniture", @"Cookware", @"Bakeware", @"Kitchen Appliances", @"Scrapbooking Tools", @"Sewing Tools and Machines", @"Printmaking Tools", @"Beading/Jewelry Making Tools", @"Other Arts/Crafts Tools", @"Brushes", @"Dusting", @"Mopping", @"Sweeping", @"Cleaning Appliances", @"Other Cleaning Tools", @"Grills and Similar", @"Yard Work", @"Pool/Hot Tub", @"Farming", @"Other Garden/Outdoor", @"Toys", @"Games", @"Power", @"Hand", @"TV", @"Video", @"Theater", @"Speakers", @"Headphones", @"Other Audio", @"Photography", @"Videography", @"PlayStation", @"Xbox", @"Nintendo DS/Switch", @"Wii", @"Other Consoles", @"Exercise/Fitness", @"Hunting/Fishing", @"Team Sports", @"Water Sports", @"Winter Sports", @"Other Sports", @"Camping/Hiking", @"Bikes", @"Climbing", @"Extreme Sports", @"Other Outdoor", @"Boats", @"Other Water Vehicles", @"Cars", @"Motocycles", @"Trucks", @"Other Land Vehicles", @"Planes", @"Other Air Vehicles"];
    
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
                          @"Girl's Clothes"               : @"girl",
                          @"Boy's Clothes"                : @"boy",
                          @"Women's Clothes"              : @"woman",
                          @"Men's Clothes"                : @"man",
                          @"Instruments"                  : @"instruments",
                          @"Strings"                      : @"violin",
                          @"Guitar and Similar"           : @"guitarAndSimilar",
                          @"Orchestral"                   : @"conductor",
                          @"Other Strings"                : @"harp",
                          @"Pianos/Keys"                  : @"keys",
                          @"Acoustic"                     : @"piano",
                          @"Digital/Electric"             : @"digitalPiano",
                          @"Drums/Percussion"             : @"drum-set",
                          @"Drums"                        : @"drum",
                          @"Percussion"                   : @"xylophone",
                          @"Tech and Equipment"           : @"tech",
                          @"DJ"                           : @"dj",
                          @"Amps/Effects"                 : @"amp",
                          @"Mics/Recording"               : @"mic",
                          @"Brass and Wind"               : @"sax",
                          @"Brass"                        : @"trumpet",
                          @"Winds/Woodwinds"              : @"flute",
                          @"Other Instrumental"           : @"stand",
                          @"Instrument Accessories"       : @"drum_sticks",
                          @"Other Instruments/Equipment"  : @"accordian",
                          @"Home"                         : @"home-1",
                          @"Furniture"                    : @"sofa",
                          @"Chairs"                       : @"chair",
                          @"Desks"                        : @"desks",
                          @"Tables"                       : @"table",
                          @"Other Furniture"              : @"drawer",
                          @"Kitchen/Dining"               : @"chef",
                          @"Cookware"                     : @"cook",
                          @"Bakeware"                     : @"oven",
                          @"Kitchen Appliances"           : @"mixer",
                          @"Arts/Crafts Tools"            : @"scissors",
                          @"Scrapbooking Tools"           : @"scrapbook",
                          @"Sewing Tools and Machines"    : @"sewing",
                          @"Printmaking Tools"            : @"printer",
                          @"Beading/Jewelry Making Tools" : @"beads",
                          @"Other Arts/Crafts Tools"      : @"art",
                          @"Cleaning Tools"               : @"soap",
                          @"Brushes"                      : @"brush",
                          @"Dusting"                      : @"duster",
                          @"Mopping"                      : @"mop",
                          @"Sweeping"                     : @"broom",
                          @"Cleaning Appliances"          : @"vacuum",
                          @"Other Cleaning Tools"         : @"cleaning",
                          @"Garden/Outdoor"               : @"garden",
                          @"Grills and Similar"           : @"grill",
                          @"Yard Work"                    : @"lawnMower",
                          @"Pool/Hot Tub"                 : @"pool",
                          @"Farming"                      : @"farming",
                          @"Other Garden/Outdoor"         : @"gazebo",
                          @"Toys/Games"                   : @"rubik",
                          @"Toys"                         : @"toy",
                          @"Games"                        : @"chess",
                          @"Tools"                        : @"measuring",
                          @"Power"                        : @"drill",
                          @"Hand"                         : @"hand_tool",
                          @"Electronics"                  : @"electronic",
                          @"TV/Video/Theater"             : @"entertainment",
                          @"TV"                           : @"tv",
                          @"Video"                        : @"video",
                          @"Theater"                      : @"homeTheater",
                          @"Audio/Speakers/Headphones"    : @"audio",
                          @"Speakers"                     : @"speaker",
                          @"Headphones"                   : @"headphone",
                          @"Other Audio"                  : @"cassette2",
                          @"Photography/Videography"      : @"film",
                          @"Photography"                  : @"photography",
                          @"Videography"                  : @"video_camera",
                          @"Video Game Consoles"          : @"video_game",
                          @"PlayStation"                  : @"ps2",
                          @"Xbox"                         : @"xbox",
                          @"Nintendo DS/Switch"           : @"nintendo",
                          @"Wii"                          : @"wii_remote",
                          @"Other Consoles"               : @"sega",
                          @"Sports and Outdoors"          : @"sportAndOutdoor",
                          @"Sports"                       : @"soccer",
                          @"Exercise/Fitness"             : @"exercise",
                          @"Hunting/Fishing"              : @"fishgin",
                          @"Team Sports"                  : @"football",
                          @"Water Sports"                 : @"waterPolo",
                          @"Winter Sports"                : @"skiiing",
                          @"Other Sports"                 : @"gymnastic",
                          @"Outdoors"                     : @"outdoor",
                          @"Camping/Hiking"               : @"hiker",
                          @"Bikes"                        : @"bike",
                          @"Climbing"                     : @"climbing",
                          @"Extreme Sports"               : @"skydiving",
                          @"Other Outdoor"                : @"adventure",
                          @"Vehicles"                     : @"vehicle",
                          @"Water Vehicles"               : @"water",
                          @"Boats"                        : @"boat",
                          @"Other Water Vehicles"         : @"submarine",
                          @"Land Vehicles"                : @"jeep",
                          @"Cars"                         : @"car",
                          @"Motorcycles"                  : @"motorcycle",
                          @"Trucks"                       : @"truck",
                          @"Other Land Vehicles"          : @"tank",
                          @"Air Vehicles"                 : @"helicopter",
                          @"Planes"                       : @"plane",
                          @"Other Air Vehicles"           : @"flyingCar"
                          };
}

@end
