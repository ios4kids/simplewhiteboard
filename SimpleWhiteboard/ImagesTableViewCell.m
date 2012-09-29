//
//  ImagesTableViewCell.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/11/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "ImagesTableViewCell.h"

@implementation ImagesTableViewCell
@synthesize imageNameLabel;
@synthesize thumbnailImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
