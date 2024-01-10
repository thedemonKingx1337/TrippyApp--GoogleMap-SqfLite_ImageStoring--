Add your API_Key to location_helper.dart


Dependencies Required:

location: ^5.0.3
google_maps_flutter: ^2.5.0
image_picker:


1) Set the minSdkVersion in android/app/build.gradle:
android {
    defaultConfig {
        minSdkVersion 20
    }
}

2) Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>

3) To use location background mode on Android, you have to use the enableBackgroundMode({bool enable}) 
   API before accessing location in the background and adding necessary permissions.
   You should place the required permissions in your applications


    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
