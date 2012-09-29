//
//  EmailViewController.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/18/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "EmailViewController.h"
#import "FilePathMethods.h"

@interface EmailViewController ()

@end

@implementation EmailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

-(void) viewDidAppear:(BOOL)animated {
    [self openEmail];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) openEmail {
    {
        if ([MFMailComposeViewController canSendMail])
        {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:@"Enclosing image from Simple Whiteboard"];
            NSArray *toRecipients = [NSArray arrayWithObjects: nil];
            [mailer setToRecipients:toRecipients];
            UIImage *image = [FilePathMethods getImageNamed:self.imageName];
            NSData *imageData = UIImagePNGRepresentation(image);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:self.imageName];
            NSString *emailBody = @"";
            [mailer setMessageBody:emailBody isHTML:NO];
            [self presentModalViewController:mailer animated:YES];

        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                            message:@"Your device doesn't support sending emails from this application."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];

        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissModalViewControllerAnimated:NO];
    
    switch (result) {
        case MFMailComposeResultCancelled:
            self.messageLabel.text = @"Message cancelled.";
            break;
            
        case MFMailComposeResultFailed:
            self.messageLabel.text = @"Sending failed.";
            
        case MFMailComposeResultSaved:
            self.messageLabel.text = @"Message saved.";
            
        case MFMailComposeResultSent:
            self.messageLabel.text = @"Message queued in outbox.";
            
        default:
            self.messageLabel.text = @"";
            break;
    }
    [self performSegueWithIdentifier:@"doneSendingEmail" sender:nil];
}

- (void)viewDidUnload {
    [self setMessageLabel:nil];
    [super viewDidUnload];
}
@end
