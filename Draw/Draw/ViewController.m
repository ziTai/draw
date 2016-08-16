//
//  ViewController.m
//  Draw
//
//  Created by _ziTai on 16/1/27.
//  Copyright © 2016年 ziTai. All rights reserved.
//

#import "ViewController.h"
#import "Lines.h"
#import "BaseView.h"
@interface ViewController ()
{
    Lines       *_line;
    NSMutableArray      *_lineArr;
    Lines       *_recLines;
    NSMutableArray *_arr;
    UITextField *_countTextField;
    NSArray        *_colorArr;
    int             _selected;
    
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _lineArr = [[NSMutableArray alloc]init];
    _arr = [[NSMutableArray alloc]init];

    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.rowHeight = 20;
    _colorArr = @[@"红色",@"蓝色",@"绿色",@"黄色",@"青色",@"ziTai"];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureActive:)];
    [self.view addGestureRecognizer:panGesture];


    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(CGRectGetMaxX([[UIScreen mainScreen]bounds]) - 120, 20, 100, 40);
    [button1 setTitle:@"后退" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button1];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = CGRectMake(20, 20, 100, 40);
    [button2 setTitle:@"前进" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goforward) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:button2];


    _countTextField = [[UITextField alloc]init];
    _countTextField.frame = CGRectMake(20, CGRectGetMaxY([[UIScreen mainScreen] bounds]) - 50, 50, 30);
    _countTextField.backgroundColor = [UIColor cyanColor];
    _countTextField.text = @"3";
    [self.view addSubview:_countTextField];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _colorArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == _selected)
    {
        cell.backgroundColor = [UIColor orangeColor];
    }
    else
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [_colorArr objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selected = indexPath.row;
    [_myTableView reloadData];
}
- (IBAction)clearButton:(id)sender
{
    [_lineArr removeAllObjects];
    [self.view setNeedsDisplay];
}
-(void)goback
{
    if (_lineArr.count > 0)
    {
        _recLines = [_lineArr lastObject];
        [_arr addObject:_recLines];

        [_lineArr removeLastObject];
        [self.view setNeedsDisplay];
    }
}
-(void)goforward
{
    if (_recLines&&_arr.count > 0)
    {
        [_lineArr addObject:[_arr lastObject]];
        [_arr removeLastObject];
        [self.view setNeedsDisplay];
    }

}
-(void)panGestureActive:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
//            NSLog(@"开始");
            _line = [[Lines alloc]init];
            _line.width = _countTextField.text.floatValue;
            _line.colorNum = _selected;
             [_lineArr addObject:_line];
//            BaseView *view = (BaseView*)self.view;
//            view.width = _countTextField.text.floatValue;;
            [gesture.view setNeedsDisplay];
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
//            NSLog(@"过程");
            CGPoint point = [gesture locationInView:gesture.view];
            NSValue *value = [NSValue valueWithCGPoint:point];
            [_line.points addObject:value];


            BaseView *view = (BaseView*)self.view;
            view.lineArr = _lineArr;
            [view setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
//            NSLog(@"结束");
        }
            break;

        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
