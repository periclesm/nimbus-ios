# Nimbus for iOS

Nimbus is a reference application, a compendium of several techniques and architectural implementations on a test use-case on the iOS platform.

Simply put, the app:

* Fetches data from the internet through an API (json),
* Parses the data into objects to be used in the app,
* Stores the data in a Realm DB,
* Queries and retrieves data to display in the User Interface.



This reference app is making use of:

* Initially started as an Obj-C project, now it has moved to Swift (there are a few Obj-C grains here and there),
* Uses Cocoa Pods for necessary third-party SDKs and APIs (do a `pod install` after cloning -- not all code is commited due to GitHub space limits),
* Implements Realm DB to store data. Originally Core Data were used but Realm came as a replacement due to it's interoperability (see Android) and ease of use,
* A custom Network Wrapper (though it's not complete to handle all network connections and calls)
* Loose MVVM architecture (Don't expect to see codexes, canons and gospels here. I use what I see fit on a simple app such as this)
* Storyboard and Constaint Layouts (yes, these still..)



One additional purpose for this app is to try and find common ground between iOS and Android native development. The Android equivalent project is **[Nimbus for Android](https://github.com/periclesm/nimbus-android)**. 

For that reason, several programming concepts and methodology that are commonly practiced in iOS might appear differently in this project since they might originate from the Android world (and vice versa) or are altered to serve the platform convergence.

In-code documentation is in progress...



## ToDo:

* Implement GraphQL in app