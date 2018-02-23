//
//  UIView+CornerRadius.h
//  BeautyKnocked
//
//  Created by iMac on 2017/6/8.
//  Copyright © 2017年 John. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)
/** 设置圆角 */
-(void)makeCornerRadius:(CGFloat)cornerRadius;
/** 设置边框 */
-(void)makeBorderWidth:(CGFloat)width withColor:(UIColor*)color;
/** 设置阴影 */
-(void)makeShadowOffset:(CGSize)make;
@end
