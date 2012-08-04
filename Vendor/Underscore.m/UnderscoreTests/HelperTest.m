//
//  HelperTest.m
//  Underscore
//
//  Created by Robert Böhnke on 5/14/12.
//  Copyright (c) 2012 Robert Böhnke. All rights reserved.
//

#import "HelperTest.h"

#import "Underscore.h"

@implementation HelperTest

- (void)testNegate;
{
    UnderscoreTestBlock yesBlock = ^BOOL (id obj) {
        return YES;
    };

    STAssertFalse(Underscore.negate(yesBlock)(nil), @"Can negate block");

    UnderscoreTestBlock noBlock = ^BOOL (id obj) {
        return NO;
    };

    STAssertTrue(Underscore.negate(noBlock)(nil), @"Can negate block");
}

- (void)testIsEqual;
{
    STAssertTrue(Underscore.isEqual(@"foo")(@"foo"), @"Performs equality check");
    STAssertFalse(Underscore.isEqual(@"foo")(@"bar"), @"Performs equality check");
}

- (void)testIsArray;
{
    STAssertTrue(Underscore.isArray([NSArray array]), @"Returns true for NSArray");

    STAssertFalse(Underscore.isArray([[NSObject alloc] init]), @"Returns false for NSObject");
}

- (void)testIsDictionary;
{
    STAssertTrue(Underscore.isDictionary([NSDictionary dictionary]), @"Returns true for NSDictionary");

    STAssertFalse(Underscore.isDictionary([[NSObject alloc] init]), @"Returns false for NSObject");
}

- (void)testIsNull;
{
    STAssertTrue(Underscore.isNull([NSNull null]), @"Returns true for NSNull");

    STAssertFalse(Underscore.isNull([[NSObject alloc] init]), @"Returns false for NSObject");
}

- (void)testIsNumber;
{
    STAssertTrue(Underscore.isNumber([NSNumber numberWithInteger:12]), @"Returns true for NSNumber");

    STAssertFalse(Underscore.isNumber([[NSObject alloc] init]), @"Returns false for NSObject");
}

- (void)testIsString;
{
    STAssertTrue(Underscore.isString(@"hooray!"), @"Returns true for NSString");

    STAssertFalse(Underscore.isString([[NSObject alloc] init]), @"Returns false for NSObject");
}

@end
