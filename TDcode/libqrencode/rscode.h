//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef __RSCODE_H__
#define __RSCODE_H__

/*
 * General purpose RS codec, 8-bit symbols.
 */

typedef struct _RS RS;

/* WARNING: Thread unsafe!!! */
extern RS *init_rs(int symsize, int gfpoly, int fcr, int prim, int nroots, int pad);
extern void encode_rs_char(RS *rs, const unsigned char *data, unsigned char *parity);
extern void free_rs_char(RS *rs);
extern void free_rs_cache(void);

#endif /* __RSCODE_H__ */
