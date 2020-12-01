#import <dlfcn.h>

void help(int status);
void showNotification(NSString *title, NSString *message, NSString *bundleID);

@interface CPNotification: NSObject
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message userInfo:(NSDictionary *)userInfo badgeCount:(int)badgeCount soundName:(NSString *)soundName delay:(double)delay repeats:(BOOL)repeats bundleId:(NSString *)bundleId uuid:(NSString *)uuid silent:(BOOL)silent;
@end