//
//  LTTabBarController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/15.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTabBarController.h"
#import "LTEssenceViewController.h"
#import "LTMeViewController.h"
#import "LTNewViewController.h"
#import "LTPublishViewController.h"
#import "LTFriendTrendViewController.h"
#import "LTNavigationController.h"

#import "UIImage+LTRender.h"
#import "UITabBarItem+LTFont.h"

@interface LTTabBarController () <UITabBarControllerDelegate>
/**发布按钮*/
@property (nonatomic, weak) UIButton *plusButton;
/**发布界面控制器*/
@property (nonatomic, strong) LTPublishViewController *publicVc;
/**记录当前选中的控制器*/
@property (nonatomic, strong) UIViewController *selControlVc;
@end

@implementation LTTabBarController

#pragma mark - 程序进程

+ (void)load{
    //如果通过appearance设置属性，必须要在控件显示之前设置，可放在load方法中
    
    //获取UITabBarItem的外观
    UITabBarItem *item = [UITabBarItem appearance];
//    NSLog(@"%@", [item class]);
//    [item setupTabBarButtonFont:12];//appearance不可直接作为UITabBarItem，调用方法导致程序崩溃，因为item真实类型是UIBarItemAppearance
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupPlusBtn];
    
    self.tabBar.tintColor = [UIColor darkGrayColor];
    
    [self addAllChildViewController];
    
    //让自己成为自己代理(为了获取重复点击TabBar事件)
    self.delegate = self;
    
    _selControlVc = self.childViewControllers[0];
}

#pragma mark - SETUP操作

- (void)setupPlusBtn{
    
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [plusBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [plusBtn addTarget:self action:@selector(push2PublishView) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn sizeToFit];     //重要不能忘记，且应该放在坐标位置设置语句之前
    
    self.plusButton = plusBtn;
    self.plusButton.center = CGPointMake(self.tabBar.bounds.size.width * 0.5, self.tabBar.bounds.size.height * 0.5);
    
    [self.tabBar addSubview:plusBtn];
}

///创建发布界面
- (void)push2PublishView{
    
    LTPublishViewController *publishVC = [[LTPublishViewController alloc] init];
    self.publicVc = publishVC;
    publishVC.closeTask = ^{
        self.publicVc = nil;
    };
    [[UIApplication sharedApplication].keyWindow addSubview:publishVC.view];
}

- (void)addAllChildViewController{
    
    //精华
    LTEssenceViewController *essenceVc = [[LTEssenceViewController alloc] init];
    [self setNavVc:essenceVc image:[UIImage imageNamed:@"tabBar_essence_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_essence_click_icon"] title:@"精华"];
    
    //新帖
    LTNewViewController *newVc = [[LTNewViewController alloc] init];
    [self setNavVc:newVc image:[UIImage imageNamed:@"tabBar_new_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_new_click_icon"] title:@"新帖"];
    
    //发布
//    LTPublishViewController *publishVc = [[LTPublishViewController alloc] init];
//    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
//    publishVc.tabBarItem.selectedImage = [UIImage imageNamedWithOriginalMode:@"tabBar_publish_click_icon"];
//    publishVc.tabBarItem.enabled = NO;  //设置TarBar按钮不接收点击事件
//    [self addChildViewController:publishVc];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.tabBarItem.enabled = NO;
    [self addChildViewController:vc];
    
    //关注
    LTFriendTrendViewController *friendTVc = [[LTFriendTrendViewController alloc]init];
    [self setNavVc:friendTVc image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LTMeViewController" bundle:nil];
    LTMeViewController *meVc = [storyboard instantiateInitialViewController];
    [self setNavVc:meVc image:[UIImage imageNamed:@"tabBar_me_icon"] selectedImage:[UIImage imageNamedWithOriginalMode:@"tabBar_me_click_icon"] title:@"我"];
}


- (void)setNavVc:(UIViewController *)ChildVc image:(UIImage *)image selectedImage:(UIImage *)selImage title:(NSString *)title{
    
    //设置子导航控制器
    LTNavigationController *nav = [[LTNavigationController alloc] initWithRootViewController:ChildVc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selImage;
    
    //1设置TabBar按钮的文字大小属性
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20]} forState:UIControlStateNormal];
    //2抽成分类通过导入头文件UITabBarItem+LTFont设置
    //3每次创建都要设置  可否只设置一次？（考虑使用appearance统一设置）
    //    [nav.tabBarItem setupTabBarButtonFont:12];
    
    //设置按钮被选中时不会被渲染成默认的蓝色(原始图片样式)
//    nav.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self addChildViewController:nav];
}


#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    if (_selControlVc == viewController) {
        LTLog(@"重复点击-%@", viewController);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"repeatClickTab" object:nil];
    }
    _selControlVc = viewController;
}


@end
