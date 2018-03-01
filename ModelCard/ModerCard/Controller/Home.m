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
#import "KingGloryCard.h"
#import "ActorCard.h"
#import "HostCard.h"

@interface Home ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIImageView *HeadImgView; //!< 头部图像
@end

@implementation Home
-(instancetype)init{
    if (self = [super init]) {
        //这里会把 navigationItem.title 和 tabBarItem.title 同时设置
        self.title = @"模卡";
        self.navigationItem.title = @"买萌模卡";
        [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorHex:@"#E7586E"]} forState:UIControlStateSelected];
        self.tabBarItem.image = [UIImage imageOriginalImageName:@"moderCard_tab"];
        self.tabBarItem.selectedImage = [UIImage imageOriginalImageName:@"moderCard_tab_select"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = ThemeColor;
    [self.view addSubview:tableView];
    
    self.HeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, HeadImgHeight)];
    self.HeadImgView.image = [UIImage imageNamed:@"eee"];
    tableView.tableHeaderView = self.HeadImgView;
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
        imageView.frame =CGRectMake(0, 0, Width, 120);
        imageView.image = [UIImage imageNamed:@"work_home1" ];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [cell.contentView addSubview:imageView];
    }
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    UILabel *instructionsLabel = [cell.contentView viewWithTag:103];
    if (titleLabel == nil){ //如果 cell中没有我们自己定义的 这个Label， 那么我就创建一个添加到cell中
        titleLabel = [[UILabel alloc]init];
        titleLabel.tag = 100;
        titleLabel.frame = CGRectMake(0, 20,Width, 30);
        //        label.font = [UIFont italicSystemFontOfSize:36];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        //        titleLabel.backgroundColor = [UIColor blueColor];
        titleLabel.textColor = [UIColor whiteColor];
        [cell.contentView addSubview:titleLabel];
    }
    if (instructionsLabel == nil){ //如果 cell中没有我们自己定义的 这个Label， 那么我就创建一个添加到cell中
        instructionsLabel = [[UILabel alloc]init];
        instructionsLabel.tag = 103;
        instructionsLabel.frame = CGRectMake(0, 55, Width, 30);
        instructionsLabel.font = [UIFont italicSystemFontOfSize:10];
        
        instructionsLabel.textAlignment = NSTextAlignmentCenter;
        //        instructionsLabel.backgroundColor = [UIColor blueColor];
        instructionsLabel.textColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:instructionsLabel];
    }
    if (indexPath.row == 0) {
        titleLabel.textColor = [UIColor colorHex:@"#E7586E"];
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
    switch (indexPath.row) {
        case 0:{
            ModelCard *ModelCardVC = [[ModelCard alloc]init];
            ModelCardVC.titleName = @"模特卡";
            ModelCardVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ModelCardVC animated:YES];
        }
            break;
        case 1:{
            KingGloryCard * KingGloryVC = [[KingGloryCard alloc]init];
            KingGloryVC.modelName = @"FModel";//插入2
            KingGloryVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:KingGloryVC animated:YES];
        }
            break;
        case 2:{
            ActorCard *ActorCardVC = [[ActorCard alloc]init];
            ActorCardVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ActorCardVC animated:YES];
        }
            break;
        case 3:{
            HostCard *HostCardVC = [[HostCard alloc]init];
            HostCardVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:HostCardVC animated:YES];
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
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

