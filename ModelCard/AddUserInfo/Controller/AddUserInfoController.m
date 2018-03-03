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
#import "TextFieldCell.h"
#import "PickInfoView.h"
#import "LiveTypeController.h"
#import "GameHeroController.h"
#import "GameServerController.h"
#import "GameMessageController.h"

@interface AddUserInfoController ()<UITableViewDelegate,UITableViewDataSource,ModelInfoCellDelegate>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * titleList;
@property (nonatomic,strong) NSMutableArray * contentList;
@property (nonatomic,strong) PickInfoView * pickView;
@end

@implementation AddUserInfoController

-(NSArray *)titleList{
    if (!_titleList) {
        switch (self.modelType) {
            case ModelTypeMoTe:
                _titleList = [[NSArray alloc]initWithObjects:@"昵称",@"性别",@"出生日期",@"身高(cm)",@"体重(kg)",@"三围",@"鞋码",@"地区",@[@"生日",@"三围"], nil];
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
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"男",@"2018-1-1",@"165",@"52",@"80-60-80",@"38",@"江西省-南昌市-青山湖区",@[@"1",@"1"], nil];
                break;
            case ModelTypeWangZhe:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"oneyian",@"男",@"荣耀王者",@"橘右京,诸葛亮,宫本武藏",@"50区 痛苦狙击",@"哈哈哈哈", nil];
                break;
            case ModelTypeYanYuan:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"男",@"2018-01-01",@"165",@"52",@"80-60-80",@"38",@"江西省-南昌市-青山湖区",@"15079244845",@[@"1"], nil];
                break;
            default:
                _contentList = [[NSMutableArray alloc]initWithObjects:@"安",@"熊猫",@"100W",@"oneyian",@"100W",@"男",@"2018-01-01",@"165",@"52",@"80-60-80",@"38",@"江西省-南昌市-青山湖区",@[@"1"], nil];
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
    tableView.separatorColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.17 alpha:1.00];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[ModelInfoCell class] forCellReuseIdentifier:@"ModelInfoCell"];
    [tableView registerClass:[TextFieldCell class] forCellReuseIdentifier:@"TextFieldCell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    // Do any additional setup after loading the view.
}
-(void)rightBtn:(UIButton *)sender{
    //下一步
    NSArray *size = [self loadModelData:self.model[@"SuperViewInfo"][@"size"]];
    if ([size.firstObject floatValue] > [size.lastObject floatValue]) {
        HModelImageController *model = [[HModelImageController alloc]init];
        model.modelDictionary = [[NSDictionary alloc]initWithDictionary:self.model];
        model.images = [[NSArray alloc]initWithArray:self.images];
        model.name = self.contentList.firstObject;
        model.contents = [[NSArray alloc]initWithArray:[self loadContents]];
        model.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:model animated:YES completion:nil];
    }else{
        VModelImageController *model = [[VModelImageController alloc]init];
        model.modelDictionary = [[NSDictionary alloc]initWithDictionary:self.model];
        model.images = [[NSArray alloc]initWithArray:self.images];
        model.name = self.contentList.firstObject;
        model.contents = [[NSArray alloc]initWithArray:[self loadContents]];
        [self.navigationController pushViewController:model animated:YES];
    }
}
-(NSMutableArray *)loadContents{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    //个人信息
    switch (self.modelType) {
        case ModelTypeMoTe:
        {
            [array addObject:[NSString stringWithFormat:@"H:%@cm",self.contentList[3]]];
            [array addObject:[NSString stringWithFormat:@"W:%@kg",self.contentList[4]]];
            [array addObject:[NSString stringWithFormat:@"S:%@",self.contentList[6]]];
            
            if ([[self.contentList.lastObject firstObject] isEqualToString:@"1"]) {
                [array addObject:[NSString stringWithFormat:@"BWH:%@",self.contentList[5]]];
            }
            if ([[self.contentList.lastObject lastObject] isEqualToString:@"1"]) {
                [array addObject:[NSString stringWithFormat:@"B:%@",self.contentList[2]]];
            }
        }
            break;
        case ModelTypeWangZhe:
        {
            
        }
            break;
        case ModelTypeYanYuan:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    return array;
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
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
            if (indexPath.row < 2) {
                //编辑昵称Cell
                TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
                cell.placeholder = indexPath.row == 0 ? @"请输入昵称":@"请输入游戏昵称";
                cell.FieldLength = indexPath.row == 0 ? 4:8;
                cell.titleString = self.titleList[indexPath.row];
                cell.contentString = self.contentList[indexPath.row];
                cell.subFieldText = [RACSubject subject];
                @weakify(self);
                [[cell.subFieldText takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    [self.contentList replaceObjectAtIndex:indexPath.row withObject:x];
                }];
                return cell;
            }else{
                //普通Cell
                UITableViewCell *cell = nil;
                cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
                }
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
        default:
        {
            if (indexPath.row == self.titleList.count-1) {
                //最底部Cell
                ModelInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ModelInfoCell" forIndexPath:indexPath];
                cell.titles = self.titleList[indexPath.row];
                cell.contents = self.contentList[indexPath.row];
                cell.delegate = self;
                return cell;
            }else{
                NSInteger row = 0;
                NSInteger lenght = 4;
                NSString *placeholder = @"请输入昵称";
                switch (self.modelType) {
                    case ModelTypeYanYuan:
                    {
                        row = 8;
                        lenght = 11;
                        placeholder = @"请输入联系方式";
                    }
                        break;
                    case ModelTypeZhuBo:
                    {
                        row = 3;
                        lenght = 9;
                        placeholder = @"请输入微博账号";
                    }
                        break;
                    default:
                        break;
                }
                
                if (indexPath.row == 0 || indexPath.row == row) {
                    //编辑昵称Cell
                    TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
                    cell.FieldLength = lenght;
                    cell.placeholder = indexPath.row == row ? placeholder:@"请输入昵称";
                    cell.titleString = self.titleList[indexPath.row];
                    cell.contentString = self.contentList[indexPath.row];
                    cell.subFieldText = [RACSubject subject];
                    @weakify(self);
                    [[cell.subFieldText takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
                        @strongify(self);
                        [self.contentList replaceObjectAtIndex:indexPath.row withObject:x];
                    }];
                    return cell;
                }else{
                    //普通Cell
                    UITableViewCell *cell = nil;
                    cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
                    if (!cell) {
                        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
                    }
                    cell.selectionStyle = 0;
                    cell.backgroundColor = ThemeColor;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text = self.titleList[indexPath.row];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.detailTextLabel.textColor = [UIColor whiteColor];
                    NSString *content = self.contentList[indexPath.row];
                    if ([cell.textLabel.text isEqualToString:@"三围"]) {
                        NSArray *array = [content componentsSeparatedByString:@"-"];
                        content = [NSString stringWithFormat:@"胸围%@ 腰围%@ 臀围%@",array[0],array[1],array[2]];
                    }
                    cell.detailTextLabel.text = content;
                    return cell;
                }
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
    if (indexPath.row == 0) return;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger indexType = 0;
    //根据总分类，将相同功能按 indexType 分离
    switch (self.modelType) {
        case ModelTypeMoTe:
        case ModelTypeYanYuan:
        {
            indexType = indexPath.row;
            if (indexType ==8) return;
        }
            break;
        case ModelTypeWangZhe:{
            if (indexPath.row ==1 ) return;
            switch (indexPath.row) {
                case 2:
                    indexType = 1;
                    break;
                case 3:
                    indexType = 9;
                    break;
                case 4:
                    indexType = 101;
                    break;
                case 5:
                    indexType = 102;
                    break;
                case 6:
                    indexType = 103;
                    break;
                default:
                    return;
            }
        }
            break;
        case ModelTypeZhuBo:{
            if (indexPath.row ==3 ) return;
            switch (indexPath.row) {
                case 1:
                    indexType = 100;
                    break;
                case 2:
                case 4:
                    indexType = 8;
                    break;
                default:
                    indexType = indexPath.row - 4;
                    break;
            }
        }
            break;
        default:
            return;
    }
    @weakify(self);
    //根据indexType决定功能
    switch (indexType) {
        case 1://性别
        {
            self.pickView.Type = PickerTypeSex;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = array.firstObject;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 2://生日
        {
            self.pickView.Type = PickerTypeDate;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                NSString *content = nil;
                for (NSString *aStr in array) {
                    if (!content) {
                        content = aStr;
                    }else{
                        content = [NSString stringWithFormat:@"%@-%@",content,aStr];
                    }
                }
                cell.detailTextLabel.text = content;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 3://身高
        {
            self.pickView.Type = PickerTypeHeight;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = array.firstObject;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 4://体重
        {
            self.pickView.Type = PickerTypeWeight;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = array.firstObject;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 5://三围
        {
            self.pickView.Type = PickerTypeSize;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@",array[0],array[1],array[2]];
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 6://脚码
        {
            self.pickView.Type = PickerTypeFoot;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = array.firstObject;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 7://地区
        {
            self.pickView.Type = PickerTypeLocation;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                NSString *content = nil;
                for (NSString *aStr in array) {
                    if (!content) {
                        content = aStr;
                    }else{
                        content = [NSString stringWithFormat:@"%@-%@",content,aStr];
                    }
                }
                cell.detailTextLabel.text = content;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 8://微博粉丝
        {
            self.pickView.Type = PickerTypeWeiBo;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",array.firstObject,array.lastObject];
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 9://王者段位
        {
            self.pickView.Type = PickerTypeGameRank;
            [self.pickView show:^(id value) {
                @strongify(self);
                NSArray *array = (NSArray *)value;
                cell.detailTextLabel.text = array.firstObject;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
        }
            break;
        case 100://直播平台
        {
            LiveTypeController *live = [[LiveTypeController alloc]init];
            live.subLives = [RACSubject subject];
            [live.subLives subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                cell.detailTextLabel.text = x;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
            [self.navigationController pushViewController:live animated:YES];
        }
            break;
        case 101://常用英雄
        {
            GameHeroController *hero = [[GameHeroController alloc]init];
            hero.subHeros = [RACSubject subject];
            [hero.subHeros subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                cell.detailTextLabel.text = x;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
            [self.navigationController pushViewController:hero animated:YES];
        }
            break;
        case 102://游戏区服
        {
            GameServerController *server = [[GameServerController alloc]init];
            server.subName = [RACSubject subject];
            [server.subName subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                cell.detailTextLabel.text = x;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
            [self.navigationController pushViewController:server animated:YES];
        }
            break;
        case 103://常用语
        {
            GameMessageController *mesage = [[GameMessageController alloc]init];
            mesage.subMessage = [RACSubject subject];
            [mesage.subMessage subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                cell.detailTextLabel.text = x;
                [self.contentList replaceObjectAtIndex:indexPath.row withObject:cell.detailTextLabel.text];
            }];
            [self.navigationController pushViewController:mesage animated:YES];
        }
            break;
        default:
            return;
    }
}
-(PickInfoView *)pickView{
    if (!_pickView) {
        _pickView = [[PickInfoView alloc]initWithFrame:CGRectMake(0, 0, Width-30, 200)];
    }
    return _pickView;
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
