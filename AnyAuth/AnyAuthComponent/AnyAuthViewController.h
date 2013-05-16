#import <Foundation/Foundation.h>
#import "AnyAuthHandlerProtocol.h"

@protocol AnyAuthHandlerProtocol;
@protocol AnyAuthViewControllerDelegate;

@interface AnyAuthViewController : UIViewController <AnyAuthHandlerDelegate>

@property (nonatomic, weak) id <AnyAuthViewControllerDelegate> delegate;
@property (nonatomic, strong) id <AnyAuthHandlerProtocol> handler;

- (id)initWithHandler:(id <AnyAuthHandlerProtocol>)newHandler;

@end

@protocol AnyAuthViewControllerDelegate

- (void)authController:(AnyAuthViewController *)controller didFinishAuthorized:(BOOL)authorized;

@end