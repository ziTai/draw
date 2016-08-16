//
//  BaseView.m
//  Draw
//
//  Created by _ziTai on 16/1/27.
//  Copyright © 2016年 ziTai. All rights reserved.
//

#import "BaseView.h"
#import "Lines.h"
@implementation BaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_lineArr enumerateObjectsUsingBlock:^(Lines* obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        //2.设置线条的宽度
        CGContextSetLineWidth(context,obj.width);
        //3.设置线条的颜色
        UIColor *color;
        int r = arc4random()%256;
        int g = arc4random()%256;
        int b = arc4random()%256;
        switch (obj.colorNum)
        {
            case 0:
                color = [UIColor redColor];
                break;
            case 1:
                color = [UIColor blueColor];
                break;
            case 2:
                color = [UIColor greenColor];
                break;
            case 3:
                color = [UIColor yellowColor];
                break;
            case 4:
                color = [UIColor cyanColor];
                break;
            case 5:
                color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
            default:
                break;
        }
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        [obj.points enumerateObjectsUsingBlock:^(NSValue* obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             CGPoint point = obj.CGPointValue;
             if (idx == 0) {
                 recPoint = obj.CGPointValue;
             }
             //移动画笔
             CGContextMoveToPoint(context,recPoint.x,recPoint.y);
             CGContextAddLineToPoint(context, point.x, point.y);
             //开始画 stroke 一笔一画
             CGContextStrokePath(context);
             recPoint = point;
         }];
    }];


}
@end
