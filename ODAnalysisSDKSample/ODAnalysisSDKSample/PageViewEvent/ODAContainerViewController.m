//
//  ODAContainerViewController.m
//  ODAnalysisSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODAContainerViewController.h"
#import "ODAPageViewController.h"

@interface ODAContainerViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>{
    NSMutableArray *vcs;
    NSInteger currentIndex;
    UIViewController *pendvc;
}

@property(nonatomic,strong)  UIPageViewController *pageVc;
@end

@implementation ODAContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PageA";
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
    UIPageViewController *pageVc = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll    navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];  //pageCurl卷页效果
    
    self.pageVc = pageVc;
    NSMutableArray *tempVcs = [NSMutableArray array];
    for (NSInteger i=0; i<2; i++) {
        ODAPageViewController  *subVc = [ODAPageViewController new];
        subVc.img = [UIImage imageNamed:[NSString stringWithFormat:@"page%ld",(long)i]];
        subVc.pageIndex = i;
        if (i == 0) {
            subVc.pageId = @"PageA";
        }else{
            subVc.pageId = @"PageB";
        }
        subVc.view.frame=self.view.bounds;
        
        [tempVcs addObject:subVc];
    }
    vcs = tempVcs;
    pageVc.delegate = self;
    pageVc.dataSource = self;
    
    [pageVc setViewControllers:@[tempVcs.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    pageVc.view.frame = self.view.bounds;
    [self addChildViewController:pageVc];
    [self.view addSubview:pageVc.view];
    [pageVc didMoveToParentViewController:self];
}


#pragma mark UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger after = currentIndex + 1;
    if (after >= vcs.count) {
        return nil;
    }
    return vcs[after];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger before = currentIndex - 1;
    if (before < 0) {
        return nil;
    }
    return vcs[before];
}

#pragma mark UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    pendvc = pendingViewControllers.firstObject;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    [vcs enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == self->pendvc) {  //判断视图控制器是否与正在转换的视图控制器为同一个
            self->currentIndex = idx;
            if (idx == 0 ) {
                self.title = @"PageA";
            }else{
                self.title = @"PageB";
            }
            *stop = YES;
        }
    }];
}
/***以下两个delegate方式在卷页过渡效果时设置UIPageViewControllerTransitionStylePageCurl***/
//返回视图控制器支持的所有方向
- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationMaskLandscape;
}

//返回视图控制器的首选方向
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    return UIInterfaceOrientationLandscapeRight;
}


@end
