# Nimbus app for iOS

Nimbus is a reference application, a compendium of several techniques and architectural implementations on a test use-case on the iOS platform.

Simply put, the app:

* Fetches data from the internet through an API (json),
* Parses the data into objects to be used in the app,
* Stores the data in a Realm DB,
* Queries and retrieves data to display in the User Interface.



This reference app is making use of:

* Initially started as an Obj-C project, now it has moved to Swift (there are a few Obj-C grains here and there),
* Uses Cocoa Pods for necessary third-party SDKs and APIs (do a `pod install` after cloning -- code is not commited due to GitHub space limits),
* Implements Realm DB to store data. Originally Core Data were used but Realm came as a replacement due to it's interoperability (see Android) and ease of use,
* A custom Network Wrapper (though it's not complete to handle all network connections and calls)
* Loose MVC architecture with a slight MVVM application (Don't expect to see codexes, canons and gospels here. I use what I see fit on a per-case basis)
* Storyboard and Constaint Layouts (yes, these still..)



​	One more purpose for this app is to try and gap the chasm between iOS and Android native development by trying to find common ground to step upon. The Android project is **[Nimbus for Android](https://bitbucket.org/periclesm/nimbus-android/src)**. For that reason, several concepts that are popularily implemented in iOS might seem different as they come from the Android world (and vice versa)



In-code documentation is in progress...