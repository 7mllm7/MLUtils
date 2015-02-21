# MLUtils

A collection of util components for Objective-C that I use.

## Introduction
This is a repo where I deploy some useful components that I create for Objective-C.
Feel free to use or contribute.



## Usage
It's just a sample project that uses the classes in different ways.
Find Classes in MLSampleCode/Classes/.

## Classes
#### ActivityIndicatorView
Simple full screen activity indicator view that covers the whole screen with translucent black.
##### Features:
* Title label.
* Subtilte label - useful for updating loading percentages.
* Standard iOS indicator loading spinner.
* Reusable (init once, use as many times as you want).


#### AlertViewController
Wrapper around the normal UIAlertView (up to iOS 7) / UIAlertController (iOS 8 and up) that combines a result block upon dismissing the alert.
##### Features:
* Finds the top-most, presented view controller and use it to present alert.
* Reusable (init once, use as many times as you want).


#### AsyncLoadImageView
Subclass of UIImageView that enables loading of any image resource via NSURL and displaying it with a fade upon completion.
##### Features:
* Optional result block that's called upon success / failure.
* Automatically cancels loading upon deallocation - so basically just release it and it's gone completely.


#### VideoController
Video player that uses MPMoviePlayerController to play a given video inside any view, taking the whole frame.
##### Features:
* Handles loading of video.
* Fade in when starts playing.
* Aspect fill content mode.
* Stoppable.
* Pauses and resumes according to app state (background, foreground).



## Notes
* Class names are coherent with the newer Swift naming style (no two letters prefix).
* Tested with iOS 7.x and iOS 8.x, but should also work with iOS 6.x.
* ARC.
* Use with care :).


## License (MIT)
The MIT License (MIT)

Copyright (c) 2015 Moti Lavian

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.