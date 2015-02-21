//
//  VideoController.m
//
//  Created by ML on 20/12/14.
//  Copyright (c) 2014 YawningMonkey. All rights reserved.
//

#import "VideoController.h"
#import <MediaPlayer/MPMoviePlayerController.h>

/**
 *  Internal load state of video.
 */
typedef NS_ENUM(NSUInteger, VideoControllerLoadState) {
    /**
     *  Video is not loaded.
     */
    VideoControllerLoadStateNotLoaded,
    /**
     *  Video is loaded.
     */
    VideoControllerLoadStateLoaded
};

@interface VideoController ()

/**
 *  Movie player.
 */
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

/**
 *  Current load state.
 */
@property (nonatomic, assign, readonly) VideoControllerLoadState loadState;

@end

@implementation VideoController

-(instancetype)initWithVideoUrl:(NSURL *)url
{
    self = [super init];
    
    if (self)
    {
        // init and set properties for movie player.
        _moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
        [_moviePlayerController setControlStyle:MPMovieControlStyleNone];
        _moviePlayerController.repeatMode = MPMovieRepeatModeOne; // for looping
        _moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        [_moviePlayerController prepareToPlay];
        
        // register to app state changes
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(play) name:UIApplicationDidBecomeActiveNotification object:nil];
        
    }
    
    return self;
}

/**
 *  Pauses the video.
 */
-(void)pause
{
    [_moviePlayerController pause];
}

/**
 *  Starts playing the video when it's loaded.
 */
-(void)play
{
    if (self.loadState == VideoControllerLoadStateNotLoaded)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeLoadState) name:MPMoviePlayerLoadStateDidChangeNotification object:_moviePlayerController];
    }
    else
    {
        [_moviePlayerController play];
    }
}

/**
 *  Callback for load state changes.
 */
-(void)didChangeLoadState
{
    if (_moviePlayerController.loadState == MPMovieLoadStatePlayable)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        // we're starting from nothing, so fade it
        [self fadeInToPlay];
    }
}

/**
 *  Commits a fade in animation while playing the video.
 */
-(void)fadeInToPlay
{
    [_moviePlayerController.view setAlpha:0.0f];
    [_moviePlayerController play];
    [UIView animateWithDuration:2.0f animations:^{
        
        [_moviePlayerController.view setAlpha:1.0f];
        
    } completion:NULL];
}


-(void)playInView:(UIView *)superView
{
    [self removeFromSuperView];
    [_moviePlayerController.view setFrame: superView.frame];
    [superView addSubview:_moviePlayerController.view];
    [self play];
}

-(void)removeFromSuperView
{
    [_moviePlayerController.view removeFromSuperview];
}

-(void)stopAndRemove
{
    [_moviePlayerController stop];
    [self removeFromSuperView];
}

/**
 *  Getter for current load state according to internal movie player.
 *
 *  @return VideoControllerLoadState of current state.
 */
-(VideoControllerLoadState)loadState
{
    VideoControllerLoadState returnState;
    switch (_moviePlayerController.loadState) {
        case MPMovieLoadStateUnknown:
            returnState = VideoControllerLoadStateNotLoaded;
            break;
        default:
            returnState = VideoControllerLoadStateLoaded;
            break;
    }
    
    return returnState;
}

-(void)dealloc
{
    // remove observing of app state
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

@end
