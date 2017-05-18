//
//  FMDatabaseAdditions.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#import <Foundation/Foundation.h>
@interface FMDatabase (FMDatabaseAdditions)


- (int)intForQuery:(NSString*)objs, ...;
- (long)longForQuery:(NSString*)objs, ...; 
- (BOOL)boolForQuery:(NSString*)objs, ...;
- (double)doubleForQuery:(NSString*)objs, ...;
- (NSString*)stringForQuery:(NSString*)objs, ...; 
- (NSData*)dataForQuery:(NSString*)objs, ...;
- (NSDate*)dateForQuery:(NSString*)objs, ...;

// Notice that there's no dataNoCopyForQuery:.
// That would be a bad idea, because we close out the result set, and then what
// happens to the data that we just didn't copy?  Who knows, not I.


- (BOOL)tableExists:(NSString*)tableName;
- (FMResultSet*)getSchema;
- (FMResultSet*)getTableSchema:(NSString*)tableName;

- (BOOL)columnExists:(NSString*)columnName inTableWithName:(NSString*)tableName;

- (BOOL)validateSQL:(NSString*)sql error:(NSError**)error;

// deprecated - use columnExists:inTableWithName: instead.
- (BOOL)columnExists:(NSString*)tableName columnName:(NSString*)columnName __attribute__ ((deprecated));

@end
