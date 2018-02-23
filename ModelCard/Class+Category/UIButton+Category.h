//
//  UIButton+Category.h
//  BeautyKnocked
//
//  Created by iMac on 2017/5/8.
//  Copyright © 2017年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ButtonStyleTop,
    ButtonStyleLeft,
    ButtonStyleBottom,
    ButtonStyleRight,
} ButtonStyle;

@interface UIButton (Category)

/**
 设置 按钮 图片所在的位置
 @param style   图片位置类型（上、左、下、右）
 @param size    图片的大小
 @param space 图片跟文字间的间距
 */
- (void)setImgViewStyle:(ButtonStyle)style imageSize:(CGSize)size space:(CGFloat)space;

@end
