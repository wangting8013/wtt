//
//  ViewController.m
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import "ViewController.h"

#import "popItemView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titleArray = @[@"品牌",@"适用季节",@"人群",@"分类"];
    
    NSArray *itemArray = @[@[@"花花公子",@"占地吉普",@"美特斯邦威",@"南极人",@"神马",@"AR",@"济蓝",@"罗蒙",@"恒源祥",@"北极绒"],
                           @[@"冬季",@"夏季",@"四季",@"秋季",@"春季"],
                           @[@"青年",@"青少年",@"中年",@"老年",@"大码人群",@"情侣装",@"大码",@"其他"],
                           @[@"长袖体恤",@"长袖连衣裙",@"短袖体恤",@"套装裙",@"棉体恤",@"背心裙",@"吊带裙",@"背带裙",@"纯色体恤",@"印花体恤",@"文艺体恤"]];
    
    popItemView *view = [[popItemView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 260)];
    view.titleArray = titleArray;
    view.itemArray = itemArray;
    
    [view setSelectDataBlock:^(NSDictionary *dic) {
        
        NSMutableDictionary *selectDic = [[NSMutableDictionary alloc]init];
        for (int i = 0;i<dic.allKeys.count;i++) {
            //获取分类数据
            NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[dic objectForKey:dic.allKeys[i]]];
            
            //替换数据
            for (int j = 0; j<array.count; j++) {
                NSString *str = [itemArray[[dic.allKeys[i] intValue]] objectAtIndex:[array[j] intValue]];
                [array replaceObjectAtIndex:j withObject:str];
            }
            [selectDic setObject:array forKey:titleArray[[dic.allKeys[i] intValue]]];
        }
    }];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
