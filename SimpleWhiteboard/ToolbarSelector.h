//
//  ToolbarSelector.h
//  Toolbar2
//
//  Created by Alberto Morales on 8/30/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToolbarSelector : NSObject

@property NSMutableArray * toolbarButtons;

@property UIButton * selectedButton;

-(id) initWithButtons:(NSMutableArray *) buttons;

-(void) disableAll;

-(void) enableAll;

-(void) buttonWithTagPressed:(int) tagNumber;

-(void) setActive:(UIButton *) theButton;

@end
