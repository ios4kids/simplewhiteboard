//
//  Whiteboard.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/1/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "Whiteboard.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@implementation Whiteboard

//100 -- black
//200 -- red
//300 -- blue
//400 -- green
//500 -- yellow
//600 -- orange
//700 -- brown
//800 -- white (eraser)



-(id) initWithButtons:(NSMutableArray *)theButtons withStepper:(UIStepper *)theStepper withStrokeWidthImageView:(UIImageView *)theStrokeWidthImageView withCanvas: (Canvas *) theCanvas
{
    self = [super init];
    
    self.canvas = theCanvas;
    
    self.buttons = theButtons;
    
    self.stepper = theStepper;
    self.strokeWidthImageView = theStrokeWidthImageView;
    
    self.toolbarSelector = [[ToolbarSelector alloc] initWithButtons:self.buttons];
    
    [self colorButtons];
    
    [self setSelectedButton:[self.buttons objectAtIndex:1]];
    
    [self setSelectedStrokeWidth:10];
    
    
    return self;
    
}

-(void) setSelectedButton:(UIButton *) theButton {
    [self.toolbarSelector setSelectedButton:theButton];
    self.canvas.marker.strokeColor = [self getColorForButton:theButton];
    [self setSelectedStrokeWidth:self.canvas.marker.strokeWidth];
}


-(void) setSelectedStrokeWidth: (int) width {
    self.stepper.value = width;
    self.canvas.marker.strokeWidth = width;
    //redraw the stroke icon
    
    [[self.strokeWidthImageView layer] setMasksToBounds:YES];
    [[self.strokeWidthImageView layer] setBorderWidth:1.0f];
    
    [self.strokeWidthImageView setBackgroundColor:self.canvas.marker.strokeColor];
     
    [self setRoundedView:self.strokeWidthImageView toDiameter:(float) width];
    
}

-(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = newSize / 2.0;
    roundedView.center = saveCenter;
}


-(void) colorButtons {
    for(UIButton *currentButton in self.buttons) {
        [[currentButton layer] setCornerRadius:8.0f];
        [[currentButton layer] setMasksToBounds:YES];
        [[currentButton layer] setBorderWidth:1.0f];
        
        [currentButton setBackgroundColor:[self getColorForButton:currentButton]];
        
    }
}


-(UIColor *) getColorForButton:(UIButton *)currentButton {
    
    UIColor * color;
    
    if (currentButton.tag == 100) {
        color = [UIColor blackColor];
    }
    
    if (currentButton.tag == 200) {
        color = [UIColor redColor];
    }
    
    if (currentButton.tag == 300) {
        color = [UIColor blueColor];
    }
    
    if (currentButton.tag == 400) {
        color = [UIColor greenColor];
    }
    
    if (currentButton.tag == 500) {
        color = [UIColor yellowColor];
    }
    
    if (currentButton.tag == 600) {
        color = [UIColor orangeColor];
    }
    
    if (currentButton.tag == 700) {
        color = [UIColor brownColor];
    }
    
    if (currentButton.tag == 800) {
        color = [UIColor whiteColor];
    }
    
    return color;
    
}


-(void) clearAll {
    UIButton * previousButton = self.toolbarSelector.selectedButton;
    int previousWidth = self.canvas.marker.strokeWidth;
    
    [self.canvas clearAll];
    
    [self setSelectedButton:previousButton];
    
    [self setSelectedStrokeWidth:previousWidth];
    
}

-(void) markerButtonPressed:(UIButton *)theButton {
    [self setSelectedButton:theButton];
}

-(void) stepperButtonPressed {
    [self setSelectedStrokeWidth:self.stepper.value];
}


// Save Image code

-(void) saveImageWithName: (NSString *) imageName {
    UIImage *image = [self convertViewToImage];
    NSData *pngData = UIImagePNGRepresentation(image);
    NSString *filePath = [FilePathMethods documentsPathForFileName:imageName];
    [pngData writeToFile:filePath atomically:YES];

}

-(UIImage *) convertViewToImage {
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    [self.canvas.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
    
}


// Load image code
-(void) loadImageNamed:(NSString *)imageName {
    self.canvas.marker = nil;
    self.canvas.marker = [[Marker alloc] initWithView:self.canvas];
    
    UIImage * imageFromDisk = [FilePathMethods getImageNamed:imageName];
    
    
    
    CGRect imageRect = CGRectMake(0, 0, imageFromDisk.size.width, imageFromDisk.size.height);
    
    // we need to save the context, rotate it to draw on it again.
    CGContextSaveGState(self.canvas.marker.cacheContext);
    
    CGContextTranslateCTM(self.canvas.marker.cacheContext, 0, self.canvas.frame.size.height);
    CGContextScaleCTM(self.canvas.marker.cacheContext, 1.0, -1.0);
    
    CGContextDrawImage(self.canvas.marker.cacheContext, imageRect, imageFromDisk.CGImage);
    
    CGContextRestoreGState(self.canvas.marker.cacheContext);
    
    
}




@end
