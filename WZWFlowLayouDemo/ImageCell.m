//
//  ImageCell.m
//  WZWFlowLayoutSmple
//
//  Created by iOS on 16/5/20.
//  Copyright © 2016年 wzw. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ImageCell

-(void)setImg:(UIImage *)img{
    _img = img;
    _imageV.image = img;
}


@end
