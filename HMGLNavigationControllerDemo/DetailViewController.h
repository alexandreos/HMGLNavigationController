//
//  DetailViewController.h
//  HMGLTransitions+UINavigationControllerDemo
//
//  Created by Alexandre Santos on 21/08/13.
//  Copyright (c) 2013 iAOS Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)btPopToRootVCTouched:(id)sender;

@end
