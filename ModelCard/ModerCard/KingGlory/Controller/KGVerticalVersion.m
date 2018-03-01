//
//  KGVerticalVersion.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "KGVerticalVersion.h"
#import "ImagesView.h"
#import "AppDelegate.h"
#import "AddUserInfoController.h"
@interface KGVerticalVersion ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImagesViewDelegae>
@property (nonatomic,strong) NSArray * modelArray;
@property (nonatomic,strong) ImagesView * selectImages;

@end

@implementation KGVerticalVersion{
    UIImageView * FiveFigure;
    UIImageView * SevenFigure;
    UIImageView * NineFigure;
    UIImageView * TwelveFigure;
    UIImageView *show;
    NSDictionary *_ModelDict;
    UIImageView *imageView;
    int i ;
}
-(NSArray *)modelArray{
    if (!_modelArray) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:self.modelName ofType:@"plist"];
        _modelArray = [[NSArray alloc]initWithContentsOfFile:plistPath];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    i = 0;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    show = [[UIImageView alloc]init];
    show.frame = CGRectMake(0, 50, Width, Width);
    //设置 图片
    show.image = [UIImage imageNamed:@"choice_template_one"];
    //设置内容的显示模式
    //UIViewContentModeScaleToFill 默认：填充整个视图（ImageView），拉伸图片，高宽比例会变形
    //UIViewContentModeScaleAspectFit 保证高宽比例，尽可能的最大显示但是，两边留白
    //UIViewContentModeScaleAspectFill 保证高宽比，不留白，但是图片会显示不全
    show.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    show.clipsToBounds = YES;
    show.userInteractionEnabled = YES;//打开用户交互
    [self.view addSubview:show];
    
    [self CreateBottomView];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self.selectImages];
    
}
-(void)CreateBottomView{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, Height-SafeArea(114, 80)-NavigationTop-40, Width, SafeArea(114, 80))];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomView];
    FiveFigure = [[UIImageView alloc]init];
    FiveFigure.frame = CGRectMake(Width/5, 2, 36, 60);
    //设置 图片
    FiveFigure.image = [UIImage imageNamed:@"choice_template_one"];
    FiveFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    FiveFigure.clipsToBounds = YES;
    FiveFigure.userInteractionEnabled = YES;//打开用户交互
    FiveFigure.layer.borderColor=[[UIColor redColor]CGColor];  //边框的颜色
    FiveFigure.layer.borderWidth = 1;
    [bottomView addSubview:FiveFigure];
    
    SevenFigure = [[UIImageView alloc]init];
    SevenFigure.frame = CGRectMake(2*(Width/5)-12, 2, 36, 60);
    //设置 图片
    SevenFigure.image = [UIImage imageNamed:@"choice_template_two"];
    SevenFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    SevenFigure.clipsToBounds = YES;
    SevenFigure.userInteractionEnabled = YES;//打开用户交互
    [bottomView addSubview:SevenFigure];
    
    NineFigure = [[UIImageView alloc]init];
    NineFigure.frame = CGRectMake((Width/5)*3-24, 2, 36, 60);
    //设置 图片
    NineFigure.image = [UIImage imageNamed:@"01-S-03-04-1"];
    NineFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    NineFigure.clipsToBounds = YES;
    NineFigure.userInteractionEnabled = YES;//打开用户交互
    [bottomView addSubview:NineFigure];
    
    TwelveFigure = [[UIImageView alloc]init];
    TwelveFigure.frame = CGRectMake((Width/5)*4-36, 2, 36, 60);
    //设置 图片
    TwelveFigure.image = [UIImage imageNamed:@"01-S-03-04-1"];
    TwelveFigure.contentMode = UIViewContentModeScaleAspectFit;
    //第三种需要 配合 切割， 所有超出当前视图frame的所有子视图的显示部分都会被切割掉
    TwelveFigure.clipsToBounds = YES;
    TwelveFigure.userInteractionEnabled = YES;//打开用户交互
    [bottomView addSubview:TwelveFigure];
    
    UILabel * FiveFigureL = [[UILabel alloc]initWithFrame:CGRectMake(Width/5, 62, 36, 18)];
    FiveFigureL.font = [UIFont systemFontOfSize:9];
    FiveFigureL.textColor = [UIColor whiteColor];
    FiveFigureL.textAlignment = NSTextAlignmentCenter;
    FiveFigureL.text = @"5图";
    [bottomView addSubview:FiveFigureL];
    
    UILabel * SevenFigureL = [[UILabel alloc]initWithFrame:CGRectMake(2*(Width/5)-12, 62, 36, 18)];
    SevenFigureL.font = [UIFont systemFontOfSize:9];
    SevenFigureL.textColor = [UIColor whiteColor];
    SevenFigureL.textAlignment = NSTextAlignmentCenter;
    SevenFigureL.text = @"7图";
    [bottomView addSubview:SevenFigureL];
    
    UILabel * NineFigureL = [[UILabel alloc]initWithFrame:CGRectMake((Width/5)*3-24, 62, 36, 18)];
    NineFigureL.font = [UIFont systemFontOfSize:9];
    NineFigureL.textColor = [UIColor whiteColor];
    NineFigureL.textAlignment = NSTextAlignmentCenter;
    NineFigureL.text = @"9图";
    [bottomView addSubview:NineFigureL];
    
    UILabel * TwelveFigureL = [[UILabel alloc]initWithFrame:CGRectMake((Width/5)*4-36, 62, 36, 18)];
    TwelveFigureL.font = [UIFont systemFontOfSize:9];
    TwelveFigureL.textColor = [UIColor whiteColor];
    TwelveFigureL.textAlignment = NSTextAlignmentCenter;
    TwelveFigureL.text = @"12图";
    [bottomView addSubview:TwelveFigureL];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [[event allTouches] anyObject];

    if ([touch view] == FiveFigure)
    {
        //do some method.....
        NSLog(@"7");
        FiveFigure.layer.borderColor=[[UIColor redColor]CGColor];  //边框的颜色
        FiveFigure.layer.borderWidth = 1; //边框的宽度
        SevenFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        NineFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        TwelveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        show.image = [UIImage imageNamed:@"choice_template_one"];
        i = 0;
    }else if ([touch view] == SevenFigure){
        SevenFigure.layer.borderColor=[[UIColor redColor]CGColor];
        SevenFigure.layer.borderWidth = 1;
        FiveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        NineFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        TwelveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        show.image = [UIImage imageNamed:@"choice_template_two"];
        i = 1;
    }else if ([touch view] == NineFigure){
        NineFigure.layer.borderColor=[[UIColor redColor]CGColor];
        NineFigure.layer.borderWidth = 1;
        SevenFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        FiveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        TwelveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        show.image = [UIImage imageNamed:@"01-S-03-04-1"];
        i = 2;
    }else if ([touch view] == TwelveFigure){
        TwelveFigure.layer.borderColor=[[UIColor redColor]CGColor];
        TwelveFigure.layer.borderWidth = 1;
        FiveFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        SevenFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        NineFigure.layer.borderColor=[[UIColor clearColor]CGColor];
        show.image = [UIImage imageNamed:@"01-S-03-04-1"];
        i = 3;
    }else if ([touch view ] == show){
        NSString *modelPath = [[NSBundle mainBundle]pathForResource:self.modelArray[i] ofType:@"plist"];
        _ModelDict = [[NSDictionary alloc]initWithContentsOfFile:modelPath];
        self.selectImages.count = [NSArray arrayWithArray:_ModelDict[@"SubViewArray"]].count;

        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        self.selectImages.popViewController = ipc;
        ipc.delegate = self;

        self.selectImages.hidden = NO;
        @weakify(self);
        [UIView animateWithDuration:0.21 animations:^{
            @strongify(self);
            self.selectImages.frame = CGRectMake(0, Height-150, Width, 150);
        }];
        
        [self presentViewController:ipc animated:YES completion:nil];
    }

}
-(ImagesView *)selectImages{
    if (!_selectImages) {
        _selectImages = [[ImagesView alloc]initWithFrame:CGRectMake(0, Height-150, Width, 150)];
        _selectImages.count = 0;
        _selectImages.delegate = self;
    }
    return _selectImages;
}
-(void)didFinishImages:(NSArray *)images{
    AddUserInfoController *add = [[AddUserInfoController alloc]init];
    add.model = [[NSDictionary alloc]initWithDictionary:_ModelDict];
    add.images = [[NSArray alloc]initWithArray:images];
    [self.navigationController pushViewController:add animated:YES];
    [self.selectImages.popViewController dismissViewControllerAnimated:YES completion:nil];
    self.selectImages.count = 0;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.selectImages.count = 0;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.selectImages didAddImage:info[UIImagePickerControllerOriginalImage]];
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
