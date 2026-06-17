# iOS Integration

This document explains the iOS-specific integration steps required for the Flutter plugin.

Official Documentation:  
https://www.nvecta.com/docs/flutter-ios-integration

---

<br>

# 1. Cocoapods Install

Once you have completed the Plugin Installation step, inside the terminal, go to the ios folder located within your Flutter Project root folder using cd command, then run this command from terminal

```ruby
    cd ios && pod install && cd ..
```

For example, if your Project is saved on Desktop and its root folder name is my_flutter_app, then go to your project's ios folder by using the following command

```ruby
    $ cd ~/Desktop/my_flutter_app/ios && pod install && cd ..
```

---

# 2. Configure info.plist

To configure your info.plist, go to ios folder inside your Flutter Project root folder and open your iOS project into Xcode by double click on `.xcworkspace` file and once your Flutter iOS project is open in Xcode, go to `info.plist`, open `info.plist` file as source code (right-click on info.plist and click on Open as >> Source code) and add the following code in it.

```xml
 <key>CFBundleURLTypes</key>
  <array>
        <dict>
      <key>CFBundleURLName</key>
     	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
             	<key>CFBundleURLSchemes</key>
             	<array>
 	<string>"yourURLscheme comes here"</string>
         </array>
     	</dict>
          </array>
<key>nvBrandID</key>
         <integer>Your BRANDID comes here</integer>
              <key>nvSecretKey</key>
	        <string>Your SECRET KEY comes here</string>
             <key>nvPushCategory</key>
                       <string>nvpush</string>
             <key>nvViewAutoRedirection</key>
                       <true/>       <!--OR--> <!-- <false/>-->
```

`OR`

You can simply open the `info.plist` file as `Property List` and add the keys which work the same as above.

## 1.

Add a new row again and set up a URL Types item by means of adding a new item. Expand the URL Types key, then expand Item 0, and add a new item, URL Identifier . Fill in 'appScheme' for Item 0 of URL schemes and your company identifier for the URL Identifier. Once done, your file should resemble the image provided below.
