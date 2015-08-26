//
//  GDTagCell.m
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import "GDTagCell.h"

@implementation GDTagCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.removeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 15, self.bounds.size.height)];
        self.removeLabel.textAlignment = NSTextAlignmentCenter;
        self.removeLabel.font = [UIFont boldSystemFontOfSize:14];
        self.removeLabel.hidden = YES;
        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.removeLabel];
        self.removeEnabled = NO;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.removeEnabled) {
        self.removeLabel.hidden = NO;
        self.titleLabel.frame = CGRectMake(self.removeLabel.frame.size.width, 0, self.bounds.size.width-self.removeLabel.frame.size.width, self.bounds.size.height);
    } else {
        self.removeLabel.hidden = YES;
        self.titleLabel.frame = self.bounds;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

@end
