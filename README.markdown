Use the Kinect in your Quartz Composer compositions as a patch.

Some demo videos:

* [Mesh](http://www.youtube.com/watch?v=_mHSUizz5W8&list=UURDfNLPHl1aj_XoTWsJ9IMQ&index=3&feature=plcp)
* [Metal creatures](http://www.youtube.com/watch?v=DFaZbTI1SsA&list=UURDfNLPHl1aj_XoTWsJ9IMQ&index=4&feature=plcp)
* [Contour lines](http://www.youtube.com/watch?v=4ZliMAkXQcQ&list=UURDfNLPHl1aj_XoTWsJ9IMQ&index=5&feature=plcp)

h2. Installation

1. Download the [kinectComposer.plugin]() from the Files section in Github.

2. Make sure you put Quartz Composer into 32-bit mode: Get Info on Quartz Composer.app in the Finder, and tick "Open in 32-bit mode". (Super sorry about that.)

3. Drag out a Kinect patch from your Patch Library and go to town.

h2. PLEASE NOTE

Everything is broken. Sorry!

h2. Building

1. Get Cinder: https://github.com/cinder/Cinder

2. Clone this repository into Cinder/samples

```
cd Cinder/samples
git clone git@github.com:qwzybug/Cinder-Kinect.git
```

3. Install boost:

```
brew install boost
```

4. Open `Cinder/xcode/Cinder.xcodeproj`

5. Pick "cinder > My Mac 32 bit" from the Target menu.

6. Build Cinder.

7. Open `Cinder/samples/Cinder-Kinect/samples/kinectComposer/kinectComposer.xcodeproj`

8. Pick the "Build & Copy > My Mac 32-bit" target and build.

This will build and install the kinectComposer.plugin to `~/Library/Graphics/Quartz Composer Plug-Ins`.
