//
//  IPAddress.h
//  NCDS-SJGO
//
//  Created by Mofioso on 13-3-9.
//  Copyright (c) 2013年 XcodeTest. All rights reserved.
//
//

#ifndef WhatsMyIP_IPAddress_h
#define WhatsMyIP_IPAddress_h



#endif

/*  
 *  IPAdress.h  
 *  
 *  
 */  

#define MAXADDRS    32  

extern char *if_names[MAXADDRS];  
extern char *ip_names[MAXADDRS];  
extern char *hw_addrs[MAXADDRS];  
extern unsigned long ip_addrs[MAXADDRS];  

// Function prototypes  
char ether_ntoa();
void InitAddresses();  
void FreeAddresses();  
void GetIPAddresses();  
void GetHWAddresses();  
