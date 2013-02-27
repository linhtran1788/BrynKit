

#import "SEDispatchSource.h"
#import "Bryn.h"


@implementation SEDispatchSource {
    BrynKitDispatchSourceState _state;
    dispatch_queue_t _queue;
    dispatch_source_t _source;
}

- (instancetype) initWithSource: (dispatch_source_t)source
                        onQueue: (dispatch_queue_t)queue {
    self = [super init];
    if (self) {
        _queue = queue;
        dispatch_retain(_queue);
        _state = BrynKitDispatchSourceState_Canceled;
        _source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_OR, 0, 0, _queue);
    }
    return self;
}



- (void) dealloc {
    // when cancelling, must make sure we resume first if we're suspended
    if (_state == BrynKitDispatchSourceState_Suspended)
        dispatch_resume(_source);

    dispatch_source_cancel(_source);
    dispatch_release(_source);
    _source = nil;

    dispatch_release(_queue);
    _queue = nil;

    _state = BrynKitDispatchSourceState_Canceled;
}



- (BrynKitDispatchSourceState) state {
    BrynKitDispatchSourceState state;
    @synchronized (self) {
        state = _state;
    }
    return state;
}



- (void) stop
{
    @synchronized (self)
    {
        if (_state == BrynKitDispatchSourceState_Resumed) {
            dispatch_suspend(_source);
            _state = BrynKitDispatchSourceState_Suspended;
        }
    }
}


- (void) resume
{
    @synchronized (self)
    {
        if (_state == BrynKitDispatchSourceState_Suspended || _state == BrynKitDispatchSourceState_Canceled)
        {
            dispatch_resume(_source);
            _state = BrynKitDispatchSourceState_Resumed;
        }
    }
}


@end










