#import <Foundation/Foundation.h>

#import "AFHTTPRequestOperationManager.h"

@interface AppUtils : NSObject {
    BOOL _useMyTW;
}

- (AFHTTPRequestOperationManager *) configureOpManager;

- (NSString *) getUrl:(NSString *) resource;

@end
