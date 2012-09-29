//
//  Canvas.m
//  AwesomeWhiteboard
//
//  Created by Alberto Morales on 8/31/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "Canvas.h"

@implementation Canvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.marker = [[Marker alloc] initWithView:self];

    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.marker = [[Marker alloc] initWithView:self];
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

        [self.marker drawRect:rect];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.marker touchesBegan:touches withEvent:event];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.marker touchesMoved:touches withEvent:event];
}

-(void) clearAll {
    self.marker = nil;
    self.marker = [[Marker alloc] initWithView:self];
    [self setNeedsDisplay];
}



@end
