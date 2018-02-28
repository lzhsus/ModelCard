//
//  PickInfoView.h
//  ModelCard
//
//  Created by iMac on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LEEAlert.h>

typedef void(^FinishBlock)(id value);

//数据源类型
typedef enum : NSInteger {
    PickerTypeSex,
    PickerTypeDate,
    PickerTypeHeight,
    PickerTypeWeight,
    PickerTypeSize,
    PickerTypeFoot,
    PickerTypeLocation,
    PickerTypeWeiBo,
    PickerTypeGameRank
} PickerType;

@interface PickInfoView : UIView
@property (nonatomic,assign) PickerType Type;
-(void)show:(FinishBlock)block;
@end
