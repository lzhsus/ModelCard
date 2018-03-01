//
//  PickInfoView.m
//  ModelCard
//
//  Created by iMac on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "PickInfoView.h"

@interface PickInfoView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView * pickerView;

@property (nonatomic,strong) NSMutableArray * RootArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@property (nonatomic,strong) NSDictionary * addressDict;
@end

@implementation PickInfoView

-(NSMutableArray *)RootArray{
    if (!_RootArray) {
        _RootArray = [[NSMutableArray alloc]init];
    }
    return _RootArray;
}
-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]initWithCapacity:3];
    }
    return _selectArray;
}
-(NSDictionary *)addressDict{
    if (!_addressDict) {
        NSString *addressPath = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"];
        _addressDict = [[NSDictionary alloc]initWithContentsOfFile:addressPath];
    }
    return _addressDict;
}
/** 根据枚举设定数据源 */
-(void)setType:(PickerType)Type{
    _Type = Type;
    switch (Type) {
        case PickerTypeSex://性别
        {
            self.RootArray = [[NSMutableArray alloc]initWithObjects:@[@"男",@"女"], nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"男", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }
            break;
        case PickerTypeDate://生日
        {
            NSMutableArray *year = [NSMutableArray new];
            NSDate *date = [NSDate date];
            NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:@"yyyy"];
            
            NSInteger max = [dateformatter stringFromDate:date].integerValue - 1950;
            for (int i=0; i<max; i++) {
                [year addObject:[NSString stringWithFormat:@"%d",1950+i]];
            }
            
            NSMutableArray *month = [NSMutableArray new];
            for (int i=0; i<12; i++) {
                [month addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            
            NSMutableArray *day = [NSMutableArray new];
            for (int i=0; i<31; i++) {
                [day addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
            
            self.RootArray = [[NSMutableArray alloc]initWithObjects:year,month,day, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"2000",@"1",@"1", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:50 inComponent:0 animated:YES];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case PickerTypeHeight://身高
        {
            NSMutableArray *list = [NSMutableArray new];
            for (int i=0; i<201; i++) {
                [list addObject:[NSString stringWithFormat:@"%d",10+i]];
            }
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"160", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:150 inComponent:0 animated:YES];
        }
            break;
        case PickerTypeWeight://体重
        {
            NSMutableArray *list = [NSMutableArray new];
            for (int i=0; i<101; i++) {
                [list addObject:[NSString stringWithFormat:@"%d",10+i]];
            }
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"55", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:45 inComponent:0 animated:YES];
        }
            break;
        case PickerTypeSize://三围
        {
            NSMutableArray *list1 = [NSMutableArray new];
            for (int i=0; i<81; i++) {
                [list1 addObject:[NSString stringWithFormat:@"%d",40+i]];
            }
            
            NSMutableArray *list2 = [NSMutableArray new];
            for (int i=0; i<81; i++) {
                [list2 addObject:[NSString stringWithFormat:@"%d",40+i]];
            }
            
            NSMutableArray *list3 = [NSMutableArray new];
            for (int i=0; i<81; i++) {
                [list3 addObject:[NSString stringWithFormat:@"%d",40+i]];
            }
            
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list1,list2,list3, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"80",@"60",@"80", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:40 inComponent:0 animated:YES];
            [self.pickerView selectRow:20 inComponent:1 animated:YES];
            [self.pickerView selectRow:40 inComponent:2 animated:YES];
        }
            break;
        case PickerTypeFoot://脚码
        {
            NSMutableArray *list = [NSMutableArray new];
            for (int i=0; i<28; i++) {
                [list addObject:[NSString stringWithFormat:@"%d",20+i]];
            }
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"38", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:18 inComponent:0 animated:YES];
        }
            break;
        case PickerTypeLocation://地区
        {
            NSString *string = self.addressDict.allKeys.firstObject;
            self.RootArray = [[NSMutableArray alloc]initWithObjects:self.addressDict.allKeys,[[self.addressDict[string] firstObject] allKeys],[self.addressDict[string] firstObject][[[self.addressDict[string] firstObject] allKeys].firstObject], nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:self.addressDict.allKeys.firstObject,[[self.addressDict[string] firstObject] allKeys].firstObject,[[self.addressDict[string] firstObject][[[self.addressDict[string] firstObject] allKeys].firstObject] firstObject], nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case PickerTypeWeiBo://微博
        {
            NSMutableArray *list = [NSMutableArray new];
            for (int i=0; i<100; i++) {
                [list addObject:[NSString stringWithFormat:@"%d",1+i]];
            }
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list,@[@"万"], nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"1",@"万", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }
            break;
        case PickerTypeGameRank://段位
        {
            NSString *addressPath = [[NSBundle mainBundle]pathForResource:@"GameRankList" ofType:@"plist"];
            NSMutableArray *list = [[NSMutableArray alloc]initWithContentsOfFile:addressPath];
            self.RootArray = [[NSMutableArray alloc]initWithObjects:list, nil];
            self.selectArray = [[NSMutableArray alloc]initWithObjects:@"永恒钻石Ⅴ", nil];
            [self.pickerView reloadAllComponents];
            [self.pickerView selectRow:15 inComponent:0 animated:YES];
        }
            break;
        default:
            break;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIPickerView *picker = [[UIPickerView alloc]initWithFrame:frame];
        picker.delegate = self;
        picker.dataSource = self;
        [self addSubview:picker];
        self.pickerView = picker;
    }
    return self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.RootArray.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.RootArray[component] count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.RootArray[component][row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc]init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:25];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.Type == PickerTypeLocation) {
        if (component == 0) {
            NSString *string = self.addressDict.allKeys[row];
            NSArray *allKeys1 = self.addressDict.allKeys;
            NSArray *allKeys2 = [[self.addressDict[string] firstObject] allKeys];
            
            self.RootArray = [[NSMutableArray alloc]initWithObjects:allKeys1,allKeys2,[self.addressDict[string] firstObject][allKeys2.firstObject], nil];
            [self.selectArray replaceObjectAtIndex:1 withObject:allKeys2.firstObject];
            [self.selectArray replaceObjectAtIndex:2 withObject:[[self.addressDict[string] firstObject][allKeys2.firstObject] firstObject]];
            
            [pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }else if (component ==1){
            NSString *string = self.selectArray.firstObject;
            NSArray *allKeys1 = self.addressDict.allKeys;
            NSArray *allKeys2 = [[self.addressDict[string] firstObject] allKeys];
            
            self.RootArray = [[NSMutableArray alloc]initWithObjects:allKeys1,allKeys2,[self.addressDict[string] firstObject][allKeys2[row]], nil];
            [self.selectArray replaceObjectAtIndex:2 withObject:[[self.addressDict[string] firstObject][allKeys2[row]] firstObject]];
            
            [pickerView reloadAllComponents];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    [self.selectArray replaceObjectAtIndex:component withObject:self.RootArray[component][row]];
}
-(void)show:(FinishBlock)block{
    @weakify(self);
    [LEEAlert actionsheet].config
    .LeeCustomView(self)
    .LeeCancelAction(@"完成", ^{
        @strongify(self);
        block(self.selectArray);
    })
    .LeeShow();
}
@end
