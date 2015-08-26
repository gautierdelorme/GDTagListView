//
//  GDTagCell.m
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import "GDTagCell.h"
#import "GDTagView.h"

@interface GDTagCell()

@property (nonatomic, strong) GDTagView *tagView;

@end

@implementation GDTagCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tagColor = [UIColor darkGrayColor];
        self.removeEnabled = NO;
        self.tagFont = [UIFont systemFontOfSize:14.0f];
        self.removeFont = [UIFont boldSystemFontOfSize:17];
        self.tagView = [[GDTagView alloc] initWithFrame:self.bounds];
        self.tagView.tagColor = self.tagColor;
        self.tagView.padding = 3;
        self.tagView.backgroundColor = [UIColor clearColor];
        self.removeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.removeLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.tagView addSubview:self.titleLabel];
        [self.tagView addSubview:self.removeLabel];
        [self.contentView addSubview:self.tagView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tagView.tagColor = self.tagColor;
    self.removeLabel.font = self.removeFont;
    self.titleLabel.font = self.tagFont;
    
    if (self.removeEnabled) {
        self.tagView.frame = self.bounds;
        self.removeLabel.frame = CGRectMake(self.tagView.bounds.size.width-15, 0, 10, self.bounds.size.height);
        self.titleLabel.frame = CGRectMake(0, 0, self.removeLabel.frame.origin.x-self.tagView.frame.origin.x-5, self.bounds.size.height);
    } else {
        self.tagView.frame = self.bounds;
        self.removeLabel.frame = CGRectZero;
        self.titleLabel.frame = CGRectMake(0, 0, self.tagView.bounds.size.width-4*self.tagView.padding, self.tagView.bounds.size.height);
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = @"";
}

@end
