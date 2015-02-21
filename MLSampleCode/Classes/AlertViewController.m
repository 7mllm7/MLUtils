//
//  AlertViewController.m
//
//  Created by ML on 10/6/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import "AlertViewController.h"
#import <UIKit/UIAlertController.h>
#import <UIKit/UIWindow.h>

static NSString *const kOkButtonTitle = @"Awesome!";

@interface AlertViewController ()

/**
 *  Internal alert view (before iOS 8).
 */
@property (nonatomic, strong) UIAlertView *alertView;

/**
 *  Internal alert  controller (iOS 8 and up).
 */
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, copy) AlertViewControllerResultBlock resultBlock;

@end

@implementation AlertViewController



- (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message result:(AlertViewControllerResultBlock)resultBlock
{
     _resultBlock = resultBlock;
    
    // if we have UIAlertController (iOS 8 and up)
    if ([UIAlertController class])
    {
        _alertController = [UIAlertController
                            alertControllerWithTitle:title
                            message:message
                            preferredStyle:UIAlertControllerStyleAlert];
        
        // ref weakly to self to avoid loop retain inside block
        __weak AlertViewController *weakSelf = self;
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:kOkButtonTitle
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       if (weakSelf.resultBlock)
                                       {
                                           weakSelf.resultBlock(0); // button index 0 (only)
                                           weakSelf.resultBlock = nil;
                                       }
                                   }];
        
        [_alertController addAction:okAction];
        
        // find presented top vc (otherwise alert ctrl will complain)
        UIViewController *topViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        while (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        }
        
        [topViewController presentViewController:_alertController animated:YES completion:nil];
    }
    else
    {
        _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:kOkButtonTitle, nil];
        _alertView.delegate = self;
        [_alertView show];
    }
}

/**
 *  Called when alert view button is pressed.
 *
 *  @param alertView
 *  @param buttonIndex
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // call result block is it exists.
    if (_resultBlock)
    {
        _resultBlock(buttonIndex);
        _resultBlock = nil;
    }
}

@end
