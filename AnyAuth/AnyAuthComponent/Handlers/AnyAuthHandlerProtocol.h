typedef enum {
    AnyAuthHandlerStatusContinue,
    AnyAuthHandlerStatusAuthorized,
    AnyAuthHandlerStatusCanceled
} AnyAuthHandlerStatus;


@protocol AnyAuthHandlerDelegate;


@protocol AnyAuthHandlerProtocol

@property (nonatomic, assign, readonly) BOOL isAuthorised;
@property (nonatomic, assign, readonly) BOOL isWorking;
@property (nonatomic, strong, readonly) NSDictionary *authData;

- (void)startWorking;

- (AnyAuthHandlerStatus)statusBeforeVisitingURL:(NSURL *)url;

@property (nonatomic, weak) id <AnyAuthHandlerDelegate> delegate;

@end


@protocol AnyAuthHandlerDelegate

- (void)authHandler:(id)handler didFinishWithStatus:(AnyAuthHandlerStatus)status;

- (void)authHandler:(id)handler loadURL:(NSURL *)url;

@end