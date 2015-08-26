//
//  GDTagListView.m
//  iphone
//
//  Created by Gautier Delorme on 25/08/2015.
//  Copyright (c) 2015 Scoop.it. All rights reserved.
//

#import "GDTagListView.h"
#import "GDCollectionViewFlowLayout.h"
#import "GDTagCell.h"

@interface GDTagListView ()

@property (nonatomic, copy) GDTagListViewBlock selectedBlock;
@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GDTagListView

static NSString * const reuseIdentifier = @"tagViewCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)setup
{
    self.tagsArray = [NSMutableArray array];
    self.canRemove = NO;
    self.tagColor = [UIColor darkGrayColor];
    self.textTagColor = [UIColor whiteColor];
    self.tagCornerRadius = 5;
    self.removeTextLabel = @"x";
    self.tagFont = [UIFont systemFontOfSize:14.0f];
    self.removeFont = [UIFont boldSystemFontOfSize:17];
    
    GDCollectionViewFlowLayout *layout = [[GDCollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
    [self.collectionView registerClass:[GDTagCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.collectionView];
}

- (void)setCompletionBlockWithSelected:(GDTagListViewBlock)completionBlock
{
    self.selectedBlock = completionBlock;
}

#pragma mark - Public properties

- (void)addTag:(NSString *)tag {
    [self addTag:tag andReload:YES];
}

- (void)addTag:(NSString *)tag andReload:(BOOL)reload{
    [self.tagsArray addObject:tag];
    if (reload)
        [self.collectionView reloadData];
}

- (void)addTags:(NSArray *)array {
    [self addTags:array andReload:YES];
}

- (void)addTags:(NSArray *)array andReload:(BOOL)reload {
    for (NSString* text in array) {
        [self addTag:text andReload:NO];
    }
    if (reload)
        [self.collectionView reloadData];
}

- (void)removeTagAtIndex:(NSUInteger)index {
    [self removeTagAtIndex:index andReload:YES];
}

- (void)removeTagAtIndex:(NSUInteger)index andReload:(BOOL)reload {
    [self.tagsArray removeObjectAtIndex:index];
    if (reload)
        [self.collectionView reloadData];
}

-(void)setScrollEnabled:(BOOL)scrollEnabled {
    self.collectionView.scrollEnabled = scrollEnabled;
}

-(void)setContentSize:(CGSize)contentSize {
    [self.collectionView setContentSize:contentSize];
}

-(void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
    [self.collectionView setContentOffset:offset animated:animated];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor {
    self.collectionView.backgroundColor = backgroundColor;
}

-(void)setTagColor:(UIColor *)tagColor {
    _tagColor = tagColor;
    [self.collectionView reloadData];
}

-(void)setTextTagColor:(UIColor *)textTagColor {
    _textTagColor = textTagColor;
    [self.collectionView reloadData];
}

-(void)setTagFont:(UIFont *)tagFont {
    _tagFont = tagFont;
    [self.collectionView reloadData];
}

-(void)setRemoveFont:(UIFont *)removeFont {
    _removeFont = removeFont;
    [self.collectionView reloadData];
}

-(void)setCanRemove:(BOOL)canRemove {
    _canRemove = canRemove;
    [self.collectionView reloadData];
}

-(CGSize)contentSize {
    return self.collectionView.contentSize;
}

- (NSMutableArray *)tags {
    return self.tagsArray;
}

- (CGFloat)getHeight
{
    GDCollectionViewFlowLayout *layout = (GDCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    [layout.itemAttributes removeAllObjects];
    
    layout.contentHeight = layout.sectionInset.top + layout.itemSize.height;
    
    CGFloat originX = layout.sectionInset.left;
    CGFloat originY = layout.sectionInset.top;
    
    NSInteger itemCount = [layout.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [layout itemSizeForIndexPath:indexPath];
        
        if ((originX + itemSize.width + layout.sectionInset.right/2) > layout.collectionView.frame.size.width) {
            originX = layout.sectionInset.left;
            originY += itemSize.height + layout.minimumLineSpacing;
            
            layout.contentHeight += itemSize.height + layout.minimumLineSpacing;
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [layout.itemAttributes addObject:attributes];
        
        originX += itemSize.width + layout.minimumInteritemSpacing;
    }
    
    layout.contentHeight += layout.sectionInset.bottom;
    return layout.contentHeight;
}

#pragma mark - UICollectionViewDelegate | UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagsArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDCollectionViewFlowLayout *layout = (GDCollectionViewFlowLayout *)collectionView.collectionViewLayout;
    CGSize maxSize = CGSizeMake(collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
    
    CGRect frame = [self.tagsArray[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]} context:nil];
    return CGSizeMake(frame.size.width + 40, layout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GDTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.tagsArray[indexPath.item];
    cell.titleLabel.textColor = self.textTagColor;
    cell.removeLabel.text = self.removeTextLabel;
    cell.removeLabel.textColor = self.textTagColor;
    cell.removeEnabled = self.canRemove;
    cell.tagColor = self.tagColor;
    cell.tagFont = self.tagFont;
    cell.removeFont = self.removeFont;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlock && self.canRemove) {
        self.selectedBlock(indexPath.item);
    }
}

@end
