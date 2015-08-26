//
//  GDTagView.m
//  Pods
//
//  Created by Gautier Delorme on 26/08/2015.
//
//

#import "GDTagView.h"

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * degrees)/ 180)

@implementation GDTagView

-(void)drawRect:(CGRect)rect {
    float padding = self.padding;
    float tagLength = 10;
    float height = rect.size.height;
    float width = rect.size.width;
    float radius = 8;
    float holeRadius = 4;
    
    if (padding > 0) {
        UIBezierPath *aPath = [UIBezierPath bezierPath];
        
        [aPath moveToPoint:(CGPoint){width, height / 2}];
        [aPath addLineToPoint:CGPointMake(width, radius)];
        [aPath addArcWithCenter:(CGPoint){width - radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(270) clockwise:NO];
        [aPath addLineToPoint:(CGPoint){tagLength + radius, 0.0}];
        [aPath addArcWithCenter:(CGPoint){tagLength + radius, radius} radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(230) clockwise:NO];
        [aPath addLineToPoint:(CGPoint){0.0, height / 2}];
        
        [aPath moveToPoint:(CGPoint){tagLength / 2, height / 2}];
        [aPath addArcWithCenter:(CGPoint){tagLength / 2 + holeRadius, height / 2} radius:holeRadius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
        
        UIBezierPath *p2 = [UIBezierPath bezierPathWithCGPath:aPath.CGPath];
        [p2 applyTransform:CGAffineTransformMakeScale(1, -1)];
        [p2 applyTransform:CGAffineTransformMakeTranslation(0, height)];
        [aPath appendPath:p2];
        
        [self.tagColor setFill];
        
        [aPath fill];
    }
    
    radius -= padding;
    float left = padding * 2;
    UIBezierPath *background = [UIBezierPath bezierPath];
    [background moveToPoint:(CGPoint){tagLength + left + radius, padding}];
    [background addLineToPoint:(CGPoint){width - padding, padding}];
    [background addArcWithCenter:(CGPoint){width - padding - radius, padding + radius} radius:radius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(0) clockwise:YES];
    [background addLineToPoint:(CGPoint){width - padding, height - padding}];
    [background addArcWithCenter:(CGPoint){width - padding - radius, height - padding - radius} radius:radius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    [background addLineToPoint:(CGPoint){tagLength + left + radius, height - padding}];
    [background addArcWithCenter:(CGPoint){tagLength + left + radius, height - padding - radius} radius:radius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180) clockwise:YES];
    [background addLineToPoint:(CGPoint){tagLength + left, padding + radius}];
    [background addArcWithCenter:(CGPoint){tagLength + left + radius, padding + radius} radius:radius startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
    [background closePath];
    
    [[UIColor colorWithWhite:1 alpha:0.3] setFill];
    [background fill];
}

-(void)setTagColor:(UIColor *)tagColor {
    _tagColor = tagColor;
    [self setNeedsDisplay];
}


@end
