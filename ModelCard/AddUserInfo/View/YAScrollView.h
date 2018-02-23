//
//  YAScrollView.h
//  Image
//
//  Created by iMac on 2018/2/22.
//  Copyright © 2018年 Oneyian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YAScrollView : UIScrollView

-(instancetype)initWithFrame:(CGRect)aRect Image:(UIImage*)aImage;
-(void)setNewFrame:(CGRect)aRect animated:(BOOL)Aanimated;

@end
