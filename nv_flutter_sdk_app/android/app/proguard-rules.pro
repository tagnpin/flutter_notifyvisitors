# Preserve the app entry points and NotifyVisitors integration for release builds.
-keep class com.notifyvisitors.flutter.sdkapp.MainApplication { *; }
-keep class com.notifyvisitors.flutter.sdkapp.MainActivity { *; }
-keep class com.flutter.notifyvisitors.** { *; }
-keep class com.notifyvisitors.** { *; }

# Keep manifest-referenced Android components.
-keep class * extends android.app.Application { *; }
-keep class * extends android.app.Service { *; }
-keep class * extends android.content.BroadcastReceiver { *; }

# Preserve metadata frequently used by SDK callbacks/reflection.
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod
