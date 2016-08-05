//
//  CustomLayout.m
//  textKit
//
//  Created by lawyee on 16/8/2.
//  Copyright © 2016年 163. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(200, 200);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 500;
        self.sectionInset = UIEdgeInsetsMake(200, 0, 200, 0);
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%s", __func__);
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.frame.size;
    
    CGFloat width = self.collectionView.frame.size.width;
    for (UICollectionViewLayoutAttributes *attributes in array) {

        if (CGRectIntersectsRect(rect, attributes.frame)) {
            
            CGFloat delta = ABS(width * 0.5 - (CGRectGetMidX(attributes.frame) - visibleRect.origin.x));
            
            CGFloat zoom = 1 - delta / width * 0.5;
            
            attributes.transform = CGAffineTransformMakeScale(zoom, zoom);
//            attributes.transform = CGAffineTransformMakeTranslation(0, zoom * 100);
        }
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    NSLog(@"%s", __func__);
    
    CGPoint origin = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
 
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    NSArray<UICollectionViewLayoutAttributes *> *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat delta = CGFLOAT_MAX;
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
//    CGFloat contentOffsetX = proposedContentOffset.x;
    CGFloat contentOffsetX = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity].x;
    
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        
        CGFloat tempDelta = (attributes.center.x - contentOffsetX) - centerX;
        
        if (ABS(delta) > ABS(tempDelta)) {
            delta = tempDelta;
        }
    }

    origin.x += delta;
    return origin;
    
    
    return proposedContentOffset;
}

@end
