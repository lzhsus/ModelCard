//
//  VerticalVersion.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "VerticalVersion.h"

@interface VerticalVersion ()

@end

@implementation VerticalVersion

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    UIImageView *show = [[UIImageView alloc]init];
    show.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-80);
    //设置 图片
    show.image = [UIImage imageNamed:@"01-S-03-04-1"];
    //设置内容的显示模式
    //UIViewContentModeScaleToFill 默认：填充整个视图（ImageView），拉伸图片，高宽比例会变形
    //UIViewContentModeScaleAspectFit 保证高宽比例，尽可能的最大显示但是，两边留白
    //UIViewContentModeScaleAspectFill 保证高宽比，不留白，但是图片会显示不全
    show.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    show.clipsToBounds = YES;
    
    [self.view addSubview:show];
    
    [self CreateBottomView];
    
    
    
}
-(void)CreateBottomView{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-80-64-40, self.view.frame.size.width, 80)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomView];
    UIImageView * SevenFigure = [[UIImageView alloc]init];
    SevenFigure.frame = CGRectMake(Width/2-90, 2, 36, 60);
    //设置 图片
    SevenFigure.image = [UIImage imageNamed:@"choice_template_one"];
    SevenFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    SevenFigure.clipsToBounds = YES;
    
    [bottomView addSubview:SevenFigure];
    
    UIImageView * NineFigure = [[UIImageView alloc]init];
    NineFigure.frame = CGRectMake(Width/2-18, 2, 36, 60);
    //设置 图片
    NineFigure.image = [UIImage imageNamed:@"choice_template_two"];
    NineFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    NineFigure.clipsToBounds = YES;
    
    [bottomView addSubview:NineFigure];
    
    UIImageView * FourFigure = [[UIImageView alloc]init];
    FourFigure.frame = CGRectMake(Width/2+54, 2, 36, 60);
    //设置 图片
    FourFigure.image = [UIImage imageNamed:@"01-S-03-04-1"];
    FourFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    FourFigure.clipsToBounds = YES;
    
    [bottomView addSubview:FourFigure];
    
    UILabel * SevenFigureL = [[UILabel alloc]initWithFrame:CGRectMake(Width/2-90, 62, 36, 18)];
    SevenFigureL.font = [UIFont systemFontOfSize:9];
    SevenFigureL.textColor = [UIColor whiteColor];
    SevenFigureL.textAlignment = NSTextAlignmentCenter;
    SevenFigureL.text = @"7图";
    [bottomView addSubview:SevenFigureL];
    
    UILabel * NineFigureL = [[UILabel alloc]initWithFrame:CGRectMake(Width/2-18, 62, 36, 18)];
    NineFigureL.font = [UIFont systemFontOfSize:9];
    NineFigureL.textColor = [UIColor whiteColor];
    NineFigureL.textAlignment = NSTextAlignmentCenter;
    NineFigureL.text = @"9图";
    [bottomView addSubview:NineFigureL];
    
    UILabel * FourFigureL = [[UILabel alloc]initWithFrame:CGRectMake(Width/2+54, 62, 36, 18)];
    FourFigureL.font = [UIFont systemFontOfSize:9];
    FourFigureL.textColor = [UIColor whiteColor];
    FourFigureL.textAlignment = NSTextAlignmentCenter;
    FourFigureL.text = @"4图";
    [bottomView addSubview:FourFigureL];
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

