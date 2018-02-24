//
//  YAScrollView.m
//  Image
//
//  Created by iMac on 2018/2/22.
//  Copyright © 2018年 Oneyian. All rights reserved.
//

#import "YAScrollView.h"

@interface YAScrollView ()
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation YAScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(instancetype)initWithFrame:(CGRect)aRect Image:(UIImage*)aImage{
    self = [super initWithFrame:aRect];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchInView:)];
        [self addGestureRecognizer:touch];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.image = aImage;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        [self setAutoContentSize:aImage];
    }
    return self;
}

-(void)touchInView:(UITapGestureRecognizer *)touch{
    if (touch.state == UIGestureRecognizerStateEnded) {
        [self.YADelegate touchInScrollView:self];
    }
}
-(void)setNewFrame:(CGRect)aRect animated:(BOOL)Aanimated{
    if ((aRect.size.width && aRect.size.height) != 0) {
        if (Aanimated) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf setFrame:aRect];
            }];
        }else{
            [self setFrame:aRect];
        }
        [self setAutoContentSize:self.imageView.image];
    }
}

-(void)setAutoContentSize:(UIImage *)aimage{
    CGSize imageSize = aimage.size;
    CGSize aSize = self.frame.size;
    
    BOOL isViewStatus = aSize.width > aSize.height ? YES:NO;    //横向区块或竖向区块
    BOOL isStatus = imageSize.width > imageSize.height ? YES:NO;  //横图或竖图
    
    CGFloat aWidth = imageSize.width/(imageSize.height/aSize.height);
    CGFloat aHeight = imageSize.height/(imageSize.width/aSize.width);
    
    if (isViewStatus) {
        if (isStatus) {
            //横块-横图
            if (aSize.width > aWidth) {
                self.contentSize = CGSizeMake(aSize.width, aHeight);
            }else{
                self.contentSize = CGSizeMake(aWidth, aSize.height);
            }
        }else{
            self.contentSize = CGSizeMake(aSize.width, aHeight);
        }
    }else{
        if (isStatus) {
            self.contentSize = CGSizeMake(aWidth, aSize.height);
        }else{
            //竖区块-竖图
            if (aSize.height > aHeight) {
                self.contentSize = CGSizeMake(aWidth, aSize.height);
            }else{
                self.contentSize = CGSizeMake(aSize.width, aHeight);
            }
        }
    }
    [self.imageView setFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
}
@end
