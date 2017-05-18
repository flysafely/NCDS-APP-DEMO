//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef __QRINPUT_H__
#define __QRINPUT_H__

#include "qrencode.h"
#include "bitstream.h"

/******************************************************************************
 * Entry of input data
 *****************************************************************************/
typedef struct _QRinput_List QRinput_List;

struct _QRinput_List {
	QRencodeMode mode;
	int size;				///< Size of data chunk (byte).
	unsigned char *data;	///< Data chunk.
	BitStream *bstream;
	QRinput_List *next;
};

/******************************************************************************
 * Input Data
 *****************************************************************************/
struct _QRinput {
	int version;
	QRecLevel level;
	QRinput_List *head;
	QRinput_List *tail;
};

/******************************************************************************
 * Structured append input data
 *****************************************************************************/
typedef struct _QRinput_InputList QRinput_InputList;

struct _QRinput_InputList {
	QRinput *input;
	QRinput_InputList *next;
};

struct _QRinput_Struct {
	int size;					///< number of structured symbols
	int parity;
	QRinput_InputList *head;
	QRinput_InputList *tail;
};

/**
 * Pack all bit streams padding bits into a byte array.
 * @param input input data.
 * @return padded merged byte stream
 */
extern unsigned char *QRinput_getByteStream(QRinput *input);


extern int QRinput_estimateBitsModeNum(int size);
extern int QRinput_estimateBitsModeAn(int size);
extern int QRinput_estimateBitsMode8(int size);
extern int QRinput_estimateBitsModeKanji(int size);

extern QRinput *QRinput_dup(QRinput *input);

extern const signed char QRinput_anTable[128];

/**
 * Look up the alphabet-numeric convesion table (see JIS X0510:2004, pp.19).
 * @param __c__ character
 * @return value
 */
#define QRinput_lookAnTable(__c__) \
	((__c__ & 0x80)?-1:QRinput_anTable[(int)__c__])

/**
 * Length of a segment of structured-append header.
 */
#define STRUCTURE_HEADER_BITS 20

/**
 * Maximum number of symbols in a set of structured-appended symbols.
 */
#define MAX_STRUCTURED_SYMBOLS 16

#endif /* __QRINPUT_H__ */
