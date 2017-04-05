//
//  ViewController.m
//  WTT_TabbarForPage
//
//  Created by W on 2017/4/5.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import "ViewController.h"
#import "CMScrollPageView.h"

#define DEF_UICOLORFROMRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property (nonatomic, strong)CMScrollPageView *cmScrollPageView;
- (IBAction)handelSegementControlAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CGRect  frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UIView *firstView = [[UIView alloc]initWithFrame:frame];
    firstView.backgroundColor = [UIColor magentaColor];
    UIView *secondView = [[UIView alloc]initWithFrame:frame];
    secondView.backgroundColor = [UIColor cyanColor];
    UIView *thirdView = [[UIView alloc]initWithFrame:frame];
    thirdView.backgroundColor = [UIColor brownColor];
    
    //将视图添加到标签页上
    NSArray *array = [[NSArray alloc]initWithObjects:firstView,secondView,thirdView,nil];
    
    if (self.cmScrollPageView == nil) {
        self.cmScrollPageView = [[CMScrollPageView alloc] initWithFrame:frame];
        
        [self.cmScrollPageView setItems:@"第一个" otherItems:@"第二个",@"第三个",nil];
        [self.cmScrollPageView setContentOfView:array];
        [self.view addSubview:self.cmScrollPageView];
    }
    
    [self setShowType:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)handelSegementControlAction:(id)sender {
    UISegmentedControl *sement = (UISegmentedControl *)sender;
    
    [self setShowType:sement.selectedSegmentIndex];
}

-(void)setShowType:(NSInteger)type{
    
    if (type == 0) {
        
        self.cmScrollPageView.move_type = backgroundViewType;
        self.cmScrollPageView.moveViewWidth_percent = 0.9;
        self.cmScrollPageView.itemSelectColor = [UIColor colorWithRed:252.0/255.0 green:97.0/255.0 blue:81.0/255.0 alpha:1.0];
        self.cmScrollPageView.itemUnSelectColor = [UIColor whiteColor];
        self.cmScrollPageView.middleLineColor = [UIColor whiteColor];
        self.cmScrollPageView.bottomLineColor = [UIColor clearColor];
        self.cmScrollPageView.moveViewColor = [UIColor whiteColor];
        self.cmScrollPageView.headerBackgroundColor = [UIColor colorWithRed:252.0/255.0 green:97.0/255.0 blue:81.0/255.0 alpha:1.0];
    }else{
        self.cmScrollPageView.move_type = lineViewType;
        self.cmScrollPageView.moveViewWidth_percent = 0.9;
        self.cmScrollPageView.itemSelectColor = [UIColor colorWithRed:252.0/255.0 green:97.0/255.0 blue:81.0/255.0 alpha:1.0];
        self.cmScrollPageView.itemUnSelectColor = [UIColor grayColor];
        self.cmScrollPageView.middleLineColor = DEF_UICOLORFROMRGB(0xe7e7e7);
        self.cmScrollPageView.bottomLineColor = DEF_UICOLORFROMRGB(0xe7e7e7);
        self.cmScrollPageView.moveViewColor = [UIColor colorWithRed:252.0/255.0 green:97.0/255.0 blue:81.0/255.0 alpha:1.0];
        self.cmScrollPageView.headerBackgroundColor = [UIColor whiteColor];
    }
}
@end
