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

@interface AddUserInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation AddUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = ThemeColor;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
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
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 150;
    }
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 5) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = 0;
        cell.backgroundColor = ThemeColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @[@"昵称",@"性别",@"出生日期",@"身高(cm)",@"体重(kg)",][indexPath.row];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.text = @[@"安",@"男",@"2018-01-01",@"165",@"52",][indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = 0;
        cell.backgroundColor = ThemeColor;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0 && indexPath.row < 5) {
        switch (indexPath.row) {
            case 1:
            {

            }
                break;
            case 2:
            {
                
            }
                break;
            case 3:
            {
                
            }
                break;
            case 4:
            {
                
            }
                break;
            default:
                break;
        }
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
