# ViewControllerAdapter

A simple adapter to use native navigation between SwiftUI and UIKit

<img src="https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif](https://github.com/pavellunev99/ViewControllerAdapter/blob/pavellunev99-exampleGif/ViewControllerAdapter.gif" width="40"/>

### Installation:

It requires iOS 14

In Xcode go to `File -> Swift Packages -> Add Package Dependency` and paste in the repo's url: `https://github.com/pavellunev99/ViewControllerAdapter`

or just copy the code from the Source folder :)

### Usage

```swift
 NavigationView {
    VStack {
      NavigationLink("Push View Controller", destination: ViewControllerAdapter(SomeViewController()))
    }
    .navigationTitle("SwiftUI View")
 }
```
