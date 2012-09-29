//
//  ViewController.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/1/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "ViewController.h"
#import "ImagesNavigationViewController.h"
#import "ImagesTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize canvasView;
@synthesize blackButton;
@synthesize redButton;
@synthesize blueButton;
@synthesize greenButton;
@synthesize yellowButton;
@synthesize orangeButton;
@synthesize brownButton;
@synthesize eraserButton;
@synthesize stepper;
@synthesize strokeWidthIconView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *buttons = [NSMutableArray arrayWithObjects:self.blackButton, self.redButton, self.blueButton, self.greenButton, self.yellowButton, self.orangeButton, self.brownButton, self.eraserButton, nil];
    self.whiteBoard = [[Whiteboard alloc] initWithButtons:buttons withStepper:self.stepper withStrokeWidthImageView:self.strokeWidthIconView withCanvas:self.canvasView];
    
    //dirty hack; not sure how to get this from the prepare for segue
    if (self.imageToLoad) {
        [self.whiteBoard loadImageNamed:self.imageToLoad];
    }
    
}

- (void)viewDidUnload
{
    [self setCanvasView:nil];
    [self setBlackButton:nil];
    [self setRedButton:nil];
    [self setBlueButton:nil];
    [self setGreenButton:nil];
    [self setYellowButton:nil];
    [self setOrangeButton:nil];
    [self setBrownButton:nil];
    [self setEraserButton:nil];
    [self setStepper:nil];
    [self setStrokeWidthIconView:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clearAllPressed:(id)sender {
    [self.whiteBoard clearAll];
}

- (IBAction)stepperPressed:(id)sender {
    [self.whiteBoard stepperButtonPressed];
}

- (IBAction)markerPressed:(id)sender {
    UIButton * button = (UIButton *) sender;
    [self.whiteBoard markerButtonPressed:button];
    
}



// saving
- (IBAction)saveImagePressed:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Save Whiteboard Contents" message:@"With filename:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.delegate = self;
    alertTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    alertTextField.placeholder = @"";
    [alert show];
}

-(BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *) alertView {
    UITextField *textField = [alertView textFieldAtIndex:0];
    if ([textField.text length] == 0)
    {
        return NO;
    }
    return YES;
}

-(BOOL)textField:(UITextField *)field shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)characters {
    NSCharacterSet *blockedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"()@#!$%&+=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefgjhijklmnopqrstuvwxyz1234567890 -_"] invertedSet];
    BOOL charactersOK = ([characters rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
    
    NSUInteger newLength = [field.text length] + [characters length] - range.length;
    BOOL lengthOK = (newLength > 40) ? NO : YES;
    
    return ((charactersOK && lengthOK) ? YES : NO);
    
}

-(void) alertView:(UIAlertView *) alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        NSString *filename = [[alert textFieldAtIndex:0].text stringByAppendingString:@".png"];
        [self.whiteBoard saveImageWithName:filename];
    }
}

-(void) loadWhiteboardWithImageNamed:(NSString *) imageName {
    self.imageToLoad = imageName;
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"loadImageButtonPressed"] || [[segue identifier] isEqualToString:@"emailImageButtonPressed"]) {
        
        //save this so that we know to email or load
        ImagesNavigationViewController * navigationController = [segue destinationViewController];
        ImagesTableViewController *tableController = [[navigationController viewControllers] objectAtIndex:0];
        
        tableController.originatingSegueIdentifier = [segue identifier];
        
        //save the image on memory
        [self.whiteBoard saveImageWithName:@" Image currently on whiteboard.png"];
    }

}
@end
