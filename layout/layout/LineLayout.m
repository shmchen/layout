//
//  LineLayout.m
//  textKit
//
//  Created by lawyee on 16/8/5.
//  Copyright © 2016年 163. All rights reserved.
//

#import "LineLayout.h"



@implementation LineLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.minimumLineSpacing = Padding;
        self.minimumInteritemSpacing = Padding;
        self.headerReferenceSize = CGSizeMake(100, Header_Height);
    }
    
    return self;
}

-  (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    
    for (int i = 0; i < layoutAttributes.count; i++) {
        
        
        // 防止越界
        if ((i + 1) == layoutAttributes.count) break;

        UICollectionViewLayoutAttributes *currentAttributes = layoutAttributes[i];
        UICollectionViewLayoutAttributes *nextAttributes = layoutAttributes[i + 1];

        // SectionHeader不需要重新布局
        if ([nextAttributes.representedElementKind isEqualToString:@"UICollectionElementKindSectionHeader"]){
            self.totalHeight = CGRectGetMaxY(currentAttributes.frame);
            
            // 由布局来决定collectionView的高度《数据决定高度》
            CGRect rect = self.collectionView.frame;
            rect.size.height = self.totalHeight;
            self.collectionView.frame = rect;
            
            break;
        };
        
        // 防止不同的组首位Item干扰
        if (currentAttributes.indexPath.section != nextAttributes.indexPath.section) continue;
        
        
        CGRect rect = nextAttributes.frame;

        // 直线布局下一个
        rect.origin.x = CGRectGetMaxX(currentAttributes.frame) + Padding;
        rect.origin.y = CGRectGetMinY(currentAttributes.frame);

        // 超出控件宽度换行
        if ((CGRectGetMaxX(rect) + Padding) > CGRectGetWidth(self.collectionView.bounds)) {
            rect.origin.x = 0;
            rect.origin.y = CGRectGetMaxY(currentAttributes.frame) + Padding;
            
        }
        
        nextAttributes.frame = rect;
    }
    
    return layoutAttributes;
}

@end
