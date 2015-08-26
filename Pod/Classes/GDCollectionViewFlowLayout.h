//
//  GDCollectionViewFlowLayout.h
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) NSMutableArray *itemAttributes;

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath;

@end
