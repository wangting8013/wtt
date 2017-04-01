//
//  popItemView.m
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import "popItemView.h"
#import "ItemListView.h"
#import "TitlebackgroundView.h"

#define DEFAULT_COLOR [UIColor colorWithRed:245.0/255.0f green:245.0/255.0f blue:245.0/255.0f alpha:1.0f]

@interface popItemView ()

@property (nonatomic, strong)ItemListView *itemView;

@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic,strong)TitlebackgroundView *titleBackView;

@property (nonatomic,strong)UIImageView *selectImageView;

@end

@implementation popItemView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.clipsToBounds = YES;
        
        self.itemView = [[ItemListView alloc]initWithFrame:CGRectMake(0, -260, self.frame.size.width, 260)];
        __weak popItemView *weakSelf = self;
        [self.itemView setSureBtnBlock:^(NSDictionary *dic) {
            [weakSelf itemShowClick:weakSelf.selectBtn];
            
            if (weakSelf.selectDataBlock) {
                weakSelf.selectDataBlock(dic);
            }
        }];
        [self addSubview:self.itemView];
        
    }
    
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self creatTitleButtonView];
}

-(UIView *)creatTitleButtonView{
    
    self.titleBackView = [[TitlebackgroundView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.titleBackView.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc]initWithFrame:self.titleBackView.frame];
    view.backgroundColor = DEFAULT_COLOR;
    
    [self addSubview:view];
    [view addSubview:self.titleBackView];
    
    for (int i = 0;i<self.titleArray.count;i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(15.0 + ((self.frame.size.width - 15.0)/self.titleArray.count)*i, 7.5, (self.frame.size.width - 15.0*self.titleArray.count)/self.titleArray.count, 25.0)];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setBackgroundColor:DEFAULT_COLOR];
        button.layer.cornerRadius = 3;
        button.tag = i;
        
        [button setImage:[UIImage imageNamed:@"click_down"] forState:UIControlStateNormal];
        
        
        
        button.imageView.frame = CGRectMake(15.0+([UIScreen mainScreen].bounds.size.width/self.titleArray.count)*i, 7.5, 13,7);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width, 0, -button.titleLabel.frame.size.width);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, 0, button.imageView.frame.size.width+5);
        
        [button addTarget:self action:@selector(itemShowClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBackView addSubview:button];
        
        
    }
    
    
    return self.titleBackView;
}

-(void)itemShowClick:(id)sender{
    
    CGFloat Y = 0;
    
    UIButton *btn = (UIButton *)sender;
    
    //点击相同按钮 回缩view 否则刷新页面数据
    if (self.selectBtn == btn && self.itemView.frame.origin.y==0) {
        Y = -260;
        
        btn.imageView.transform = CGAffineTransformIdentity;
    }else{
        self.selectBtn.backgroundColor = DEFAULT_COLOR;
        self.itemView.itemArray = self.itemArray[btn.tag];
        self.itemView.numKey = [NSString stringWithFormat:@"%ld",btn.tag];
        [self.itemView setView];
        
        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    self.selectBtn = btn;
    
    [UIView animateWithDuration:0.55 animations:^{
        
        //根据页面位置设置显示效果
        if (Y == -260) {
            self.titleBackView.showRect = CGRectMake(0, 0, 0, 0);
            btn.backgroundColor = DEFAULT_COLOR;
        }else{
            btn.backgroundColor = [UIColor clearColor];
            self.titleBackView.showRect = btn.frame;
        }
        
        self.itemView.frame = CGRectMake(0, Y, self.frame.size.width, 260);
        
        //更新背景绘制
        [self.titleBackView setNeedsDisplay];
    }];
    
}

@end
