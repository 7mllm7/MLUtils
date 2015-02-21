//
//  ActivityIndicatorView.h
//
//  Created by ML on 10/6/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Fullscreen activity indicator view with title and subtitle.
 */
@interface ActivityIndicatorView : UIView


/**
 *  Adds itself to super view and starts animating with title and subtitle.
 *  This will start after current UI loop.
 *
 *  @param superView Container view.
 *  @param title     String with title to display.
 *  @param subtitle  String with subtitle to display or nil.
 */
-(void)startInView:(UIView *)superView title:(NSString *)title subtitle:(NSString *)subtitle;

/**
 *  Adds itself to super view and starts animating with title.
 *  This will start after current UI loop.
 *
 *  @param superView Container view.
 *  @param title     String with title to display.
 */
-(void)startInView:(UIView *)superView title:(NSString *)title;

/**
 *  Sets the subtitle to be presented.
 *  Useful for progress updates.
 *
 *  @param subtitle String of subtitle.
 */
-(void)setSubtitle:(NSString *)subtitle;

/**
 *  Stops animating and removes itself from super view.
 */
-(void)stopAndRemove;

@end
