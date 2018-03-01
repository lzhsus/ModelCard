//
//  GameServerController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "GameServerController.h"

@interface GameServerController ()
@property (nonatomic,strong) NSArray * serverList;
@end

@implementation GameServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏区服";
    self.view.backgroundColor = BackgroundColor;
    // Do any additional setup after loading the view.
    
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"gameServerName" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    self.serverList = [[NSArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"data"]];
    
//    {
//                    "id":"73",
//                    "parentId":"0",
//                    "level":"1",
//                    "key":null,
//                    "value":"微信ios",
//                    "isDelete":"N"
//                },{
//                        "id":"77",
//                        "parentId":"73",
//                        "level":"2",
//                        "key":null,
//                        "value":"1-20区",
//                        "isDelete":"N"
//                    },{
//                            "id":"100",
//                            "parentId":"77",
//                            "level":"3",
//                            "key":"w-1-1",
//                            "value":"1区 徇烂刀锋",
//                            "isDelete":"N"
//                        },
    
    NSMutableArray *root = [[NSMutableArray alloc]init];
    NSMutableArray *typeList = [[NSMutableArray alloc]init];
    NSMutableArray *serverList = [[NSMutableArray alloc]init];
    NSMutableArray *nameList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dict in self.serverList) {
        if ([dict[@"level"] integerValue] == 1) {
            [typeList addObject:@{@"id":@"73",@"value":@"微信ios"}];
        }else if ([dict[@"level"] integerValue] == 2){
            [serverList addObject:@{@"id":@"77",@"parentId":@"73",@"value":@"1-20区"}];
        }else{
            [nameList addObject:@{@"parentId":@"77",@"value":@"1区 徇烂刀锋"}];
        }
    }
    
    for (NSDictionary *type in typeList) {
        NSInteger tid = [type[@"id"] integerValue];
        NSMutableArray *subServer = [[NSMutableArray alloc]init];
        
        for (NSDictionary *server in serverList) {
            if ([server[@"parentId"] integerValue] == tid) {
                NSInteger sid = [type[@"id"] integerValue];
                NSMutableArray *subName = [[NSMutableArray alloc]init];
                
                for (NSDictionary *name in nameList) {
                    if ([name[@"parentId"] integerValue] == sid) {
                        [subName addObject:name[@"value"]];
                    }
                }
                [subServer addObject:@{server[@"value"]:subName}];
            }
        }
        [root addObject:@{type[@"value"]:subServer}];
    }
    
    
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
