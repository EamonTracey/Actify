#import "../include/Actify.h"

@implementation ActifyListener

+ (void)load {

  @autoreleasepool {
    [[LAActivator sharedInstance] registerListener:[self new] forName:@"com.eamontracey.actifylistener"];
  }

}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {

    return @"Actify";

}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {

    return @"Display a custom notification from any app";

}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {

    return [NSArray arrayWithObjects:@"springboard", @"lockscreen", @"application", nil];

}

- (UIImage *)activator:(LAActivator *)activator requiresIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale {

	return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ActifyPreferences.bundle/icon.png"];

}

- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale {

	return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ActifyPreferences.bundle/icon.png"];

}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {

	[self showNotificationWithTitle:title message:message fromAppWithBundleID:bundleID];

}

- (void)showNotificationWithTitle:(NSString *)title message:(NSString *)message fromAppWithBundleID:(NSString *)bundleID {

	void *handle = dlopen("/usr/lib/libnotifications.dylib", RTLD_LAZY);
	if (handle != NULL && [bundleID length] > 0) {                                            
		NSString *uid = [[NSUUID UUID] UUIDString];        
  		[NSClassFromString(@"CPNotification") showAlertWithTitle:title message:message userInfo:@{@"" : @""} badgeCount:0 soundName:nil delay:1.0 repeats:NO bundleId:bundleID uuid:uid silent:NO];			       				       
		dlclose(handle);
	}

}

@end

static void loadPreferences() {

	NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.eamontracey.actifypreferences.plist"];
	NSDictionary *appListPreferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.eamontracey.actifypreferences~applist.plist"];

	title = [preferences objectForKey:@"title"] ? [preferences objectForKey:@"title"] : @"";
	message = [preferences objectForKey:@"message"] ? [preferences objectForKey:@"message"] : @"";

	bundleID = [appListPreferences objectForKey:@"bundleID"] ? [appListPreferences objectForKey:@"bundleID"] : @"";

}

%ctor {

	loadPreferences();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.eamontracey.actifypreferences/saved"), NULL, CFNotificationSuspensionBehaviorCoalesce);

}