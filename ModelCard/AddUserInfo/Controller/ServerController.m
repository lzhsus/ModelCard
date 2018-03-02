//
//  ServerController.m
//  ModelCard
//
//  Created by iMac on 2018/3/2.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ServerController.h"

@interface ServerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * leftTableView;
@property (nonatomic,strong) UITableView * rightTableView;
@property (nonatomic,assign) NSInteger selectRow;
@property (nonatomic,assign) NSInteger selectName;
@end

@implementation ServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ThemeColor;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, Height-NavigationTop-40) style:UITableViewStyleGrouped];
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableView.backgroundColor = ThemeColor;
    tableView.separatorColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.17 alpha:1.00];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.selectRow = 0;
    self.selectName = -1;
    [self.view addSubview:tableView];
    self.leftTableView = tableView;
    
    UITableView *rTableView = [[UITableView alloc]initWithFrame:CGRectMake(tableView.frame.size.width, 0, Width-tableView.frame.size.width, tableView.frame.size.height)];
    rTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    rTableView.backgroundColor = ThemeColor;
    rTableView.separatorStyle = 0;
    rTableView.estimatedSectionFooterHeight = 0;
    rTableView.estimatedSectionHeaderHeight = 0;
    rTableView.delegate = self;
    rTableView.dataSource = self;
    [self.view addSubview:rTableView];
    self.rightTableView = rTableView;
    
    [Oneyian initNotification:self selector:@selector(changeView) name:@"changeView" object:nil];
}
-(void)dealloc{
    [Oneyian removeAllNotification:self];
}
-(void)changeView{
    [self.subName sendNext:@""];
    self.selectName = -1;
    [self.rightTableView reloadData];
}
#pragma mark  =========== UITableView ==========
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count;
    if (tableView == self.leftTableView) {
        count = self.ServerList.count;
    }else{
        NSDictionary *dict = (NSDictionary *)self.ServerList[self.selectRow];
        count = [dict[dict.allKeys.firstObject] count];
    }
    return count;
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
    if (tableView == self.leftTableView) {
        NSDictionary *dict = (NSDictionary *)self.ServerList[indexPath.row];
        cell.textLabel.text = dict.allKeys.firstObject;
        cell.textLabel.textColor = indexPath.row == self.selectRow ? [UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]:[UIColor whiteColor];
    }else{
        NSDictionary *dict = (NSDictionary *)self.ServerList[self.selectRow];
        cell.textLabel.text = dict[dict.allKeys.firstObject][indexPath.row];
        cell.textLabel.textColor = indexPath.row == self.selectName ? [UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]:[UIColor whiteColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        self.selectRow = indexPath.row;
        self.selectName = -1;
        [self.subName sendNext:@""];
        [tableView reloadData];
        [self.rightTableView reloadData];
    }else{
        self.selectName = indexPath.row;
        NSDictionary *dict = (NSDictionary *)self.ServerList[self.selectRow];
        [self.subName sendNext:dict[dict.allKeys.firstObject][self.selectName]];
        [tableView reloadData];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
