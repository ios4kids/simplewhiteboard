//
//  ImagesTableViewController.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/11/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "ImagesTableViewCell.h"
#import "EmailViewController.h"


@interface ImagesTableViewController ()

@end

@implementation ImagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelSelection)];
    self.imageNames = [FilePathMethods getSavedImageNames];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.imageNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"imageCell";
    ImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString * imageName = [self.imageNames objectAtIndex:indexPath.row];
    UIImage *image = [FilePathMethods getImageNamed:imageName];
    
    [[cell thumbnailImageView] setImage:image];
    
    // do not show the png
    NSString *cleanedImageName = [imageName stringByReplacingOccurrencesOfString:@".png" withString:@""];
    [[cell imageNameLabel] setText:cleanedImageName];
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        

        
        NSString * imageName = [self.imageNames objectAtIndex:indexPath.row];
        [FilePathMethods deleteImageNamed:imageName];
        self.imageNames = [FilePathMethods getSavedImageNames];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.originatingSegueIdentifier isEqualToString:@"loadImageButtonPressed"]) {
        [self performSegueWithIdentifier:@"loadSavedImage" sender:nil];
    }
    
    if ([self.originatingSegueIdentifier isEqualToString:@"emailImageButtonPressed"]) {
        [self performSegueWithIdentifier:@"emailImage" sender:nil];
    }

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"loadSavedImage"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *imageName = [self.imageNames objectAtIndex:indexPath.row];
        [[segue destinationViewController] loadWhiteboardWithImageNamed:imageName];
    }
    
    if ([[segue identifier] isEqualToString:@"emailImage"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *imageName = [self.imageNames objectAtIndex:indexPath.row];
        EmailViewController *controller = [segue destinationViewController];
        controller.messageLabel.text = @"Generating email attachment ...";
        controller.imageName = imageName;
        
    }
    
    if ([[segue identifier] isEqualToString:@"closeImageList"]) {
        [[segue destinationViewController] loadWhiteboardWithImageNamed:@" Image currently on whiteboard.png"];
    }
}

@end
