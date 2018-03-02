//
//  GameMessageController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "GameMessageController.h"
#import "UITextField+Length.h"

@interface GameMessageController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,assign) NSInteger selectRow;
@property (nonatomic,strong) NSMutableArray * messageList;
@end

@implementation GameMessageController

-(NSMutableArray *)messageList{
    if (!_messageList) {
        _messageList = [[NSMutableArray alloc]initWithObjects:@"猥琐发育，别浪！",@"稳住，我们能赢！",@"跟着我！",@"等等我，马上到！",@"我拿Buff，谢谢！",@"集合，准备团战！",@"拖住，我偷塔",@"全体进攻中路！",@"优先推塔！",@"准备越塔强攻！",@"正在前往支援！",@"上去开团！",@"等我集合打团！",@"我来抓人了！",@"[ 手动添加 ]", nil];
    }
    return _messageList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常用语";
    self.view.backgroundColor = BackgroundColor;
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"保存" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop)];
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableView.backgroundColor = ThemeColor;
    tableView.separatorColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.17 alpha:1.00];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
#pragma mark  =========== UITableView ==========
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = 0;
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.text = self.messageList[indexPath.row];
    cell.textLabel.textColor = indexPath.row == self.selectRow ? [UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]:[UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.messageList.count-1) {
        //自添加直播平台
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请填写常用语，最长15个字符" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        @weakify(self);
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            @strongify(self);
            textField.delegate = self;
            textField.placeholder = @"请输入常用语";
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            @strongify(self);
            UITextField *textField = (UITextField *)alert.textFields.firstObject;
            [self.messageList insertObject:textField.text atIndex:indexPath.row];
            [tableView reloadData];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        self.selectRow = indexPath.row;
        [tableView reloadData];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField setFieldtext:15];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField setRange:range whitString:string whitCount:15];
}
-(void)rightBtn:(UIButton *)sender{
    if (isStringEmpty(self.messageList[self.selectRow])) return;
    [self.subMessage sendNext:self.messageList[self.selectRow]];
    [self.navigationController popViewControllerAnimated:YES];
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
