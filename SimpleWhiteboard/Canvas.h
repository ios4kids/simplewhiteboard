//
//  Canvas.h
//  AwesomeWhiteboard
//
//  Created by Alberto Morales on 8/31/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Marker.h"

@interface Canvas : UIView

@property Marker *marker;


-(void) clearAll;



@end
