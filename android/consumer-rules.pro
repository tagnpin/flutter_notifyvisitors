# Keep the Flutter bridge and NotifyVisitors SDK classes that may be referenced
# by manifest entries, callbacks, or reflection in release builds.
-keep class com.flutter.notifyvisitors.** { *; }
-keep class com.notifyvisitors.** { *; }

# Preserve annotation metadata and generic signatures used by some SDKs.
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod

# Keep any BroadcastReceiver/Service implementations from being removed.
-keep class * extends android.content.BroadcastReceiver { *; }
-keep class * extends android.app.Service { *; }
