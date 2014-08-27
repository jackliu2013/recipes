#include <sys/inotify.h>
#include <sys/epoll.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>


#define EVENT_SIZE  ( sizeof (struct inotify_event) )
#define BUF_LEN     ( 1024 * ( EVENT_SIZE + 16 ) )

int main() {

    int i = 0, length, fd, wfd, epfd, nfds;
    char buffer [BUF_LEN];

    fd = inotify_init();
    if ( fd < 0 ) {
        perror("inotify_init fail");
    }


    wfd = inotify_add_watch (fd, "/home/jackliu", IN_MODIFY | IN_CREATE | IN_DELETE);

    struct epoll_event ev, events[20];

    //生成用于处理监控inotify的epoll专用的文件描述符
    epfd=epoll_create(256);

    //设置与要处理的事件相关的文件描述符
    ev.data.fd=fd;

    //设置要处理的事件类型
    ev.events=EPOLLIN|EPOLLET;
    //ev.events=EPOLLIN;

    //注册epoll事件
    epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev);

    for ( ; ; ) {
        //等待epoll事件的发生
        nfds=epoll_wait(epfd, events, 20, 500);
        //处理所发生的所有事件     
        for( i=0 ; i<nfds ; ++i )
        {
            if(events[i].data.fd == fd) //发生的事件的描述符是inotfiy的fd
            {
                length = read (fd, buffer, BUF_LEN);  

                if (length < 0){  
                    perror ("read");  
                }  

                while (i < length){  
                    struct inotify_event *event =  
                        (struct inotify_event *) &buffer[i];  

                    if (event->len){  
                        if (event->mask & IN_CREATE){ 
                        	  if ( event->mask & IN_ISDIR ) {
                  						printf( "The directory %s was created.\n", event->name );
              							}
              							else {
                              printf ("The file %s was created.\n",  event->name);  
                        		}
                        }  
                        else if (event->mask & IN_DELETE){  
                            if ( event->mask & IN_ISDIR ) {
                  						printf( "The directory %s was deleted.\n", event->name );
              							}
              							else {
                              printf ("The file %s was deleted.\n",  event->name);  
                        		}
                        }  
                        else if (event->mask & IN_MODIFY){  
                            if ( event->mask & IN_ISDIR ) {
                  						printf( "The directory %s was modified.\n", event->name );
              							}
              							else {
                              printf ("The file %s was modified.\n",  event->name);  
                        		}
                        }//else if  
                    }//if event->len
                    i += EVENT_SIZE + event->len;  
            		}
    
        		}

       }

    } 
    
    return 0;

}
