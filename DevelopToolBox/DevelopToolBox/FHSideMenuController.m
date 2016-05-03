//
//  SideMenuViewController.m
//  DevelopToolBox
//
//  Created by MADAO on 16/4/27.
//  Copyright © 2016年 MADAO. All rights reserved.
//

#import "FHSideMenuController.h"
#import "FHTool.h"
#import "UIView+Frame.h"

typedef NS_ENUM(NSUInteger){
    FHSideMenuPanDirectionNone = 0,
    FHSideMenuPanDirectionLeft,
    FHSideMenuPanDirectionRight
}FHSideMenuPanDirection;

@interface FHSideMenuController ()

@property (nonatomic, assign) CGFloat leftViewHideWidth;

@property (nonatomic, assign) CGFloat springWidth;

@property (nonatomic, assign, getter=isShowMenu) BOOL showMenu;

@property (nonatomic, assign) FHSideMenuPanDirection swipeDirection;

@end


@implementation FHSideMenuController
- (instancetype)init
{
    if (self = [super init]) {
        //Default Arguments;
        _maxSideWidth = 250;
        _showMenu = NO;
        _swipeDirection = FHSideMenuPanDirectionNone;
        _animationDuration = 0.3f;
        _leftViewHideWidth = 20.f;
        _springWidth = 10.f;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUIGestureRecognizer];
    
}

- (void)setupUIGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    _leftViewController = leftViewController;
    [self addChildViewController:_leftViewController];
    [self.view addSubview:_leftViewController.view];
    CGPoint leftViewControllerOrigin = CGPointMake(-_leftViewHideWidth, 0);
    _leftViewController.view.frame = (CGRect){leftViewControllerOrigin,CGSizeMake(_maxSideWidth, self.view.height)};
    
}

- (void)setCenterViewController:(UIViewController *)centerViewController
{
    _centerViewController = centerViewController;
    [self addChildViewController:_centerViewController];
    [self.view addSubview:_centerViewController.view];
    _centerViewController.view.frame = self.view.frame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GestureMethod

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGes
{
    CGPoint transition = [panGes translationInView:self.view];
    if (transition.x < 0) {
        self.swipeDirection = FHSideMenuPanDirectionLeft;
    }
    else if (transition.x > 0) {
        self.swipeDirection = FHSideMenuPanDirectionRight;
    }
    switch (panGes.state) {
        case UIGestureRecognizerStateChanged:
            if ((!self.isShowMenu && _swipeDirection == FHSideMenuPanDirectionLeft && _centerViewController.view.x == 0) || (self.isShowMenu && _swipeDirection == FHSideMenuPanDirectionRight && _centerViewController.view.x == _maxSideWidth + _springWidth)){
                break;
            }
            //处理普通Transition
            [self handleNormalPanTransitionWithGesture:panGes];
            break;
        case UIGestureRecognizerStateEnded:case UIGestureRecognizerStateCancelled:
            //处理手势结束动画
            [self handleGestureEndedOrCanceled:panGes];
            break;
        default:
            break;
    }

}

- (void)handleNormalPanTransitionWithGesture:(UIPanGestureRecognizer *)panGesture{
    CGFloat maxLeftX = 0;
    CGPoint transition = [panGesture translationInView:self.view];
    CGFloat centerViewNewX = _centerViewController.view.x + transition.x;
    CGFloat leftViewNewX = _leftViewController.view.x + transition.x/_maxSideWidth * _leftViewHideWidth;
    if (leftViewNewX > maxLeftX){
        leftViewNewX = 0;
    }
    if (centerViewNewX >= _maxSideWidth + _springWidth) {
        self.showMenu = YES;
        return;
    }
    else if (centerViewNewX <= 0)
    {
        self.showMenu = NO;
        return;
    }
    else{
        self.centerViewController.view.x = centerViewNewX;
        self.leftViewController.view.x = leftViewNewX;
    }
    [panGesture setTranslation:CGPointZero inView:self.view];
}

- (void)handleGestureEndedOrCanceled:(UIPanGestureRecognizer *)panGesture{

    CGFloat currentCenterViewX = _centerViewController.view.x;
    if (_swipeDirection == FHSideMenuPanDirectionLeft) {
        if (currentCenterViewX <= (_maxSideWidth - 10)) {
            [self handlePopMenuAnimation:panGesture];
        }else{
            [self handlePushMenuAnimation:panGesture];
        }
    }
    else{
        if (currentCenterViewX >= ([FHTool getCurrentWindow].width - _maxSideWidth) * 1/4.f) {
            [self handlePushMenuAnimation:panGesture];
        }
        else
        {
            [self handlePopMenuAnimation:panGesture];
        }
    }
}

- (void)handlePopMenuAnimation:(UIPanGestureRecognizer *)panGesture{
    @WEAKSELF;
    [UIView animateWithDuration:_animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerViewController.view.x = 0;
        _leftViewController.view.x = - _leftViewHideWidth;
    } completion:^(BOOL finished) {
         weakSelf.showMenu = NO;
    }];
}

- (void)handlePushMenuAnimation:(UIPanGestureRecognizer *)panGesture{
    @WEAKSELF;
    [UIView animateWithDuration:_animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerViewController.view.x = _maxSideWidth;
        _leftViewController.view.x = 0;
    } completion:^(BOOL finished) {
       weakSelf.showMenu = YES;
    }];
    
    
}

@end
