//
//  ViewController.h
//  Draw
//
//  Created by _ziTai on 16/1/27.
//  Copyright © 2016年 ziTai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

