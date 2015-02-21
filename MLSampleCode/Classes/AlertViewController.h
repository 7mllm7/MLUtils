//
//  AlertViewController.h
//
//  Created by ML on 10/6/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIAlertView.h>

@class AlertViewController;

/**
 *  Callback block to be called upon releasing the alert view with a button press.
 *
 *  @param buttonIndex NSInteger of button index thw was pressed.
 */
typedef void (^AlertViewControllerResultBlock)(NSInteger buttonIndex);

/**
 *  Presents an allert view from anywhere and handles callbacks with blocks.
 */
@interface AlertViewController : NSObject <UIAlertViewDelegate>

/**
 *  Shows alert with OK button, title and message, that disptaches completion block upon OK button press.
 *
 *  @param title      Title.
 *  @param message    Message
 *  @param Result     Result block to call upon OK button press or nil.
 */
- (void)showOKAlertWithTitle:(NSString *)title message:(NSString *)message result:(AlertViewControllerResultBlock)resultBlock;


@end
