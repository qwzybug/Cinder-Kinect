//
//  CGLTextureImageProvider.h
//  kinectComposer
//
//  Created by Devin Chalmers on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Quartz/Quartz.h>

#include "Kinect.h"

#include "cinder/gl/gl.h"
#include "cinder/gl/Texture.h"

@interface CGLTextureImageProvider : NSObject <QCPlugInOutputImageProvider>
{
	cinder::gl::Texture texture;
	CGColorSpaceRef colorSpace;
}

@property (nonatomic, assign) cinder::gl::Texture texture;

- (id)initWithTexture:(cinder::gl::Texture)inTexture;

@end
