//
//  VideoController.h
//
//  Created by ML on 20/12/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>

/**
 * Plays a video repeatedly in a full frame of any view, with not controls.
 * Pauses and resumes with fades according to app state.
 */
@interface VideoController : NSObject

/**
 *  Initiates a new VideoController with given video url.
 *
 *  @param url NSURL for video in supported format.
 *
 *  @return Init'd VideoController
 */
-(instancetype)initWithVideoUrl:(NSURL *)url;

/**
 *  Plays video in provided view.
 *
 *  @param superView UIView to play the video in.
 */
-(void)playInView:(UIView *)superView;


/**
 *  Stops the video and removes it from its superview.
 */
-(void)stopAndRemove;

@end
