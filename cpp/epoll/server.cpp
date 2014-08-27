#include <iostream>
#include <sys/socket.h>
#include <sys/epoll.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>

using namespace std;

#define MAXLINE 5
#define OPEN_MAX 100
#define LISTENQ 20
#define SERV_PORT 5000
#define INFTIM 1000

void setnonblocking( int sock )
{
    int opts;
    opts = fcntl( sock, F_GETFL );
    if ( opts < 0 )
    {
       perror("fcntl(sock,GETFL)");
       exit(1);
    }
    opts = opts | O_NONBLOCK;
    if ( fcntl( sock, F_SETFL, opts ) < 0 )
    {
        perror("fcntl(sock,SETFL,opts)");
        exit(1);
    }
}

int main()
{
    int i, maxi, listenfd, connfd, sockfd, epfd, nfds;
    ssize_t n;
    char line [MAXLINE];

    socklen_t clilen;
    //声明epoll_event结构体的变量, ev用于注册事件,数组用于回传要处理的事件
    struct epoll_event ev, events[20];

    //生成用于处理accept的epoll专用的文件描述符
    epfd=epoll_create(256);

    struct sockaddr_in clientaddr;
    struct sockaddr_in serveraddr;
    listenfd = socket(AF_INET, SOCK_STREAM, 0);
    //把socket设置为非阻塞方式
    //setnonblocking(listenfd);
    //设置与要处理的事件相关的文件描述符
    ev.data.fd=listenfd;
    //设置要处理的事件类型
    ev.events=EPOLLIN|EPOLLET;
    //ev.events=EPOLLIN;

    //注册epoll事件
    epoll_ctl(epfd,EPOLL_CTL_ADD,listenfd,&ev);

    bzero(&serveraddr, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    char *local_addr="127.0.0.1";
    inet_aton(local_addr,&(serveraddr.sin_addr));//htons(SERV_PORT);
    serveraddr.sin_port=htons(SERV_PORT);

    bind(listenfd,(sockaddr *)&serveraddr, sizeof(serveraddr));
    listen(listenfd, LISTENQ);
    maxi = 0;
    for ( ; ; ) {
        //等待epoll事件的发生
        nfds=epoll_wait(epfd,events,20,500);
        //处理所发生的所有事件     
        for(i=0;i<nfds;++i)
        {
            if(events[i].data.fd == listenfd) //有新的连接
            {
                connfd = accept(listenfd,(sockaddr *)&clientaddr, &clilen); //accept这个新连接
                if(connfd<0){
                    perror("connfd<0");
                    exit(1);
                }
                //setnonblocking(connfd);
                char *str = inet_ntoa(clientaddr.sin_addr);
                cout << "accapt a connection from " << str << endl;
                //设置用于读操作的文件描述符
                ev.data.fd=connfd;

                //设置用于注测的读操作事件
                ev.events=EPOLLIN|EPOLLET;
                //ev.events=EPOLLIN;

                //注册ev 将新的fd添加到epoll的监听队列中
                epoll_ctl(epfd,EPOLL_CTL_ADD,connfd,&ev);
            }
            else if(events[i].events & EPOLLIN) //接收到数据，读socket
            {
                cout << "EPOLLIN" << endl;
                if ( (sockfd = events[i].data.fd) < 0) 
                         continue;
                if ( (n = read(sockfd, line, MAXLINE)) < 0) { //读
                         if (errno == ECONNRESET) {
                            close(sockfd);
                            events[i].data.fd = -1;
                         } 
                         else
                            std::cout<<"readline error"<<std::endl;
                } else if (n == 0) {
                    close(sockfd);
                    events[i].data.fd = -1;
                }
                line[n] = '\0';
                cout << "read " << line << endl;
                //设置用于写操作的文件描述符
                ev.data.fd=sockfd;

                //设置用于注测的写操作事件
                ev.events=EPOLLOUT|EPOLLET;

                //修改sockfd上要处理的事件为EPOLLOUT 修改标识符号，等待下一个循环时发送数据 异步处理的精髓
                //epoll_ctl(epfd,EPOLL_CTL_MOD,sockfd,&ev);
            }
            else if(events[i].events & EPOLLOUT) //有数据发送，写socket
            {   
                sockfd = events[i].data.fd;
                write(sockfd, line, n); //写数据

                //设置用于读操作的文件描述符
                ev.data.fd=sockfd;

                //设置用于注测的读操作事件
                ev.events=EPOLLIN|EPOLLET;

                //修改sockfd上要处理的事件为EPOLIN 修改标识符，等待下一个循环时接收数据
                epoll_ctl(epfd,EPOLL_CTL_MOD,sockfd,&ev);
            }
        }
    
    }

    return 0;

}
