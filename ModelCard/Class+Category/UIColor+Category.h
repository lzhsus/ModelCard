//
//  UIColor+Category.h
//  NavigationControllerDemo
//
//  Created by iMac on 2017/11/1.
//  Copyright © 2017年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
/** 十六进制->Color */
+ (UIColor *)colorHex:(NSString *)color;
/** 十六进制->Color-alpha */
+ (UIColor *)colorHex:(NSString *)color alpha:(CGFloat)alpha;
/** Color->十六进制 */
-(NSString *)toColorHex;
/** 颜色->图片 */
+(UIImage*)colorToImage:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height;
@end
