//
//  EmailViewController.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/18/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface EmailViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property NSString * imageName;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@end
