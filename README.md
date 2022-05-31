<p>
<a href="https://developer.apple.com/ios" target="_blank"><img src="https://img.shields.io/badge/Platform-iOS_15+-blue.svg" alt="Platform: iOS 15.0+" /></a>
<a href="https://developer.apple.com/swift" target="_blank"><img src="https://img.shields.io/badge/Language-Swift_5-orange.svg" alt="Language: Swift 5" /></a>
<a href="https://github.com/hugo-pivaral/UITabControl/blob/main/LICENSE" target="_blank"><img src="https://img.shields.io/badge/License-MIT-blueviolet.svg" alt="License: MIT" /></a>
</p>

![UITabControl-Expo](https://user-images.githubusercontent.com/18062144/171046764-24088d4c-30ff-4d95-8d2e-2b166748e6a8.png)

## Requirements
iOS 15.0 and higher

## Installation

<a href="https://swift.org/package-manager/" target="_blank">Swift Package Manager</a>:

```swift
dependencies: [
  .package(url: "https://github.com/hugo-pivaral/UITabControl.git", .exact("1.0.0")),
],
```
After installing the SPM into your project import UITabControl with

```swift
import UITabControl
```

## Usage

If you're not using storyboards, jut use the `init(tabs: [String])` method to create a new `UITabControl` instance, set the views frame and add it to your superview. 
Please note that `UITabControl` has an intrinsic content size value of 48, so make sure to set the height value or constraint to 48.

```swift
let tabControl = UITabControl(tabs: ["All", "Business", "Technology", "Science", "Politics", "Health"])
tabControl.frame = CGRect(x: x, y: y, width: width, height: 48)

self.view.addSubview(tabControl)
```

If you are using the interface builder in your project, add a UIView to your view controller scene or xib file, and make it inherit from `UITabControl`. *Again, remember to set a height constraint with a constant value of 48.*

![example](https://user-images.githubusercontent.com/18062144/171078810-88d008e7-7a16-4208-87e7-b8b4c8f60614.png)

In your swift file, configure your `@IBOutlet` like this.

```swift
@IBOutlet weak var tabControl: UITabControl! {
    didSet {
        tabControl.setTabs(["All", "Business", "Technology", "Science", "Politics", "Health"])
    }
}
```

`UITabControl` inherits from `UIControl`, so to handle touch events you can use the `addTarget(_:action:for:)` method, and set the value for `controlEvents` to `.valueChanged`.

```swift
tabControl.addTarget(self, action: #selector(handleEvents(_:)), for: .valueChanged)
```

Finally, add your `@objc` method.

```swift
@objc func handleEvents(_ sender: UITabControl) {
    let selectedIndex = sender.selectedTabIndex
    // Do something...
}
```
## Customization

To customize `UITabControl`, create a new instance of `UITabControl.Appearance` with your custom values, and assign it in the `init(tabs: [String], appearance: Appearance)` method, or using the `.setAppearance(_)` method.

```swift
let appearance = UITabControl.Appearance(style: UITabControl.Style,
                                         textColor: UIColor,
                                         contentInset: CGFloat,
                                         separatorColor: UIColor,
                                         separatorEnabled: Bool,
                                         selectedTabTextColor: UIColor,
                                         selectedTabShadowEnabled: Bool,
                                         selectedTabBackgroundColor: UIColor)
tabControl.setAppearance(appearance)
```

## Author

[Hugo Pivaral](https://hugop.dev)

## License

UITabControl is under the MIT license. See [LICENSE](./LICENSE) for details.
