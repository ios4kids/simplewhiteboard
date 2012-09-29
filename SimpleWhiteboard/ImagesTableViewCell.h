//
//  ImagesTableViewCell.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/11/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *imageNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
