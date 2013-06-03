#import "AnyAuthViewController.h"
#import "AnyAuthHandlerProtocol.h"

@interface AnyAuthViewController () <UIWebViewDelegate>
@end

@implementation AnyAuthViewController {
    NSURL *currentUrl;
    UIWebView *webView;
}
@synthesize delegate;
@synthesize handler;

- (id)initWithHandler:(id <AnyAuthHandlerProtocol>)newHandler {
    if (self = [super init]) {
        handler = newHandler;
        handler.delegate = self;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!webView) {
        webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.delegate = self;
    }
    [self.view addSubview:webView];

    // TODO: nav bar

    if (currentUrl) {
        NSURLRequest *request = [NSURLRequest requestWithURL:currentUrl];
        [webView loadRequest:request];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!handler.isWorking && !handler.isAuthorised) {
        [handler startWorking];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)_webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    currentUrl = request.URL;
    AnyAuthHandlerStatus status = [handler statusBeforeVisitingURL:request.URL];

    switch (status) {
        case AnyAuthHandlerStatusContinue:
            return YES;

        case AnyAuthHandlerStatusAuthorized:
            [self.delegate authController:self didFinishAuthorized:YES];
            return NO;

        case AnyAuthHandlerStatusCanceled:
            [self.delegate authController:self didFinishAuthorized:NO];
            return NO;
    }

    return NO;
}

#pragma mark - AnyAuthControllerProtocol

- (void)authHandler:(id)_handler loadURL:(NSURL *)url {
    currentUrl = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:currentUrl];
    [webView loadRequest:request];
}

- (void)authHandler:(id)_handler didFinishWithStatus:(AnyAuthHandlerStatus)status {
    switch (status) {
        case AnyAuthHandlerStatusContinue:
            break;

        case AnyAuthHandlerStatusAuthorized:
            [self.delegate authController:self didFinishAuthorized:YES];
            break;

        case AnyAuthHandlerStatusCanceled:
            [self.delegate authController:self didFinishAuthorized:NO];
            break;
    }
}

@end