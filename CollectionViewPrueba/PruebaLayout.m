//
//  PruebaLayout.m
//  CollectionViewPrueba
//
//  Created by Guillermo Saenz on 4/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PruebaLayout.h"

static NSString * const CustomLayoutCellKind = @"CustomLayoutCellKind";

@interface PruebaLayout ()

@property (nonatomic, strong) NSMutableDictionary *layoutInfo;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation PruebaLayout{
	BOOL didSetup;
    
    CGFloat _maxYUsed;
    CGFloat _maxXUsed;
}

- (instancetype)init{
	self = [super init];
	if (self) {
		[self setupPL];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setupPL];
	}
	return self;
}

- (void)setupPL{
	if (didSetup) return;
	didSetup = YES;

	
	self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
	self.spaceBetweenCellsHorizontal = 0;
	self.spaceBetweenCellsVertical = 0;
}

#pragma mark - Setters

- (void)setInsets:(UIEdgeInsets)insets{
    
    if (UIEdgeInsetsEqualToEdgeInsets(_insets, insets)) return;
    
    _insets = insets;
    
    [self invalidateLayout];
}

- (void)setSpaceBetweenCellsHorizontal:(CGFloat)spaceBetweenCellsHorizontal{
    
    if (_spaceBetweenCellsHorizontal == spaceBetweenCellsHorizontal) return;
    
    _spaceBetweenCellsHorizontal = spaceBetweenCellsHorizontal;
    
    [self invalidateLayout];
}

- (void)setSpaceBetweenCellsVertical:(CGFloat)spaceBetweenCellsVertical{
    
    if (_spaceBetweenCellsVertical == spaceBetweenCellsVertical) return;
    
    _spaceBetweenCellsVertical = spaceBetweenCellsVertical;
    
    [self invalidateLayout];
}

#pragma mark - Overrides
/*
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
	return YES;
}*/

- (CGSize)collectionViewContentSize{
	return CGSizeMake([self width], self.contentHeight);
}

#pragma mark - Layout

- (void)prepareLayout{
	
    _maxYUsed = CGFLOAT_MIN;
    _maxXUsed = CGFLOAT_MIN;
    
    self.contentHeight = 0;
    
    self.layoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [itemAttributes setFrame:[self frameForItemAtIndexPath:indexPath]];
            
            self.layoutInfo[indexPath] = itemAttributes;
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.layoutInfo[indexPath];
}

#pragma mark - Helpers

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect lastFrame = [self.layoutInfo[[NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section]] frame];
    
    CGSize cellSize = [self.delegate collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];
    CGFloat lastCellMaxX = CGRectGetMaxX(lastFrame);
    CGFloat lastCellMaxY = CGRectGetMaxY(lastFrame);
    
    CGPoint cellPoint = CGPointZero;
    
    if (lastCellMaxX+self.spaceBetweenCellsHorizontal+cellSize.width>[self width]) {
        cellPoint.y = lastCellMaxY+self.spaceBetweenCellsVertical;
        if (lastCellMaxY>=_maxYUsed) {
            cellPoint.x = self.insets.left;
            _maxYUsed = 0;
        }else{
            if (MAX(_maxXUsed, lastFrame.origin.x)==lastFrame.origin.x) {
                cellPoint.x = _maxXUsed+self.spaceBetweenCellsHorizontal;
            }else
            {
                cellPoint.x = lastFrame.origin.x;
            }
        }
    }else{
        cellPoint.y = lastFrame.origin.y==0?self.insets.top:lastFrame.origin.y;
        cellPoint.x = lastCellMaxX+self.spaceBetweenCellsHorizontal;
    }
    
    CGRect frame = CGRectMake(cellPoint.x, cellPoint.y, cellSize.width, cellSize.height);
    self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame)+self.insets.bottom);
    
    if (CGRectGetMaxY(frame)>_maxYUsed) {
        _maxYUsed = CGRectGetMaxY(frame);
    }
    
    if (CGRectGetMaxX(frame)<_maxXUsed||_maxXUsed==-1) {
        _maxXUsed = CGRectGetMaxX(frame);
    }
    
    return frame;
}

- (CGFloat)width{
	return  CGRectGetWidth(self.collectionView.bounds);
}

@end
