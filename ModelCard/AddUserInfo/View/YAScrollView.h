//
//  YAScrollView.h
//  Image
//
//  Created by iMac on 2018/2/22.
//  Copyright © 2018年 Oneyian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YAScrollViewDelegate <NSObject>
-(void)touchInScrollView:(UIScrollView *)scrollView;
@end

@interface YAScrollView : UIScrollView
@property (nonatomic,weak) id<YAScrollViewDelegate> YADelegate;
-(instancetype)initWithFrame:(CGRect)aRect Image:(UIImage*)aImage;
-(void)setNewFrame:(CGRect)aRect animated:(BOOL)Aanimated;

@end
