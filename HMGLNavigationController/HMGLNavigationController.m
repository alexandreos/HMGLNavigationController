//
//  HMGLNavigationController.m
//  HMGLNavigationController
//
//  Created by Alexandre Santos on 15/02/13.
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


#import "HMGLNavigationController.h"
#import <QuartzCore/QuartzCore.h>

#import "HMGLNavigationTransitionManager.h"
#import "DoorsTransition.h"
#import "Switch3DTransition.h"
#import "ClothTransition.h"
#import "FlipTransition.h"
#import "RotateTransition.h"

@interface HMGLNavigationController ()

@end

@implementation HMGLNavigationController

- (HMGLTransition *) pushTransition
{
    HMGLTransition *transition = nil;
    
    switch (self.transitionStyle)
    {
        case HMGLNavigationControllerTransitionStyleSwitch3D:
        {
            Switch3DTransition *t = [[Switch3DTransition alloc] init];
            t.transitionType = Switch3DTransitionLeft;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleDoors:
        {
            DoorsTransition *t = [[DoorsTransition alloc] init];
            t.transitionType = DoorsTransitionTypeOpen;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleFlip:
        {
            FlipTransition *t = [[FlipTransition alloc] init];
            t.transitionType = FlipTransitionLeft;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleRotate:
        {
            RotateTransition *t = [[RotateTransition alloc] init];
            
            transition = t;
        }
        break;
    }
    
    return transition;
}

- (HMGLTransition *) popTransition
{
    HMGLTransition *transition = nil;
    
    switch (self.transitionStyle)
    {
        case HMGLNavigationControllerTransitionStyleSwitch3D:
        {
            Switch3DTransition *t = [[Switch3DTransition alloc] init];
            t.transitionType = Switch3DTransitionRight;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleDoors:
        {
            DoorsTransition *t = [[DoorsTransition alloc] init];
            t.transitionType = DoorsTransitionTypeOpen;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleFlip:
        {
            FlipTransition *t = [[FlipTransition alloc] init];
            t.transitionType = FlipTransitionRight;
            
            transition = t;
        }
        break;
            
        case HMGLNavigationControllerTransitionStyleRotate:
        {
            RotateTransition *t = [[RotateTransition alloc] init];
            
            transition = t;
        }
        break;
    }
    
    return transition;
}

#pragma mark - Overriding

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(animated)
    {
        HMGLTransition *transition = [self pushTransition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] setTransition:transition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] pushViewController:viewController fromViewController:self.topViewController];
    }
    else
        [super pushViewController:viewController animated:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(animated)
    {
        HMGLTransition *transition = [self popTransition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] setTransition:transition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] popViewController:self.topViewController];
        return [self.viewControllers objectAtIndex:0];
    }
    else
        return [super popViewControllerAnimated:NO];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(animated)
    {
        HMGLTransition *transition = [self popTransition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] setTransition:transition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] popViewController:viewController];
        return nil;
    }
    else
        return [super popToViewController:viewController animated:NO];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if(animated && [self.viewControllers count] > 1)
    {
        HMGLTransition *transition = nil;
        if(self.customTransitionToRoot)
            transition = self.customTransitionToRoot;
        else
            transition = [[ClothTransition alloc] init];
        
        [[HMGLNavigationTransitionManager sharedTransitionManager] setTransition:transition];
        [[HMGLNavigationTransitionManager sharedTransitionManager] popViewController:[self.viewControllers lastObject]];
        return nil;
    }
    else
        return [super popToRootViewControllerAnimated:NO];
}
@end
