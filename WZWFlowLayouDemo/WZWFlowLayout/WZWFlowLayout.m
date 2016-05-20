//
//  WZWFlowLayout.m
//  瀑布流
//
//  Created by qf1 on 15/11/27.
//  Copyright © 2015年 qf1. All rights reserved.
//

#import "WZWFlowLayout.h"

@interface WZWFlowLayout ()

/**
 *  用来存储每列的高度
 */
@property (nonatomic,strong) NSMutableDictionary * WZWColDict;
/**
 *  用来存储所有的属性
 */
@property (nonatomic,strong) NSMutableArray * attrsArray;
@end

@implementation WZWFlowLayout

//懒加载
-(NSMutableDictionary *)WZWColDict{
    if (_WZWColDict==nil) {
        self.WZWColDict=[NSMutableDictionary dictionary];
    }
    return _WZWColDict;
}

-(NSMutableArray *)attrsArray{
    if (_attrsArray==nil) {
        self.attrsArray=[NSMutableArray array];
    }
    return _attrsArray;
}

//初始化属性
-(instancetype)init{
    self=[super init];
    if (self) {
        self.WZWColMargin=10;
        self.WZWRowMargin=10;
        self.WZWColCount=3;
        self.WZWSectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
        
    }
    return self;
}

//当边界发生变化时，是否重新刷新布局
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}

//准备布局
-(void)prepareLayout{
    
    [super prepareLayout];
    
    for (int i=0; i<self.WZWColCount; i++) {
        NSString * key = [NSString stringWithFormat:@"%d",i];
        self.WZWColDict[key]=@(self.WZWSectionInset.top);
    }
    
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i=0; i<count; i++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

////可滑动的大小
-(CGSize)collectionViewContentSize{
    //假设最长的那一列是第0列
    __block NSString * maxColHeight = @"0";
    [self.WZWColDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * colHeight, BOOL * _Nonnull stop) {
        if ([colHeight floatValue]>[self.WZWColDict[maxColHeight] floatValue]) {
            maxColHeight=column;
        }
    }];
    return CGSizeMake(0, [self.WZWColDict[maxColHeight] floatValue]+self.WZWSectionInset.bottom);
}

//每一个cell的frame
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //假设最短的那一列是第0列
    __block NSString * minColHeight = @"0";
    [self.WZWColDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * colHeight, BOOL * _Nonnull stop) {
        if ([colHeight floatValue]<[self.WZWColDict[minColHeight] floatValue]) {
            minColHeight=column;
        }
    }];
    
    //计算尺寸
    CGFloat width=(self.collectionView.frame.size.width-self.WZWSectionInset.left-self.WZWSectionInset.right-self.WZWColMargin*(self.WZWColCount-1))/self.WZWColCount;
    CGFloat height = [self.delegate getHeightInWaterFlowLayout:self andWidth:width withIndexPath:indexPath];
    
    //计算坐标
    CGFloat x = self.WZWSectionInset.left+(self.WZWColMargin+width)*[minColHeight floatValue];
    CGFloat y = [self.WZWColDict [minColHeight] floatValue]+self.WZWRowMargin;
    
    //更新这一列的高度
    self.WZWColDict[minColHeight]=@(y+height);
    
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame=CGRectMake(x, y, width, height);
    
    return attrs;
}

//存储所有cell的frame
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrsArray;
}



@end
