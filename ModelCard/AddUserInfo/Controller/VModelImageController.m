//
//  VModelImageController.m
//  ModelCard
//
//  Created by iMac on 2018/2/26.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "VModelImageController.h"
#import "YAScrollView.h"
#import "UIButton+Category.h"

@interface VModelImageController ()<YAScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIView * BackView;

@property (nonatomic,strong) NSArray * rectArray;
@property (nonatomic,strong) NSMutableArray * selectArray;

@property (nonatomic,strong) UIButton * changeButton;
@end

@implementation VModelImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    self.title = @"编辑";
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [done setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:done];
    [self.navigationItem setRightBarButtonItems:@[rightButton]];
    
    // Do any additional setup after loading the view.
    //所有区块的背景
    NSArray *size = [self loadModelData:self.modelDictionary[@"SuperViewInfo"][@"size"]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((Width-AutoWidth([size.firstObject floatValue]))/2, 45, AutoWidth([size.firstObject floatValue]), AutoHeight([size.lastObject floatValue]))];
    view.backgroundColor = [UIColor whiteColor];
    UIPanGestureRecognizer *move = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveToPoint:)];
    [view addGestureRecognizer:move];
    [self.view addSubview:view];
    self.BackView = view;
    
    //图片区块
    for (int i =0; i<self.rectArray.count; i++) {
        CGRect rect = [self loadViewRect:self.rectArray[i]];
        YAScrollView *firstView = [[YAScrollView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-rect.origin.x, rect.size.height-rect.origin.y) Image:self.images[i]];
        firstView.YADelegate = self;
        firstView.tag = i+1;
        [self.BackView addSubview:firstView];
    }
    
    //个人信息
    NSArray *points = [[NSArray alloc]initWithArray:self.modelDictionary[@"viewPoint"]];
    for (int i=0; i<points.count; i++) {
        NSArray *aArray = [self loadModelData:points[i]];
        CGRect viewRect =  CGRectMake([aArray[0] floatValue], [aArray[1] floatValue], [aArray[2] floatValue], [aArray[3] floatValue]);
        
        CGPoint point1 = CGPointMake(viewRect.origin.x, viewRect.origin.y);
        CGPoint point2 = CGPointMake(viewRect.origin.x+viewRect.size.width, viewRect.origin.y+viewRect.size.height);
        CGPoint point3 = CGPointMake(viewRect.origin.x+viewRect.size.width, viewRect.origin.y);
        CGPoint point4 = CGPointMake(viewRect.origin.x, viewRect.origin.y+viewRect.size.height);
        
        BOOL isPoint = YES;
//        for (int i =0; i<self.rectArray.count; i++) {
//            CGRect rect = [self loadViewRect:self.rectArray[i]];
//            if ([self isPointInRect:rect Point:point1] || [self isPointInRect:rect Point:point2] || [self isPointInRect:rect Point:point3] || [self isPointInRect:rect Point:point4]) {
//                isPoint = NO;
//                break;
//            }
//        }
        if (isPoint) {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(viewRect.origin.x, viewRect.origin.y, viewRect.size.width, viewRect.size.height)];
            title.textAlignment = NSTextAlignmentCenter;
            switch (i) {
                case 0:
                    title.text = self.name;
                    title.textColor = [UIColor redColor];
                    break;
                case 1:
                    title.text = self.content;
                    title.textColor = [UIColor blueColor];
                    break;
                default:
                    title.text = [NSString stringWithFormat:@"%d",i];
                    title.textColor = [UIColor blueColor];
                    break;
            }
            [title makeBorderWidth:i+1 withColor:title.textColor];
            [self.BackView addSubview:title];
        }
    }
    
    //滑动条
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(Width-150, (Height-30)/2, 250, 30)];
    CGFloat maxValue = self.BackView.frame.size.height + 90 + NavigationTop + SafeArea(54, 20) - Height;
    if (maxValue <= SafeArea(99, 65)) {
        slider.hidden = YES;
    }else{
        [slider setMaximumValue:maxValue];
    }
    [slider setThumbImage:[UIImage imageNamed:@"slide_btn_icon"] forState:UIControlStateNormal];
    UIImage *minTrack = [[[UIImage imageNamed:@"slide_bg_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    [slider setMinimumTrackImage:minTrack forState:UIControlStateNormal];
    [slider setMaximumTrackImage:minTrack forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    CGAffineTransform transform=  CGAffineTransformRotate(slider.transform, M_PI_2);
    [slider setTransform:transform];
    [self.view addSubview:slider];
    
    //替换
    UIButton *changeButton = [[UIButton alloc]init];
    [changeButton setAlpha:0.9];
    [changeButton setBackgroundColor:[UIColor colorHex:@"#E7586E"]];
    [changeButton makeCornerRadius:6];
    [changeButton setTitle:@"替换" forState:UIControlStateNormal];
    [changeButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIImage *changeImage = [UIImage imageNamed:@"picture_edit_icon"];
    [changeButton setImage:changeImage forState:UIControlStateNormal];
    [changeButton setImgViewStyle:ButtonStyleLeft imageSize:changeImage.size space:4];
    [changeButton addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    changeButton.hidden = YES;
    [self.BackView addSubview:changeButton];
    self.changeButton = changeButton;
    
    //编辑
    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(0, Height-NavigationTop-SafeArea(74, 40), Width, SafeArea(74, 40))];
    [edit setBackgroundColor:[UIColor colorHex:@"#E6576D"]];
    [edit setTitle:@"点击编辑" forState:UIControlStateNormal];
    [edit.titleLabel setFont:[UIFont systemFontOfSize:15]];
    UIImage *editImage = [UIImage imageNamed:@"icon_upward"];
    [edit setImage:editImage forState:UIControlStateNormal];
    [edit setImgViewStyle:ButtonStyleRight imageSize:editImage.size space:4];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:edit];
}
#pragma mark  =========== 导航栏按钮 ==========
-(void)done:(UIButton *)sender{
    self.changeButton.hidden = YES;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存提示" message:@"您需要保存到相册？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum([self screenShotView:self.BackView], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *title = nil;
    NSString *message = nil;
    
    if (!error) {
        title = @"保存成功";
        message = @"请进入[相册]查看模卡";
    }else{
        title = @"保存失败";
        message = @"请换个姿势再试一试";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
-(void)edit:(UIButton *)sender{
    self.changeButton.hidden = YES;
    sender.selected = !sender.isSelected;
    self.BackView.backgroundColor = sender.isSelected ? [UIColor blackColor]:[UIColor whiteColor];
}
-(void)sliderChanged:(UISlider *)sender{
    self.BackView.frame = CGRectMake(self.BackView.frame.origin.x, 45 - sender.value, self.BackView.frame.size.width, self.BackView.frame.size.height);
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
    Weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        Strongify(weakSelf);
        strongSelf.changeButton.hidden = !weakSelf.changeButton.isHidden;
    }];
    if (!self.changeButton.isHidden) {
        self.changeButton.tag = scrollView.tag;
    }
}
-(void)changeImage:(UIButton *)sender{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    YAScrollView *view = (YAScrollView *)[self.BackView viewWithTag:self.changeButton.tag];
    [view setNewImage:info[UIImagePickerControllerOriginalImage]];
}
#pragma mark  =========== 数据解析 ==========
-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
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
