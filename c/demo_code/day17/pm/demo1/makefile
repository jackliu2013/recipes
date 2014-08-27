mythread:mythread.cpp
	g++ -c mythread.cpp -omythread.o
userdata:
	g++ -c userdata.cpp -ouserdata.o
data_main:
	g++ -c data_main.cpp -odata_main.o
main:mythread userdata data_main
	g++ mythread.o userdata.o data_main.o \
	-omain -lpthread
clean:
	rm -f *.o
	rm -f *.gch
	rm -f main
