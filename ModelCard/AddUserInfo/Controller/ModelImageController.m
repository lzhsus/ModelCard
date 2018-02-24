//
//  ModelImageController.m
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ModelImageController.h"
#import "UIDevice+YADevice.h"
#import "AppDelegate.h"
#import "AddUserInfoController.h"
#import "YAScrollView.h"
#import "UIButton+Category.h"

@interface ModelImageController ()<YAScrollViewDelegate>
@property (nonatomic,strong) UIView * BackView;

@property (nonatomic,strong) NSArray * rectArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@property (nonatomic,strong) NSDictionary * modelDictionary;

@property (nonatomic,strong) UIButton * changeButton;
@end

@implementation ModelImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    self.view.backgroundColor = [UIColor colorWithRed:0.23 green:0.21 blue:0.22 alpha:1.00];
    
    UIView *NavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 64)];
    NavigationView.backgroundColor = ThemeColor;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake((NavigationView.frame.size.width-50)/2, 12, 50, 20)];
    title.text = @"编辑";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((NavigationView.frame.size.width-150)/2, 37, 150, 15)];
    titleImage.image = [UIImage imageNamed:@"middle_tip_icon"];
    titleImage.contentMode = UIViewContentModeScaleAspectFit;
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 64)];
    [back setImage:[UIImage imageNamed:@"zuojiantou"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(NavigationView.frame.size.width - 64, 0, 44, 64)];
    [done setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(done.frame.origin.x - 100, 0, 44, 64)];
    [edit setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIImage *editImage = [UIImage imageNamed:@"compile_edit"];
    [edit setImage:editImage forState:UIControlStateNormal];
    [edit setImgViewStyle:ButtonStyleRight imageSize:editImage.size space:4];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    [NavigationView addSubview:title];
    [NavigationView addSubview:titleImage];
    [NavigationView addSubview:back];
    [NavigationView addSubview:done];
    [NavigationView addSubview:edit];
    [self.view addSubview:NavigationView];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(45, NavigationView.frame.size.height, AutoWidth([[self loadModelData:self.modelDictionary[@"SuperViewInfo"][@"size"]].firstObject floatValue]), Height-NavigationView.frame.size.height)];
    view.backgroundColor = [UIColor whiteColor];
    UIPanGestureRecognizer *move = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveToPoint:)];
    [view addGestureRecognizer:move];
    [self.view addSubview:view];
    self.BackView = view;
    
    NSArray *imageList = [[NSMutableArray alloc]initWithObjects:@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height", nil];
    
    for (int i =0; i<self.rectArray.count; i++) {
        CGRect rect = [self loadViewRect:self.rectArray[i]];
        YAScrollView *firstView = [[YAScrollView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-rect.origin.x, rect.size.height-rect.origin.y) Image:[UIImage imageNamed:imageList[i]]];
        firstView.YADelegate = self;
        firstView.tag = i+1;
        [self.BackView addSubview:firstView];
    }
    NSArray *points = [[NSArray alloc]initWithArray:self.modelDictionary[@"viewPoint"]];
    for (int i=0; i<points.count; i++) {
        NSArray *aArray = [self loadModelData:points[i]];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake([aArray[0] floatValue], [aArray[1] floatValue], [aArray[2] floatValue], [aArray[3] floatValue])];
        title.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                title.text = @"A";
                title.textColor = [UIColor redColor];
                break;
            case 1:
                title.text = @"B";
                title.textColor = [UIColor blueColor];
                break;
            case 2:
                title.text = @"C";
                title.textColor = [UIColor cyanColor];
                break;
            default:
                title.text = [NSString stringWithFormat:@"%dL",i];
                title.textColor = [UIColor whiteColor];
                break;
        }
        [title makeBorderWidth:i+2 withColor:title.textColor];
        [self.BackView addSubview:title];
    }
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake((Width-250)/2, Height - SafeArea(55, 45), 250, 30)];
    [slider setMaximumValue:self.BackView.frame.size.width + 90 - Width];
    [slider setThumbImage:[UIImage imageNamed:@"slide_btn_icon"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:[UIImage new] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"slide_bg_icon"] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    UIButton *changeButton = [[UIButton alloc]init];
    [changeButton setAlpha:0.9];
    [changeButton setBackgroundColor:[UIColor colorHex:@"#E7586E"]];
    [changeButton makeCornerRadius:6];
    //[changeImage setTitleColor: forState:UIControlStateNormal];
    [changeButton setTitle:@"替换" forState:UIControlStateNormal];
    [changeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIImage *changeImage = [UIImage imageNamed:@"picture_edit_icon"];
    [changeButton setImage:changeImage forState:UIControlStateNormal];
    [changeButton setImgViewStyle:ButtonStyleLeft imageSize:editImage.size space:4];
    [changeButton addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    changeButton.hidden = YES;
    [self.BackView addSubview:changeButton];
    self.changeButton = changeButton;
    
}
#pragma mark  =========== 导航栏View按钮 ==========
-(void)sliderChanged:(UISlider *)sender{
    self.BackView.frame = CGRectMake(45 - sender.value, self.BackView.frame.origin.y, self.BackView.frame.size.width, self.BackView.frame.size.height);
}
-(void)back:(UIButton *)sender{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)done:(UIButton *)sender{
    self.changeButton.hidden = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存提示" message:@"您需要保存到相册？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum([self screenShotView:self.BackView], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)edit:(UIButton *)sender{
    self.changeButton.hidden = YES;
    sender.selected = !sender.isSelected;
    self.BackView.backgroundColor = sender.isSelected ? [UIColor blackColor]:[UIColor whiteColor];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *status = nil;
    if (!error) {
        status = @"保存成功";
    }else{
        status = @"保存失败";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:status message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
-(UIImage *)screenShotView:(UIView *)view{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}
#pragma mark  =========== 图片区块 ==========
-(void)moveToPoint:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.BackView];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:{//点击
            self.changeButton.hidden = YES;
            for (int i = 0; i< self.rectArray.count; i++) {
                CGRect rect = [self loadViewRect:self.rectArray[i]];
                if ([self isPointInRect:rect Point:point]) {
                    [self.selectArray addObject:[NSString stringWithFormat:@"%d",i+1]];
                    return;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{//移动
            for (int i = 0; i< self.rectArray.count; i++) {
                CGRect rect = [self loadViewRect:self.rectArray[i]];
                YAScrollView *view = (YAScrollView *)[self.BackView viewWithTag:i+1];
                view.layer.borderWidth = 0;
                if ([self isPointInRect:rect Point:point]) {
                    if (self.selectArray.firstObject == nil) {
                        [self.selectArray addObject:[NSString stringWithFormat:@"%d",i+1]];
                        break;
                    }
                    if ([self.selectArray.firstObject intValue] == i+1) continue;
                    [view makeBorderWidth:3 withColor:[UIColor colorHex:@"#E7586E"]];
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{//结束
            for (int i = 0; i< self.rectArray.count; i++) {
                CGRect rect = [self loadViewRect:self.rectArray[i]];
                YAScrollView *view = (YAScrollView *)[self.BackView viewWithTag:i+1];
                view.layer.borderWidth = 0;
                if ([self isPointInRect:rect Point:point]) {
                    if ([self.selectArray.firstObject intValue] == i+1) break;
                    [self.selectArray addObject:[NSString stringWithFormat:@"%d",i+1]];
                }
            }
            [self changeScrollViewFrame:self.selectArray];
        }
            break;
        default:
            break;
    }
}
-(void)changeScrollViewFrame:(NSMutableArray *)list{
    if (list.count == 2) {
        YAScrollView *first = (YAScrollView *)[self.BackView viewWithTag:[list.firstObject intValue]];
        YAScrollView *last = (YAScrollView *)[self.BackView viewWithTag:[list.lastObject intValue]];
        CGRect firstFrame = first.frame;
        CGRect lastFrame = last.frame;
        //交换位置与Tag
        [first setNewFrame:lastFrame animated:YES];
        [last setNewFrame:firstFrame animated:YES];
        first.tag = [list.lastObject intValue];
        last.tag = [list.firstObject intValue];
    }
    [self.selectArray removeAllObjects];
}
-(void)touchInScrollView:(UIScrollView *)scrollView{
    self.changeButton.frame = CGRectMake(scrollView.frame.origin.x+(scrollView.frame.size.width-80)/2, scrollView.frame.origin.y+(scrollView.frame.size.height-30)/2, 80, 30);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.changeButton.hidden = !weakSelf.changeButton.isHidden;
    }];
    if (!self.changeButton.isHidden) {
        self.changeButton.tag = scrollView.tag;
    }
}
-(void)changeImage:(UIButton *)sender{
    NSLog(@"%ld",sender.tag);
    
}
#pragma mark  =========== 数据解析 ==========
-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}
-(NSDictionary *)modelDictionary{
    if (!_modelDictionary) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:self.plistName ofType:@"plist"];
        _modelDictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return _modelDictionary;
}
-(NSArray *)rectArray{
    if (!_rectArray) {
        _rectArray = [[NSArray alloc]initWithArray:self.modelDictionary[@"SubViewArray"]];
    }
    return _rectArray;
}
-(NSArray *)loadModelData:(NSString *)aString{
    aString = [aString stringByReplacingOccurrencesOfString:@"{"withString:@""];
    aString = [aString stringByReplacingOccurrencesOfString:@"}"withString:@""];
    NSRange range = [aString rangeOfString:@","];
    return range.location != NSNotFound ? [aString componentsSeparatedByString:@","]:[aString componentsSeparatedByString:@"，"];
}
-(CGRect)loadViewRect:(NSDictionary *)aDict{
    CGFloat x = AutoWidth([[self loadModelData:aDict[@"pointArray"][0]].firstObject floatValue]);
    CGFloat y = AutoHeight([[self loadModelData:aDict[@"pointArray"][0]].lastObject floatValue]);
    CGFloat w = AutoWidth([[self loadModelData:aDict[@"pointArray"][2]].firstObject floatValue]);
    CGFloat h = AutoHeight([[self loadModelData:aDict[@"pointArray"][2]].lastObject floatValue]);
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}
-(BOOL)isPointInRect:(CGRect)aRect Point:(CGPoint)aPoint{
    return aPoint.x >= aRect.origin.x && aPoint.x <= aRect.size.width && aPoint.y >= aRect.origin.y && aPoint.y <= aRect.size.height ? YES:NO;
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
