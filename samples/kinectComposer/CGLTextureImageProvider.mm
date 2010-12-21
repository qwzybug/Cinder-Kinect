//
//  CGLTextureImageProvider.m
//  kinectComposer
//
//  Created by Devin Chalmers on 12/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CGLTextureImageProvider.h"

#import <Accelerate/Accelerate.h>

#include <cinder/Surface.h>
#include <cinder/ImageIo.h>

@implementation CGLTextureImageProvider

@synthesize texture;

- (id)initWithTexture:(cinder::gl::Texture)inTexture;
{
	if (!(self = [super init]))
		return nil;
	
	texture = inTexture;
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	return self;
}

- (void)dealloc;
{
	// why doesn't this do anythin?
	// texture.reset()
	// but it works in the render call???
	CGColorSpaceRelease(colorSpace);
	
	[super dealloc];
}

- (NSRect) imageBounds;
{
	if (texture) {
		return NSMakeRect(0, 0, texture.getWidth(), texture.getHeight());
	}
	else {
		return NSMakeRect(0, 0, 640, 480);
	}
}

- (BOOL) renderWithCGLContext:(CGLContextObj)cgl_ctx forBounds:(NSRect)bounds;
{
	CGLContextObj ctx = CGLGetCurrentContext();
	
	CGLSetCurrentContext(cgl_ctx);
	
	cinder::gl::clear( cinder::Color( 0, 0, 0 ) );
	cinder::gl::setMatricesWindow( [self imageBounds].size.width, [self imageBounds].size.height );
	
	if (texture)
		cinder::gl::draw( texture );
	
	CGLSetCurrentContext(ctx);
	
	if (texture)
		texture.reset();
	
	return YES;
}

- (CGColorSpaceRef) imageColorSpace;
{
	return colorSpace;
}

- (BOOL) canRenderWithCGLContext:(CGLContextObj)cgl_ctx;
{
	return YES;
}

- (BOOL) renderToBuffer:(void*)baseAddress withBytesPerRow:(NSUInteger)rowBytes pixelFormat:(NSString*)format forBounds:(NSRect)bounds;
{
    return NO;
}

@end
