//
//  TitlebackgroundView.m
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import "TitlebackgroundView.h"

@implementation TitlebackgroundView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat radius = 2;
    
    //用起始点开始
    CGContextMoveToPoint(ctx, x, y);
    
    //画直线
    CGContextAddLineToPoint(ctx, x+width, y);
    
    
    //直线
    CGContextAddLineToPoint(ctx, x+width, y+height);
    
    
    //凸出直线
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.showRect), y+height);
    
    //直线+弧度
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(self.showRect), self.showRect.origin.y+radius);
    
    //画弧线
    CGContextAddArcToPoint(ctx, CGRectGetMaxX(self.showRect), self.showRect.origin.y, CGRectGetMaxX(self.showRect)-radius,self.showRect.origin.y, radius);
    
    //直线
    CGContextAddLineToPoint(ctx, self.showRect.origin.x + radius, self.showRect.origin.y);
    
    //画弧线
    CGContextAddArcToPoint(ctx, self.showRect.origin.x, self.showRect.origin.y, self.showRect.origin.x,self.showRect.origin.y+radius, radius);
    
    //直线
    CGContextAddLineToPoint(ctx, self.showRect.origin.x, self.showRect.origin.y+radius);
    
    //直线
    CGContextAddLineToPoint(ctx, self.showRect.origin.x, y+height);
    
    //直线
    CGContextAddLineToPoint(ctx, x, y+height);
    
    CGContextClosePath(ctx);
    
    CGContextSetRGBFillColor (ctx,  1, 1, 1, 1.0);//设置填充颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithDisplayP3Red:229.0/255.0f green:229.0/255.0f blue:229.0/255.0f alpha:1.0].CGColor);
    
    CGContextDrawPath(ctx, kCGPathFillStroke); //根据坐标绘制路径
    
}




@end
