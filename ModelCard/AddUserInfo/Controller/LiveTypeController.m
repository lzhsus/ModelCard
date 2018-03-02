//
//  LiveTypeController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "LiveTypeController.h"
#import "LiveTypeCell.h"
#import "UITextField+Length.h"

@interface LiveTypeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UICollectionView * collection;

@property (nonatomic,strong) NSMutableArray * liveArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@end

@implementation LiveTypeController

-(NSMutableArray *)liveArray{
    if (!_liveArray) {
        _liveArray = [[NSMutableArray alloc]initWithObjects:@"映客",@"花椒",@"鲜肉",@"来疯",@"ME",@"颜值",@"一直播",@"哈你",@"微博",@"YY",@"网易",@"CC",@"淘宝",@"奇秀",@"熊猫",@"斗鱼",@"龙珠",@"虎牙",@"繁星",@"易直播",@"么么",@"战旗TV",@"B站",@"Up直播",@"添加标签", nil];
    }
    return _liveArray;
}
-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]initWithCapacity:3];
    }
    return _selectArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    self.title = @"直播平台";
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 40, 15, 15)];
    imageView.image = [UIImage imageNamed:@"online_live_fans"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 37.5, 200, 20)];
    label.text = @"点击选择（可多选）";
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(80, 20);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 8;
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 95, Width-20, Height/2) collectionViewLayout:flowLayout];
    collection.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    collection.delegate=self;
    collection.dataSource=self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    collection.backgroundColor = self.view.backgroundColor;
    [collection registerClass:[LiveTypeCell class] forCellWithReuseIdentifier:@"LiveTypeCell"];
    [self.view addSubview:collection];
    self.collection = collection;
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(30, Height - NavigationTop -  100, Width-60, 40)];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00] forState:UIControlStateNormal];
    [save makeCornerRadius:4];
    [save makeBorderWidth:1 withColor:save.titleLabel.textColor];
    @weakify(self);
    [[save rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.selectArray.count == 0) return;
        [self.subLives sendNext:[self.selectArray componentsJoinedByString:@","]];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:save];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liveArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveTypeCell" forIndexPath:indexPath];
    cell.titleString = self.liveArray[indexPath.item];
    cell.selecteds = [self.selectArray containsObject:cell.titleString];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.liveArray.count-1) {
        //自添加直播平台
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请填写平台名称，最长6个字符" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            @strongify(self);
            textField.delegate = self;
            textField.placeholder = @"请输入平台名称";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            UITextField *textField = (UITextField *)alert.textFields.firstObject;
            [self.liveArray insertObject:textField.text atIndex:indexPath.row];
            [collectionView reloadData];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        LiveTypeCell *cell = (LiveTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.selecteds) {
            //已选中，执行撤销
            cell.selecteds = !cell.selecteds;
            [self.selectArray removeObject:cell.titleString];
        }else{
            //未选中，执行选中
            if (self.selectArray.count >= 3) return;
            cell.selecteds = !cell.selecteds;
            [self.selectArray addObject:cell.titleString];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField setFieldtext:6];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField setRange:range whitString:string whitCount:6];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
