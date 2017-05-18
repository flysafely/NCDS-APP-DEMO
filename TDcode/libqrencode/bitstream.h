//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef __BITSTREAM_H__
#define __BITSTREAM_H__

typedef struct {
	int length;
	unsigned char *data;
} BitStream;

extern BitStream *BitStream_new(void);
extern int BitStream_append(BitStream *bstream, BitStream *arg);
extern int BitStream_appendNum(BitStream *bstream, int bits, unsigned int num);
extern int BitStream_appendBytes(BitStream *bstream, int size, unsigned char *data);
#define BitStream_size(__bstream__) (__bstream__->length)
extern unsigned char *BitStream_toByte(BitStream *bstream);
extern void BitStream_free(BitStream *bstream);

#endif /* __BITSTREAM_H__ */
