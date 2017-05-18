//
//  MCSoundBoard.h
//  MCSoundBoard
//  NCDS-SJGO
//
//  Created by 徐子迈 on 13-1-11.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MCSoundBoard : NSObject

+ (void)addSoundAtPath:(NSString *)filePath forKey:(id)key;
+ (void)playSoundForKey:(id)key;

+ (void)addAudioAtPath:(NSString *)filePath forKey:(id)key;

+ (void)playAudioForKey:(id)key fadeInInterval:(NSTimeInterval)fadeInInterval;
+ (void)playAudioForKey:(id)key;

+ (void)stopAudioForKey:(id)key fadeOutInterval:(NSTimeInterval)fadeOutInterval;
+ (void)stopAudioForKey:(id)key;

+ (void)pauseAudioForKey:(id)key fadeOutInterval:(NSTimeInterval)fadeOutInterval;
+ (void)pauseAudioForKey:(id)key;

+ (AVAudioPlayer *)audioPlayerForKey:(id)key;

@end
