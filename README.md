# UIKit-Margins

`UIView`
- `safeAreaLayoutGuide`
- `layoutMarginsGuide`
- `readableContentGuide`

`UIScrollView`
- `contentLayoutGuide`
- `frameLayoutGuide`

## Limitations

- `UILabel` not support layout margins.
- `UIStackView` not support follow readable width. Use `isLayoutMarginsRelativeArrangement = true` for activate layout margins.

## Apple Documentation

- [Adaptivity and Layout](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)
- [View Layout](https://developer.apple.com/documentation/uikit/view_layout)
- [Positioning Content Within Layout Margins](https://developer.apple.com/documentation/uikit/uiview/positioning_content_within_layout_margins)
- [Positioning Content Relative to the Safe Area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area)
