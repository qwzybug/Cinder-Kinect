//
//  kinectComposerPlugIn.m
//  kinectComposer
//
//  Created by Devin Chalmers on 12/19/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "kinectComposerPlugIn.h"

#import "CGLTextureImageProvider.h"

#define	kQCPlugIn_Name				@"Kinect"
#define	kQCPlugIn_Description		@"Provides depth and video data from an attached Kinect"

@implementation kinectComposerPlugIn

@dynamic outputDepthImage;
@dynamic outputVideoImage;

+ (NSDictionary *)attributes;
{
	return [NSDictionary dictionaryWithObjectsAndKeys:kQCPlugIn_Name, QCPlugInAttributeNameKey, kQCPlugIn_Description, QCPlugInAttributeDescriptionKey, nil];
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key;
{
	static NSDictionary *sAttributes = nil;
	if (!sAttributes) {
		sAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
						[NSDictionary dictionaryWithObjectsAndKeys:
							@"Depth Image", QCPortAttributeNameKey,
							nil],
						@"outputDepthImage",
						[NSDictionary dictionaryWithObjectsAndKeys:
							@"Video Image", QCPortAttributeNameKey,
							nil],
						@"outputVideoImage",
						nil];
	}
	return [sAttributes objectForKey:key];
}

+ (QCPlugInExecutionMode)executionMode;
{
	return kQCPlugInExecutionModeProvider;
}

+ (QCPlugInTimeMode) timeMode;
{
	return kQCPlugInTimeModeIdle;
}

- (void) finalize;
{
	/*
	Release any non garbage collected resources created in -init.
	*/
	
	[super finalize];
}

- (void) dealloc;
{
	/*
	Release any resources created in -init.
	*/
	
	[super dealloc];
}

@end

@implementation kinectComposerPlugIn (Execution)

- (BOOL) startExecution:(id<QCPlugInContext>)context;
{
	try
	{
		kinect = cinder::Kinect( cinder::Kinect::Device() );
	}
	catch (cinder::Kinect::ExcFailedOpenDevice e)
	{
		NSLog(@"Can't connect to Kinect!");
	}
	
	return YES;
}

- (void) enableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
	*/
}

- (BOOL) execute:(id<QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	CGLContextObj ctx = CGLGetCurrentContext();
	
	CGLContextObj cgl_ctx = [context CGLContextObj];
	CGLSetCurrentContext(cgl_ctx);
	
	if( kinect.checkNewVideoFrame() )
		videoTexture = kinect.getVideoImage();
	
	if ( kinect.checkNewDepthFrame() )
		depthTexture = kinect.getDepthImage();
	
	if (videoTexture)
		self.outputVideoImage = [[[CGLTextureImageProvider alloc] initWithTexture:videoTexture] autorelease];
	
	if (depthTexture)
		self.outputDepthImage = [[[CGLTextureImageProvider alloc] initWithTexture:depthTexture] autorelease];
	
	CGLSetCurrentContext(ctx);
	
	return YES;
}


// should disconnect from kinect, but I didn't see it in the APIs

- (void) disableExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
	*/
}

- (void) stopExecution:(id<QCPlugInContext>)context
{
	/*
	Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
	*/
}

@end
