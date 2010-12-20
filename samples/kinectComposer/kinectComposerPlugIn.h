//
//  kinectComposerPlugIn.h
//  kinectComposer
//
//  Created by Devin Chalmers on 12/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Quartz/Quartz.h>

#include "Kinect.h"

#include "cinder/gl/gl.h"
#include "cinder/gl/Texture.h"

@interface kinectComposerPlugIn : QCPlugIn
{
	cinder::Kinect kinect;
	
	cinder::gl::Texture depthTexture;
	cinder::gl::Texture videoTexture;
}

@property (assign) id<QCPlugInOutputImageProvider> outputDepthImage;
@property (assign) id<QCPlugInOutputImageProvider> outputVideoImage;

@end
