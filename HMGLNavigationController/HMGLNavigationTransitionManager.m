//
//  HMGLNavigationTransitionManager.m
//  HMGLNavigationController
//
//  Created by Alexandre Santos on 20/08/13.
//  Copyright (c) 2013 iAOS Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "HMGLNavigationTransitionManager.h"

@interface HMGLTransitionManager ()

@property (nonatomic, retain) HMGLTransitionView *transitionView;
@property (nonatomic, retain) UIView *containerView;

@property (nonatomic, retain) UIViewController *oldController;
@property (nonatomic, retain) UIViewController *currentController;

- (void)switchViewControllers;

@end

@implementation HMGLNavigationTransitionManager

+ (instancetype) sharedTransitionManager
{
    static HMGLNavigationTransitionManager *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HMGLNavigationTransitionManager alloc] init];
    });
    
    return _instance;
}

- (id)init
{
    self = [super init];
    
    return self;
}

- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController
{
    // Disable user interaction on the navigation bar during the animation
    fromViewController.navigationController.navigationBar.userInteractionEnabled = NO;
	transitionType = (HMGLTransitionType)HMGLTransitionTypeControllerPush;
	self.oldController = fromViewController;
	self.currentController = viewController;
	[self switchViewControllers];
}

- (void)popViewController:(UIViewController *)viewController
{
    // Disable user interaction on the navigation bar during the animation
    viewController.navigationController.navigationBar.userInteractionEnabled = NO;
	transitionType = (HMGLTransitionType)HMGLTransitionTypeControllerPop;
	self.oldController = viewController;
    
	if ([self.oldController.navigationController.viewControllers count] > 1)
	{
		self.currentController = [self.oldController.navigationController.viewControllers objectAtIndex:0];
	}
    
	[self switchViewControllers];
}

- (void)transitionViewDidFinishTransition:(HMGLTransitionView*)_transitionView
{
	// finish transition
	[self.transitionView removeFromSuperview];
	[tempOverlayView removeFromSuperview];
	
	// view controllers
    if (transitionType == HMGLTransitionTypeControllerPresentation)
    {
		[self.oldController presentModalViewController:self.currentController animated:NO];
	}
	else if (transitionType == HMGLTransitionTypeControllerDismission)
    {
		[self.oldController dismissModalViewControllerAnimated:NO];
	}
    // Suppressing warnings about the enum comparison
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wtautological-compare"
	else if (transitionType == HMGLTransitionTypeControllerPush)
    {
		[self.oldController.navigationController pushViewController:self.currentController animated:NO];
        self.oldController.navigationController.navigationBar.userInteractionEnabled = YES;
	}
	else if (transitionType == HMGLTransitionTypeControllerPop)
    {
		[self.oldController.navigationController popToViewController:self.currentController animated:NO];
        self.oldController.navigationController.navigationBar.userInteractionEnabled = YES;
	}
    #pragma clang diagnostic pop
	
	// transition type
	transitionType = HMGLTransitionTypeNone;
}

@end
