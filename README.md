# Me

"Me" was designed for the iPhone 6 and 6s. It also supports the iPhone 5, 5s, 6 Plus, and 6s Plus.

## Developer

Ayush Saraswat (<saraswatayu@gmail.com>)

## Dependencies

- [Xcode](https://developer.apple.com/xcode/) is the preferred IDE. This project is written in Objective-C and Swift 2, which requires Xcode 7.
- [CocoaPods](https://cocoapods.org) manages Nuke's integration with this application. Install this via `gem install cocoapods`. It is recommended that you use a version of Ruby other than the one included with your system (if you're using a Mac). [`rbenv`](https://github.com/sstephenson/rbenv) is a popular Ruby version manager. You might need to precede this command (and the following one) with `sudo` if you decide to use the system-bundled version of Ruby.
- An [Apple ID](https://appleid.apple.com): you will need one of these in order to deploy to an iOS device. Xcode 7 will allow you to deploy to a device without an [Apple Developer](https://developer.apple.com) membership. 

## Installation

1. Clone the repository: `git clone https://github.com/saraswatayu/Me.git`.
2. Navigate to the repository: `cd Me`.
3. (Optional) Ensure the dependencies exist: `pod install`.
4. Open the `.xcworkspace` file.

## Usage Instructions

- Use the Up and Down arrows to navigate between the Home, About Me, and Projects sections. 
- Swipe to view more in the About Me and Projects sections.
- The first two projects are demoable! Simply tap the project information panel, and you'll be presented with a demo version of the application. You can exit the demo by pressing the "X" button on the top left of the screen.