#include <stdio.h>
#include <sys/socket.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <linux/un.h>

int main(int argc, char **argv) {

   /* create socket   */ 
   int fd;
   fd = socket( AF_INET, SOCK_STREAM, 0 );
   if ( fd == -1 ) {
        perror("socket"), 
        exit(-1);
   }
   printf("socket½¨Á¢³É¹¦!\n");

   struct sockaddr_un addr = {};
   addr.sun_family = AF_INET;
   sprintf( addr.sun_path, "./my.socket" );

   /* Á¬½Ósocket µÄfd  */ 
   int r;
   r = connect( fd, ( struct sockaddr * ) & addr, sizeof(addr) );
   if ( r == -1 ) {
        perror("connect"), close(fd), exit(-1);
   }

   int i = 0;
   for ( ; i < 10 ; i++ ) 
        write( fd, "hello", 5 );
   close(fd);

   return 0;
}

