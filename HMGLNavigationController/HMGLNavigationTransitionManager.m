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
	transitionType = (HMGLTransitionType)HMGLTransitionTypeControllerPush;
	self.oldController = fromViewController;
	self.currentController = viewController;
	[self switchViewControllers];
}

- (void)popViewController:(UIViewController *)viewController
{
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
	[transitionView removeFromSuperview];
	[tempOverlayView removeFromSuperview];
	
	// view controllers
    if (transitionType == HMGLTransitionTypeControllerPresentation)
    {
		[oldController presentModalViewController:currentController animated:NO];
	}
	else if (transitionType == HMGLTransitionTypeControllerDismission)
    {
		[oldController dismissModalViewControllerAnimated:NO];
	}
	else if (transitionType == HMGLTransitionTypeControllerPush)
    {
		[oldController.navigationController pushViewController:currentController animated:NO];
	}
	else if (transitionType == HMGLTransitionTypeControllerPop)
    {
		[oldController.navigationController popToViewController:currentController animated:NO];
	}
	
	// transition type
	transitionType = HMGLTransitionTypeNone;
}

@end
