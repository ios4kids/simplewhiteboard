//
//  Marker.h
//  WhiteboardIpad
//
//  Created by Alberto Morales on 8/31/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Marker : NSObject

@property (strong) UIView * view;
@property int strokeWidth;
@property (strong) UIColor * strokeColor;
@property (strong) UIColor * backgroundColor;
@property CGContextRef cacheContext;

-(id) initWithView:(UIView *) theView;

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

-(void) drawRect:(CGRect)rect;

@end
