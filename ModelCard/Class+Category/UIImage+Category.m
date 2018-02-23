//
//  UIImage+Category.m
//  NavigationControllerDemo
//
//  Created by Mac on 2017/10/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+(UIImage *)imageOriginalImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
+(UIImage*)GetImageWithColor:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height{
    CGRect rect= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color colorWithAlphaComponent:alpha].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
