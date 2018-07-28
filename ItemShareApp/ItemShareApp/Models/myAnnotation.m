//
//  PinView.m
//  item-share-app
//
//  Created by Nicolas Machado on 7/27/18.
//  Copyright © 2018 FBU-2018. All rights reserved.
//

#import "myAnnotation.h"

@implementation myAnnotation


- (id)initWithLocation: (CLLocationCoordinate2D)location{
    self = [super init];
    
    if(self){
        _coordinate = location;
    }
    
    return self;
}

- (MKAnnotationView*)annotationView{
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"customAnimation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = NO;
    annotationView.image = [UIImage imageNamed:@"orange_f"];
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}












//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self setMarkerTintColor:[UIColor purpleColor]];
//    }
//    return self;
//}
//
//- (void)awakeFromNib{
//    [super awakeFromNib];
//     [self setMarkerTintColor:[UIColor purpleColor]];
//}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
