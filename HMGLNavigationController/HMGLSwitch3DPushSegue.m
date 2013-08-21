//
//  HMGLSwitch3DPushSegue.m
//  HMGLTransitions+UINavigationControllerDemo
//
//  Created by Alexandre Santos on 21/08/13.
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

#import "HMGLSwitch3DPushSegue.h"
#import "HMGLNavigationController.h"

@implementation HMGLSwitch3DPushSegue

- (void)perform
{
    UIViewController *sourceVC = self.sourceViewController;
    HMGLNavigationController *nc = (HMGLNavigationController *)sourceVC.navigationController;
    if([nc isKindOfClass:[HMGLNavigationController class]])
    {
        nc.transitionStyle = HMGLNavigationControllerTransitionStyleSwitch3D;
    }
    else
    {
        NSLog(@"*** Warning: The Navigation controller is not a kind of class <HMGLNavigationController>");
    }
    
    [nc pushViewController:self.destinationViewController animated:YES];
}

@end
