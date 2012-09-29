//
//  Whiteboard.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/1/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolbarSelector.h"
#import <UIKit/UIKit.h>
#import "Canvas.h"

@interface Whiteboard : NSObject

@property ToolbarSelector *toolbarSelector;
@property NSMutableArray *buttons;
@property UIStepper *stepper;
@property UIImageView *strokeWidthImageView;

@property Canvas *canvas;

-(id) initWithButtons: (NSMutableArray *)theButtons withStepper:(UIStepper *) theStepper withStrokeWidthImageView: (UIImageView *) theStrokeWidthImageView withCanvas:(Canvas *) theCanvas;

-(void) clearAll;

-(void) markerButtonPressed:(UIButton *) theButton;

-(void) stepperButtonPressed;

-(void) saveImageWithName: (NSString *) imageName;

-(void) loadImageNamed: (NSString *) imageName;

@end
