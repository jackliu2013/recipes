#include <sys/epoll.h>
#include <fcntl.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/inotify.h>

#define EVENT_SIZE  ( sizeof (struct inotify_event) )
#define BUF_LEN     ( 1024 * ( EVENT_SIZE + 16 ) )

int main( int argc, char * argv [] ) {
    int i, epfd, nfds, fd;
    int wd;
    int length;

    char buffer [BUF_LEN];
    struct epoll_event ev, events[20];
    epfd = epoll_create(256);
    fd   = inotify_init();
    wd = inotify_add_watch( fd, "/home/jackliu/tmp", IN_MODIFY | IN_CREATE | IN_DELETE);

      ev.data.fd = fd;
      ev.events = EPOLLIN | EPOLLET;

      epoll_ctl( epfd, EPOLL_CTL_ADD, fd, &ev );

      for ( ; ; ) {
        nfds = epoll_wait( epfd, events, 20, 500 );

        for ( i = 0 ; i < nfds ; ++i ) {
            if ( events[i].data.fd == fd )

            {
                length = read( fd, buffer, BUF_LEN );

                if ( length < 0 ) {
                    perror("read");
                }

                while ( i < length ) {
                    struct inotify_event * event =
                      ( struct inotify_event * ) & buffer [i];
                    if ( event->len ) {
                        if ( event->mask &IN_CREATE ) {
                            if ( event->mask &IN_ISDIR ) {
                                printf( "The directory %s was created.\n",
                                    event->name );
                            }
                            else {
                                printf( "The file %s was created.\n",
                                    event->name );
                            }
                        }
                        else if ( event->mask &IN_DELETE ) {
                            if ( event->mask &IN_ISDIR ) {
                                printf( "The directory %s was deleted.\n",
                                    event->name );
                            }
                            else {
                                printf( "The file %s was deleted.\n",
                                    event->name );
                            }
                        }
                        else if ( event->mask &IN_MODIFY ) {
                            if ( event->mask &IN_ISDIR ) {
                                printf( "The directory %s was modified.\n",
                                    event->name );
                            }
                            else {
                                printf( "The file %s was modified.\n",
                                    event->name );
                            }
                        }
                    }
                    i += EVENT_SIZE + event->len;
                }

            }

        }

    }

    return 0;
}
