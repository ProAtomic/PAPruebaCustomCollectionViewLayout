//
//  PruebaLayout.h
//  CollectionViewPrueba
//
//  Created by Guillermo Saenz on 4/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PruebaLayoutDelegate;

@interface PruebaLayout : UICollectionViewLayout

@property (nonatomic, weak) IBOutlet id <PruebaLayoutDelegate> delegate;

@property (nonatomic, assign) IBInspectable UIEdgeInsets insets;
@property (nonatomic, assign) IBInspectable CGFloat spaceBetweenCellsVertical;
@property (nonatomic, assign) IBInspectable CGFloat spaceBetweenCellsHorizontal;

@end

@protocol PruebaLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView*)collectionView sizeForItemAtIndexPath:(NSIndexPath*)indexPath;

@end