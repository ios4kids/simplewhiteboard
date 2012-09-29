//
//  ImagesTableViewController.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/11/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilePathMethods.h"
#import "ViewController.h"

@interface ImagesTableViewController : UITableViewController

@property NSArray * imageNames;

@property NSString * originatingSegueIdentifier;

@end
