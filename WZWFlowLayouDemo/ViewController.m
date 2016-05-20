//
//  ViewController.m
//  WZWFlowLayoutSmple
//
//  Created by iOS on 16/5/20.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ViewController.h"
#import "WZWFlowLayout.h"
#import "ImageCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WZWFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    [self loadData];
    
    //初始化collectionView
    [self initCollectionView];
    
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - 获取数据
-(void)loadData{
    for (int i=0; i<15; i++) {
        NSString * imgName = [NSString stringWithFormat:@"img%d.jpg",i+1];
        UIImage * image = [UIImage imageNamed:imgName];
        [self.dataArray addObject:image];
    }
}

#pragma mark - 初始化collectionView
-(void)initCollectionView{
    WZWFlowLayout * flolayout = [[WZWFlowLayout alloc]init];
    flolayout.delegate=self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flolayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"imageCell"];
    [self.view addSubview:_collectionView];
}

-(CGFloat)getHeightInWaterFlowLayout:(WZWFlowLayout *)waterFlowLayout andWidth:(CGFloat)width withIndexPath:(NSIndexPath *)indexPath{
    UIImage * image = self.dataArray[indexPath.row];
    return image.size.width * image.size.height/width*1.0;
}

#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    UIImage * image = self.dataArray[indexPath.item];
    cell.img = image;
    return cell;
}


@end
