//
//  Marker.m
//  WhiteboardIpad
//
//  Created by Alberto Morales on 8/31/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//
//  Based on code from:
//  http://blog.effectiveui.com/?p=8105
//

#import "Marker.h"

@implementation Marker {
    
    void *cacheBitmap;
    
    CGPoint point0;
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    
}

@synthesize view;
@synthesize strokeWidth;
@synthesize cacheContext = _cacheContext;

- (id)initWithView:(UIView *)theView
{
    self = [super init];
    
    if (self) {
        self.view = theView;
        
        self.strokeWidth = 10;
        self.strokeColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        
        point0 = CGPointMake(0, 0);
		point1 = CGPointMake(0, 0);
		point2 = CGPointMake(0, 0);
		point3 = CGPointMake(0, 0);
        
        [self initContext:self.view.frame.size];
        [self drawToCache];
    }
    return self;
}

- (void) initContext:(CGSize)size {
	
	int bitmapByteCount;
	int	bitmapBytesPerRow;
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow = (size.width * 4);
	bitmapByteCount = (bitmapBytesPerRow * size.height);
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	cacheBitmap = malloc( bitmapByteCount );
    
	self.cacheContext = CGBitmapContextCreate (cacheBitmap, size.width, size.height, 8, bitmapBytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGImageAlphaNoneSkipFirst);
    
    CGContextSetFillColorWithColor(self.cacheContext, [self.backgroundColor CGColor]);
    CGContextFillRect(self.cacheContext, self.view.bounds);
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    point0 = CGPointMake(-1, -1);
    point1 = CGPointMake(-1, -1); // previous previous point
    point2 = CGPointMake(-1, -1); // previous touch point
    point3 = [touch locationInView:self.view]; // current touch point
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    point0 = point1;
    point1 = point2;
    point2 = point3;
    point3 = [touch locationInView:self.view];
    [self drawToCache];
}

- (void) drawToCache {
    if(point1.x > -1){
        
        CGContextSetStrokeColorWithColor(self.cacheContext, [self.strokeColor CGColor]);
        CGContextSetLineCap(self.cacheContext, kCGLineCapRound);
        CGContextSetLineWidth(self.cacheContext, self.strokeWidth);
        
        double x0 = (point0.x > -1) ? point0.x : point1.x; //after 4 touches we should have a back anchor point, if not, use the current anchor point
        double y0 = (point0.y > -1) ? point0.y : point1.y; //after 4 touches we should have a back anchor point, if not, use the current anchor point
        double x1 = point1.x;
        double y1 = point1.y;
        double x2 = point2.x;
        double y2 = point2.y;
        double x3 = point3.x;
        double y3 = point3.y;
        // Assume we need to calculate the control
        // points between (x1,y1) and (x2,y2).
        // Then x0,y0 - the previous vertex,
        //      x3,y3 - the next one.
        
        double xc1 = (x0 + x1) / 2.0;
        double yc1 = (y0 + y1) / 2.0;
        double xc2 = (x1 + x2) / 2.0;
        double yc2 = (y1 + y2) / 2.0;
        double xc3 = (x2 + x3) / 2.0;
        double yc3 = (y2 + y3) / 2.0;
        
        double len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
        double len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
        double len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
        
        double k1 = len1 / (len1 + len2);
        double k2 = len2 / (len2 + len3);
        
        double xm1 = xc1 + (xc2 - xc1) * k1;
        double ym1 = yc1 + (yc2 - yc1) * k1;
        
        double xm2 = xc2 + (xc3 - xc2) * k2;
        double ym2 = yc2 + (yc3 - yc2) * k2;
        double smooth_value = 0.8;
        // Resulting control points. Here smooth_value is mentioned
        // above coefficient K whose value should be in range [0...1].
        float ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
        float ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
        
        float ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
        float ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
        
        CGContextMoveToPoint(self.cacheContext, point1.x, point1.y);
        CGContextAddCurveToPoint(self.cacheContext, ctrl1_x, ctrl1_y, ctrl2_x, ctrl2_y, point2.x, point2.y);
        CGContextStrokePath(self.cacheContext);
        
        CGRect dirtyPoint1 = CGRectMake(point1.x-10, point1.y-10, 20, 20);
        CGRect dirtyPoint2 = CGRectMake(point2.x-10, point2.y-10, 20, 20);
        [self.view setNeedsDisplayInRect:CGRectUnion(dirtyPoint1, dirtyPoint2)];
    }
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGImageRef cacheImage = CGBitmapContextCreateImage(self.cacheContext);
    CGContextDrawImage(context, self.view.bounds, cacheImage);
    CGImageRelease(cacheImage);
    
}





@end
