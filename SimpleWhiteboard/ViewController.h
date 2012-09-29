//
//  ViewController.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/1/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Canvas.h"
#import "Whiteboard.h"

@interface ViewController : UIViewController <UITextFieldDelegate>

@property Whiteboard * whiteBoard;


@property NSString * imageToLoad;

@property (strong, nonatomic) IBOutlet Canvas *canvasView;
@property (strong, nonatomic) IBOutlet UIButton *blackButton;
@property (strong, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) IBOutlet UIButton *blueButton;
@property (strong, nonatomic) IBOutlet UIButton *greenButton;
@property (strong, nonatomic) IBOutlet UIButton *yellowButton;
@property (strong, nonatomic) IBOutlet UIButton *orangeButton;
@property (strong, nonatomic) IBOutlet UIButton *brownButton;
@property (strong, nonatomic) IBOutlet UIButton *eraserButton;
@property (strong, nonatomic) IBOutlet UIStepper *stepper;
@property (strong, nonatomic) IBOutlet UIImageView *strokeWidthIconView;

- (IBAction)clearAllPressed:(id)sender;


- (IBAction)stepperPressed:(id)sender;


- (IBAction)markerPressed:(id)sender;

- (IBAction)saveImagePressed:(id)sender;

-(void) loadWhiteboardWithImageNamed:(NSString *) imageName;


@end
