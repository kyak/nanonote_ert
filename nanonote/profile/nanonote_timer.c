/* nanonote_timer.c
 *
 * Specifies profile timer access functions
 *
 */

#include "nanonote_timer.h"

unsigned long profileTimerRead(void)
{
	struct timeval tv;
	static signed long startSec = 0;
	unsigned long out = 0;
	if (startSec == 0) {
		gettimeofday(&tv, NULL);
		startSec = tv.tv_sec;
		out = tv.tv_usec;
	} else {
		gettimeofday(&tv, NULL);
		/* This is to avoid overflow */
		out = (tv.tv_sec - startSec)*1000000+tv.tv_usec;
	}
	return out;
}
