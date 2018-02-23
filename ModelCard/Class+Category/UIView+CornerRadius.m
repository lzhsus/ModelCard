//
//  UIView+CornerRadius.m
//  BeautyKnocked
//
//  Created by iMac on 2017/6/8.
//  Copyright © 2017年 John. All rights reserved.
//

#import "UIView+CornerRadius.h"

@implementation UIView (CornerRadius)
-(void)makeCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}
-(void)makeBorderWidth:(CGFloat)width withColor:(UIColor*)color{
    self.layer.borderWidth=width;
    self.layer.borderColor=color.CGColor;
}
-(void)makeShadowOffset:(CGSize)make{
    self.layer.shadowColor=[UIColor blackColor].CGColor;
    self.layer.shadowOffset=make;
    self.layer.shadowOpacity = 0.35f;
    self.layer.shadowRadius = 1.5;
}
@end
