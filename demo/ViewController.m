//
//  ViewController.m
//  demo
//
//  Created by 周希财 on 2017/3/2.
//  Copyright © 2017年 iOS_ZXC. All rights reserved.
//

#import "ViewController.h"
#import "ZXCTableViewCell.h"
#import "demoTableViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) demoTableViewController *demo;
@property (nonatomic, assign) CGRect currentRect;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UIImageView *currentImage;
@property (nonatomic, assign) ZXCTableViewCell *zxcCell;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"demo";
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView{

    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:@"ZXCTableViewCell" bundle:nil ] forCellReuseIdentifier:@"ZXCTableViewCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return .1f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ZXCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZXCTableViewCell" forIndexPath:indexPath];
    cell.ZXCImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row % 3 + 1]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
        self.demo = [[demoTableViewController alloc] init];
        self.demo.view.backgroundColor = [UIColor whiteColor];
        self.demo.view.alpha = 0;
        [self.view addSubview:self.demo.view];


    self.zxcCell = [tableView cellForRowAtIndexPath:indexPath];
    _currentIndexPath = indexPath;
    _currentImage = [[UIImageView alloc] init];
    _currentImage.image = self.zxcCell.ZXCImage.image;
    _currentImage.userInteractionEnabled = YES;
    
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    _currentImage.frame = rect;
    _currentRect = rect;
    NSLog(@"%f,%f",rectInTableView.origin.y,rect.origin.y);
    [self.demo.view addSubview:_currentImage];

    UIButton *turn = [UIButton buttonWithType:UIButtonTypeCustom];
    turn.frame = CGRectMake(10, 10, 30, 30);
    [turn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    turn.alpha = 0;
    [turn addTarget:self action:NSSelectorFromString(@"remove") forControlEvents:UIControlEventTouchUpInside];
    [_currentImage addSubview:turn];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"      刘继丹，你不要以为你长得这么好看，这么有气质，这么沉鱼落雁国色天姿齿白唇红愁眉啼妆如出水芙蓉绰约多姿国色天香娇小玲珑绝代佳人眉目如画眉清目秀美如冠玉花容月貌靡颜腻理明眸皓齿千娇百媚倾城倾国螓首蛾眉如花似玉双瞳剪水亭亭玉立仙姿佚貌小家碧玉秀外惠中夭桃秾李仪态万方手如柔玉，就很了不起!";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:22];
    label.alpha = 0.3;
    label.frame = CGRectMake(0, 300, self.view.frame.size.width,0);
    [self.demo.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
       
        _currentImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
        

        self.demo.view.alpha = 1;
        self.zxcCell.alpha = 0;
        
        label.frame = CGRectMake(0, 300, self.view.frame.size.width, [self hightWithText:label.text]);
        label.alpha = 1;
        turn.alpha = 1;
    } completion:^(BOOL finished) {

    }];
}
- (void)remove{
   
    [UIView animateWithDuration:0.5 animations:^{
        
        for (UIView *view in self.demo.view.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UILabel")]) {
                
                view.frame = CGRectMake(0, 300, self.view.frame.size.width, 0);
                view.alpha = 0;
            
                _currentImage.frame = _currentRect;
                self.demo.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
                
               
            }else{
            
                view.subviews.firstObject.alpha = 0;
            }
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            
            
            self.zxcCell.alpha = 1;;

        } completion:^(BOOL finished) {

            [self.demo.view removeFromSuperview];
        }];

    }];
    
}

- (CGFloat)hightWithText:(NSString *)text{

    NSInteger width = self.view.frame.size.width;
    NSString *contentText = text;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22]};
    CGSize size = [contentText boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}

@end
