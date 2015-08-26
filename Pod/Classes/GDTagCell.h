//
//  GDTagCell.h
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTagCell : UICollectionViewCell

@property (nonatomic, assign) BOOL removeEnabled;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *removeLabel;
@property (nonatomic, strong) UIColor *tagColor;
@property (nonatomic, strong) UIFont *tagFont;
@property (nonatomic, strong) UIFont *removeFont;

@end
