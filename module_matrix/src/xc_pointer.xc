/*
 * Pointer wrangling to cheat in XC
 *
 * Copyright (C) 2011 Steve Kerrison <github@stevekerrison.com>
 *
 * This software is freely distributable under a derivative of the
 * University of Illinois/NCSA Open Source License posted in
 * LICENSE.txt and at <http://github.xcore.com/>
 */
 
unsigned int pointer_int(int p[])
{
	unsigned int ret;
	asm("mov %0,%1":"=r"(ret):"r"(p));
	return ret;
}

unsigned int pointer_short(short p[])
{
	unsigned int ret;
	asm("mov %0,%1":"=r"(ret):"r"(p));
	return ret;
}

unsigned int pointer_char(char p[])
{
	unsigned int ret;
	asm("mov %0,%1":"=r"(ret):"r"(p));
	return ret;
}
