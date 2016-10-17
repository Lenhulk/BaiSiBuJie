//
//  LTNavigationController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/17.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTNavigationController.h"

@interface LTNavigationController ()

@end

@implementation LTNavigationController

+ (void)load{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    //导航条字体
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    bar.titleTextAttributes = attr;
    
    //导航条背景
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
