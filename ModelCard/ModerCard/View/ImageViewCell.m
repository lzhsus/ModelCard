//
//  ImageViewCell.m
//  ModelCard
//
//  Created by iMac on 2018/2/25.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ImageViewCell.h"

@interface ImageViewCell ()
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation ImageViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 7.5, frame.size.width-7.5, frame.size.height-7.5)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:whiteView];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(1.5, 1.5, whiteView.frame.size.width-3, whiteView.frame.size.height-3)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [whiteView addSubview:imageView];
        self.imageView = imageView;
        
        UIImageView *cancel = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-15, 0, 15, 15)];
        cancel.image = [UIImage imageNamed:@"makeCancel"];
        [self.contentView addSubview:cancel];
    }
    return self;
}

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}
@end
