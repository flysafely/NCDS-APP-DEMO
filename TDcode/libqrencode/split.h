//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef __SPLIT_H__
#define __SPLIT_H__

#include "qrencode.h"


extern int Split_splitStringToQRinput(const char *string, QRinput *input,
		QRencodeMode hint, int casesensitive);

#endif /* __SPLIT_H__ */
