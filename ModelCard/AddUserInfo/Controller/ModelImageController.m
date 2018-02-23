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

@interface ModelImageController ()
@property (nonatomic,strong) UIView * BackView;

@property (nonatomic,strong) NSArray * rectArray;
@property (nonatomic,strong) NSMutableArray * selectArray;
@end

@implementation ModelImageController

-(NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}
-(NSArray *)rectArray{
    if (!_rectArray) {
        _rectArray = [[NSArray alloc]initWithObjects:
                      @{@"x":@"2",@"y":@"2",@"w":@"200",@"h":@"305"},
                      @{@"x":@"204",@"y":@"2",@"w":@"150",@"h":@"150"},
                      @{@"x":@"204",@"y":@"154",@"w":@"150",@"h":@"150"},
                      @{@"x":@"356",@"y":@"2",@"w":@"200",@"h":@"200"},
                      @{@"x":@"356",@"y":@"204",@"w":@"300",@"h":@"100"},
                      @{@"x":@"558",@"y":@"2",@"w":@"100",@"h":@"200"},nil];
    }
    return _rectArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.view.backgroundColor = ThemeColor;
    self.title = @"编辑";
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(44, 20, 44, 44)];
    [done setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [done setTitle:@"完成" forState:UIControlStateHighlighted];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:done];
    
    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(100, 20, 44, 44)];
    [edit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [edit setTitle:@"编辑" forState:UIControlStateHighlighted];
    [edit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:edit];
    // Do any additional setup after loading the view.
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, Width, Height-64)];
    view.backgroundColor = [UIColor whiteColor];
    UIPanGestureRecognizer *move = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveToPoint:)];
    [view addGestureRecognizer:move];
    [self.view addSubview:view];
    self.BackView = view;
    
    NSArray *imageList = [[NSMutableArray alloc]initWithObjects:@"width",@"height",@"width",@"height",@"width",@"height", nil];
    
    for (int i =0; i<self.rectArray.count; i++) {
        YAScrollView *firstView = [[YAScrollView alloc]initWithFrame:CGRectMake([self.rectArray[i][@"x"] floatValue], [self.rectArray[i][@"y"] floatValue], [self.rectArray[i][@"w"] floatValue], [self.rectArray[i][@"h"] floatValue]) Image:[UIImage imageNamed:imageList[i]]];
        firstView.tag = i+1;
        [self.BackView addSubview:firstView];
    }
}

-(void)done:(UIButton *)sender{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)edit:(UIButton *)sender{
    UIImageWriteToSavedPhotosAlbum([self screenShotView:self.BackView], self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *status = nil;
    if (!error) {
        status = @"保存成功";
    }else{
        status = @"保存失败";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:status preferredStyle:UIAlertControllerStyleAlert];
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
            for (int i = 0; i< self.rectArray.count; i++) {
                CGFloat x = [self.rectArray[i][@"x"] floatValue];
                CGFloat y = [self.rectArray[i][@"y"] floatValue];
                CGFloat w = [self.rectArray[i][@"w"] floatValue];
                CGFloat h = [self.rectArray[i][@"h"] floatValue];
                if (point.x >= x && point.x <= x+w && point.y >= y && point.y <=y+h) {
                    [self.selectArray addObject:[NSString stringWithFormat:@"%d",i+1]];
                    return;
                }
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{//移动
            for (int i = 0; i< self.rectArray.count; i++) {
                CGFloat x = [self.rectArray[i][@"x"] floatValue];
                CGFloat y = [self.rectArray[i][@"y"] floatValue];
                CGFloat w = [self.rectArray[i][@"w"] floatValue];
                CGFloat h = [self.rectArray[i][@"h"] floatValue];
                YAScrollView *view = (YAScrollView *)[self.BackView viewWithTag:i+1];
                view.layer.borderWidth = 0;
                if (point.x >= x && point.x <= x+w && point.y >= y && point.y <=y+h) {
                    if (self.selectArray.firstObject == nil) {
                        [self.selectArray addObject:[NSString stringWithFormat:@"%d",i+1]];
                        break;
                    }
                    if ([self.selectArray.firstObject intValue] == i+1) continue;
                    view.layer.borderWidth = 3;
                    view.layer.borderColor = [UIColor colorHex:@"#E7586E"].CGColor;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:{//结束
            for (int i = 0; i< self.rectArray.count; i++) {
                CGFloat x = [self.rectArray[i][@"x"] floatValue];
                CGFloat y = [self.rectArray[i][@"y"] floatValue];
                CGFloat w = [self.rectArray[i][@"w"] floatValue];
                CGFloat h = [self.rectArray[i][@"h"] floatValue];
                YAScrollView *view = (YAScrollView *)[self.BackView viewWithTag:i+1];
                view.layer.borderWidth = 0;
                if (point.x >= x && point.x <= x+w && point.y >= y && point.y <=y+h) {
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
