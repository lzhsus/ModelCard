//
//  Home.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "Home.h"
#import "ModelCard.h"
#import "UIImage+Category.h"

#define HeadImgHeight 180

@interface Home ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIImageView *HeadImgView; //!< 头部图像
@end

@implementation Home
-(instancetype)init{
    if (self = [super init]) {
        //这里会把 navigationItem.title 和 tabBarItem.title 同时设置
        self.title = @"模卡";
        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeColor} forState:UIControlStateSelected];
        self.tabBarItem.image = [UIImage imageOriginalImageName:@"moderCard_tab"];
        self.tabBarItem.selectedImage = [UIImage imageOriginalImageName:@"moderCard_tab_select"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*  设置属性字符串  */
    //创建一个属性字典
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    dic[NSForegroundColorAttributeName] = [UIColor greenColor];
//    dic[NSFontAttributeName] = [UIFont systemFontOfSize:30];
//    dic[NSBackgroundColorAttributeName] = [UIColor blueColor];
//    //设置 导航条上title的字体
//    self.navigationController.navigationBar.titleTextAttributes = dic;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //记住tableView 一定要设置数据源对象
    tableView.dataSource = self;
    //设置tableView 的delegate
    tableView.delegate = self;
    [self.view addSubview:tableView];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight)];
    self.HeadImgView.image = [UIImage imageNamed:@"eee"];
    
    [tableView addSubview:self.HeadImgView];
    
    // 与图像高度一样防止数据被遮挡
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
// 每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// cell定制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UIImageView*imageView = [cell.contentView viewWithTag:101];
    if (imageView == nil) {
        imageView = [[UIImageView alloc]init];
        imageView.tag = 101;
        imageView.frame =CGRectMake(0, 0, self.view.frame.size.width, 120);
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = [UIImage imageNamed:@"work_home1" ];
        [cell.contentView addSubview:imageView];
    }
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    UILabel *instructionsLabel = [cell.contentView viewWithTag:103];
    if (titleLabel == nil){ //如果 cell中没有我们自己定义的 这个Label， 那么我就创建一个添加到cell中
        titleLabel = [[UILabel alloc]init];
        titleLabel.tag = 100;
        titleLabel.frame = CGRectMake(100, 20, cell.frame.size.width-100, 30);
        //        label.font = [UIFont italicSystemFontOfSize:36];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //        titleLabel.backgroundColor = [UIColor blueColor];
        titleLabel.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
    }
    if (instructionsLabel == nil){ //如果 cell中没有我们自己定义的 这个Label， 那么我就创建一个添加到cell中
        instructionsLabel = [[UILabel alloc]init];
        instructionsLabel.tag = 103;
        instructionsLabel.frame = CGRectMake(100, 55, cell.frame.size.width-100, 30);
        instructionsLabel.font = [UIFont italicSystemFontOfSize:10];
        
        instructionsLabel.textAlignment = NSTextAlignmentCenter;
        //        instructionsLabel.backgroundColor = [UIColor blueColor];
        instructionsLabel.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:instructionsLabel];
    }
    if (indexPath.row == 0) {
        titleLabel.textColor = [UIColor redColor];
        titleLabel.text = @"[ 模特卡 ]";
        instructionsLabel.text = @"专业模特让你获得更多通告机会";
    }else if (indexPath.row == 1){
        titleLabel.text = @"[ 王者荣耀卡 ]";
        instructionsLabel.text = @"秀脸秀战绩，荣耀玩家特供";
    }else if (indexPath.row == 2){
        titleLabel.text = @"[ 演员卡 ]";
        instructionsLabel.text = @"影视演员专业Casting制作";
    }else if (indexPath.row == 3){
        titleLabel.text = @"[ 主播卡 ]";
        instructionsLabel.text = @"网红通告合作必备";
    }else{
        titleLabel.text = @"[ 视频模卡 ]";
        instructionsLabel.text = @"专业视频模卡一键生成";
    }
    
    return cell;
}

// 选中每一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        ModelCard *ModelCardVC = [[ModelCard alloc]init];
        ModelCardVC.titleName = @"模特卡";
        ModelCardVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ModelCardVC animated:YES];
    }
  
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
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

