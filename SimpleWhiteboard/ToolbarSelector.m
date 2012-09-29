//
//  ToolbarSelector.m
//  Toolbar2
//
//  Created by Alberto Morales on 8/30/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "ToolbarSelector.h"

@implementation ToolbarSelector

@synthesize toolbarButtons;

-(id) initWithButtons:(NSMutableArray *)buttons {
        self = [super init];
        self.toolbarButtons = buttons;
        return self;
}

-(void) disableAll {
    for(UIButton *theButton in self.toolbarButtons) {
        [theButton setEnabled:NO];
    }
}

-(void) enableAll {
    for(UIBarButtonItem *theButton in self.toolbarButtons) {
        [theButton setEnabled:YES];
    }
}

-(void) buttonWithTagPressed:(int)tagNumber {
    UIButton * theMatchingButton = nil;
    
    for(UIButton *currentButton in self.toolbarButtons) {
        if (currentButton.tag == tagNumber) {
            theMatchingButton = currentButton;
            break;
        }
    }
    
    [self setActive: theMatchingButton];
   
}

-(void) setActive:(UIButton *)theButton {
    [self enableAll];
    [theButton setEnabled:NO];
    self.selectedButton = theButton;
}
@end



