/* 
 Just show a concurrent multi-connection client example.
 Copyright (C) 2006, Li Suke, School of Software,
 Beijing University
 This  is free software; you can redistribute it and/or
 modify it freely.

 This software  is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <wait.h>
#define MAX_LEN 1024

void sighandler(int signo) 
{
  int status;
  pid_t pid;

  while((pid = waitpid(-1, &status, WNOHANG)) > 0 ) {
    printf("process %d terminated\n",pid);
   
  }
}

int main(int argc, char *argv[])
{
   int sockfd;
   int conn_ret;
   struct sockaddr_in servaddr;
   char sendbuf[30]; 
   int i;
   const char *hello= "hello world!";
   char recvbuf[MAX_LEN];
   ssize_t number_bytes;
   int status;
   pid_t pid;
   signal(SIGCHLD,sighandler);

   if(argc != 3) {
      printf("Usage:readcli <address> <port> \n");
      return 0;
   }

   bzero(&servaddr,sizeof(servaddr));
   servaddr.sin_family = AF_INET;
   servaddr.sin_port = htons(atoi(argv[2]));
   inet_pton(AF_INET, argv[1], &servaddr.sin_addr);

   for (i=0; i<3; i++) {

     if((pid = fork()) == 0) {
    
       if((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1){
          perror("sock");
          exit(1);
       }

       conn_ret = connect(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr));
       if(conn_ret == -1){
          perror("connect");
          exit(1);
       }
      
       snprintf(sendbuf, sizeof(sendbuf), "%s,client:%d",hello,i);
       printf("sendbuf is %s\n",sendbuf);
       if (send(sockfd, sendbuf, strlen(sendbuf), 0)== -1){
          perror("send");
          exit(1);
       }	
       if ((number_bytes = recv(sockfd, recvbuf, MAX_LEN-1, 0))==-1){
          perror("recv");
          exit(1);
       }else{
         recvbuf[number_bytes] = '\0';
         printf("client receives message:%s\n",recvbuf);
       }
       close(sockfd);
       exit(0);
     }
   
   }
   return 0;
}
