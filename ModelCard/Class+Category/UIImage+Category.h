//
//  UIImage+Category.h
//  NavigationControllerDemo
//
//  Created by Mac on 2017/10/31.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+(UIImage *)imageOriginalImageName:(NSString *)imageName;
+(UIImage*)GetImageWithColor:(UIColor*)color andAlpha:(CGFloat)alpha andHeight:(CGFloat)height;
@end
