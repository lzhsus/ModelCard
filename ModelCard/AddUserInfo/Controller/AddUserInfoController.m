//
//  AddUserInfoController.m
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "AddUserInfoController.h"
#import "HModelImageController.h"
#import "VModelImageController.h"
#import "ModelInfoCell.h"

@interface AddUserInfoController ()<UITableViewDelegate,UITableViewDataSource,ModelInfoCellDelegate>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * titleList;
@property (nonatomic,strong) NSMutableArray * contentList;
@end

@implementation AddUserInfoController

-(NSArray *)titleList{
    if (!_titleList) {
        switch (self.modelType) {
            case ModelTypeMoTe:
                _titleList = [[NSArray alloc]initWithObjects:@"昵称",@"性别",@"出生日期",@"身高(cm)",@"体重(kg)",@"三围",@"鞋码",@"地区",@"地区",@"地区",@"地区",@"地区",@"地区",@[@"生日",@"三围"], nil];
                break;
            case ModelTypeWangZhe:
                _titleList = [[NSArray alloc]initWithObjects:@"昵称",@"游戏昵称",@"性别",@"排位段位",@"常用英雄",@"游戏区服",@"常用语", nil];
                break;
            case ModelTypeYanYuan:
                _titleList = [[NSArray alloc]initWithObjects:@"昵称",@"性别",@"出生日期",@"身高(cm)",@"体重(kg)",@"三围",@"鞋码",@"地区",@"联系方式",@[@"联系方式"], nil];
                break;
            default:
                _titleList = [[NSArray alloc]initWithObjects:@"昵称",@"直播平台",@"直播粉丝",@"微博账号",@"微博粉丝",@"性别",@"出生日期",@"身高(cm)",@"体重(kg)",@"三围",@"鞋码",@"地区",@[@"微博账号"], nil];
                break;
        }
    }
    return _titleList;
}
-(NSArray *)contentList{
    if (!_contentList) {
        switch (self.modelType) {
            case ModelTypeMoTe:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"男",@"2018-01-01",@"165",@"52",@"80-60-80",@"38",@"江西-南昌",@"地区",@"地区",@"地区",@"地区",@"地区",@[@"1",@"1"], nil];
                break;
            case ModelTypeWangZhe:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"oneyian",@"男",@"荣耀王者",@"橘右京-诸葛亮-宫本武藏",@"50区-痛苦狙击",@"哈哈哈哈", nil];
                break;
            case ModelTypeYanYuan:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"男",@"2018-01-01",@"165",@"52",@"80-60-80",@"38",@"江西-南昌",@"15079244845",@[@"1"], nil];
                break;
            default:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"熊猫",@"100W",@"oneyian",@"100W",@"男",@"2018-01-01",@"165",@"52",@"80-60-80",@"38",@"江西-南昌",@[@"1"], nil];
                break;
        }
    }
    return _contentList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = ThemeColor;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"下一步" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorHex:@"#3A3538"];
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[ModelInfoCell class] forCellReuseIdentifier:@"ModelInfoCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    // Do any additional setup after loading the view.
}
-(void)rightBtn:(UIButton *)sender{
    NSArray *size = [self loadModelData:self.model[@"SuperViewInfo"][@"size"]];
    if ([size.firstObject floatValue] > [size.lastObject floatValue]) {
        HModelImageController *model = [[HModelImageController alloc]init];
        model.modelDictionary = [[NSDictionary alloc]initWithDictionary:self.model];
        model.images = [[NSArray alloc]initWithArray:self.images];
        model.name = @"安";
        model.content = @"info";
        model.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:model animated:YES completion:nil];
    }else{
        VModelImageController *model = [[VModelImageController alloc]init];
        model.modelDictionary = [[NSDictionary alloc]initWithDictionary:self.model];
        model.images = [[NSArray alloc]initWithArray:self.images];
        model.name = @"安";
        model.content = @"info";
        [self.navigationController pushViewController:model animated:YES];
    }
}
-(NSArray *)loadModelData:(NSString *)aString{
    aString = [aString stringByReplacingOccurrencesOfString:@"{"withString:@""];
    aString = [aString stringByReplacingOccurrencesOfString:@"}"withString:@""];
    NSRange range = [aString rangeOfString:@","];
    return range.location != NSNotFound ? [aString componentsSeparatedByString:@","]:[aString componentsSeparatedByString:@"，"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.modelType) {
        case ModelTypeWangZhe:
            return 50;
        default:
            if (indexPath.row == self.titleList.count-1) {
                return 200;
            }
            return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.modelType) {
        case ModelTypeWangZhe:
        {
            UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
            cell.selectionStyle = 0;
            cell.backgroundColor = ThemeColor;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.titleList[indexPath.row];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.text = self.contentList[indexPath.row];
            return cell;
        }
        default:
        {
            if (indexPath.row == self.titleList.count-1) {
                ModelInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ModelInfoCell" forIndexPath:indexPath];
                cell.titles = self.titleList[indexPath.row];
                cell.contents = self.contentList[indexPath.row];
                cell.delegate = self;
                return cell;
            }else{
                UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
                cell.selectionStyle = 0;
                cell.backgroundColor = ThemeColor;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = self.titleList[indexPath.row];
                cell.textLabel.textColor = [UIColor lightGrayColor];
                cell.detailTextLabel.textColor = [UIColor whiteColor];
                cell.detailTextLabel.text = self.contentList[indexPath.row];
                return cell;
            }
        }
    }
}
-(void)didChangeIndex:(NSInteger)index Status:(BOOL)status{
    if ([self.contentList[self.contentList.count-1] isKindOfClass:[NSArray class]]) {
        NSMutableArray *data = [[NSMutableArray alloc]initWithArray:self.contentList[self.contentList.count-1]];
        [data replaceObjectAtIndex:index withObject:status ? @"1":@"0"];
        [self.contentList replaceObjectAtIndex:self.contentList.count-1 withObject:data];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
