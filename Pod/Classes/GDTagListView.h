//
//  GDTagListView.h
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GDTagListViewBlock)(NSInteger index);

@interface GDTagListView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIColor *tagColor;
@property (nonatomic, assign) CGFloat tagCornerRadius;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) BOOL canRemove;

- (void)setCompletionBlockWithSelected:(GDTagListViewBlock)completionBlock;

- (void)addTag:(NSString *)tag;
- (void)addTag:(NSString *)tag andReload:(BOOL)reload;
- (void)addTags:(NSArray *)array;
- (void)addTags:(NSArray *)array andReload:(BOOL)reload;
- (NSMutableArray *)tags;
- (void)removeTagAtIndex:(NSUInteger)index;
- (void)removeTagAtIndex:(NSUInteger)index andReload:(BOOL)reload;
-(void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
-(CGFloat)getHeight;

@end
