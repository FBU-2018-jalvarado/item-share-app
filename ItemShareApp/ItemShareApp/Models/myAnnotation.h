//
//  PinView.h
//  item-share-app
//
//  Created by Nicolas Machado on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Item.h"

@interface myAnnotation : NSObject <MKAnnotation>

@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) Item *item;

- (id)initWithLocation: (CLLocationCoordinate2D)location;
- (MKAnnotationView*)annotationView;

@end
