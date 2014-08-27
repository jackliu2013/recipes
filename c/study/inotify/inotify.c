/*
    简单的 inotify 应用程序，它监控创建、删除和修改事件的目录

    使用inotify的步骤
    创建一个文件描述符，附加一个或多个监视器（一个监视器 是一个路径和一组事件），然后使用 read 方法从描述符获取事件。read 并不会用光整个周期，它在事件发生之前是被阻塞的。
    更好的是，因为 inotify 通过传统的文件描述符工作，您可以利用传统的 select 系统调用来被动地监控监视器和许多其他输入源。两种方法 — 阻塞文件描述符和使用 select— 都避免了繁忙轮询。
*/
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/inotify.h>

#define EVENT_SIZE  ( sizeof (struct inotify_event) )
#define BUF_LEN     ( 1024 * ( EVENT_SIZE + 16 ) )

int main( int argc, char**argv ) {
  int length, i = 0;
  int fd;
  int wd;
  char buffer[BUF_LEN];

  // 1 创建一个inotify实例
  fd = inotify_init();
  if ( fd < 0 ) {
      perror("inotify_init");
  }

  // 2 在inotify实例fd 上添加监视器监控对/home/jackliu目录中文件的创建 修改 删除
  wd = inotify_add_watch( fd, "/home/jackliu", IN_MODIFY | IN_CREATE | IN_DELETE );

	
      // read在一个或多个警告到达之前是被阻塞的 警告的详细内容是以字节流的形式发送的因此，应用程序中的循环将字节流转换成一系列事件结构
      length = read( fd, buffer, BUF_LEN );
      if ( length < 0 ) {
          perror("read");
      }
    	
    	//printf("buffer: %s\n",buffer);
      
      while ( i < length ) {
          struct inotify_event *event = ( struct inotify_event *) & buffer[i];
          
          if ( event->len ) {
              if ( event->mask & IN_CREATE ) {
                  if ( event->mask & IN_ISDIR ) {
                      printf( "The directory %s was created.\n", event->name );
                  }
                  else {
                      printf( "The file %s was created.\n", event->name );
                  }
              }
              else if ( event->mask & IN_DELETE ) {
                  if ( event->mask & IN_ISDIR ) {
                      printf( "The directory %s was deleted.\n", event->name );
                  }
                  else {
                      printf( "The file %s was deleted.\n", event->name );
                  }
              }
              else if ( event->mask &IN_MODIFY ) {
                  if ( event->mask &IN_ISDIR ) {
                      printf( "The directory %s was modified.\n", event->name );
                  }
                  else {
                      printf( "The file %s was modified.\n", event->name );
                  }
              }
          }
    
          i += EVENT_SIZE + event->len;
      }

  // 4 删除监控器
  (void) inotify_rm_watch( fd, wd );

  // 5 close inotify实例
  (void) close(fd);

  exit(0);

}
