//
//  WZWFlowLayout.h
//  瀑布流
//
//  Created by qf1 on 15/11/27.
//  Copyright © 2015年 qf1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZWFlowLayout;
@protocol WZWFlowLayoutDelegate <NSObject>

-(CGFloat)getHeightInWaterFlowLayout:(WZWFlowLayout *)waterFlowLayout andWidth:(CGFloat)width withIndexPath:(NSIndexPath *)indexPath;

@end
@interface WZWFlowLayout : UICollectionViewFlowLayout

/**
 *  距离四周的间距
 */
@property (nonatomic,assign) UIEdgeInsets WZWSectionInset;
/**
 *  每列之间的间距
 */
@property (nonatomic,assign) CGFloat WZWColMargin;
/**
 *  每行之间的间距
 */
@property (nonatomic,assign) CGFloat WZWRowMargin;
/**
 *  总列数
 */
@property (nonatomic,assign) int WZWColCount;
/**
 *  代理属性
 */
@property (nonatomic,weak) id <WZWFlowLayoutDelegate> delegate;

@end
