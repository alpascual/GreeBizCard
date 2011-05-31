//
//  CompressUtil.h
//  GreenBizCard
//
//  Created by Al Pascual on 3/22/11.
//  Copyright 2011 Al. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData (DDData)


- (NSData *)zlibInflate;
- (NSData *)zlibDeflate;

// gzip compression utilities
- (NSData *)gzipInflate;
- (NSData *)gzipDeflate;



@end