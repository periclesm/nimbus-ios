# Nimbus for iOS

Nimbus is a reference application, a compendium of several techniques and architectural implementations in a test use-case on the iOS platform.

Simply put, the app:

* Fetches data from the internet through a json REST API,
* Parses the data into objects to be used in the app,
* Stores the data in a caching database (Realm DB),
* Displays the cached data in UI.

This reference app is making use of:

* Initially started as an Obj-C project, now it has moved to Swift (there are a few Obj-C grains here and there),
* Uses Cocoa Pods for third-party SDKs and APIs (do a `pod install` after cloning -- not all code is commited due to GitHub space limits),
* Implements Realm DB to store data. Originally Core Data were used but Realm came as a replacement due to it's interoperability (see Android) and ease of use,
* A custom Network Wrapper updated for iOS 15+ with async/await (though it's not complete to handle all network connections and calls)
* Loose MVVM architecture (Don't expect to see codexes, canons and gospels here. I use what I see fit on a simple app such as this)
* UIKit. Check the SwiftUI branch for... well, SwiftUI (still under development)

