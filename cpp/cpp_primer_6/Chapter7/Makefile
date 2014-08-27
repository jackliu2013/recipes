CC = g++
CFLAGS = -g -Wall

all: calling twoarg lotto arrfun1 arrfun3 arrfun4 strgfun strgback \
	travel structfun strctptr topfive recur ruler fun_ptr protos arfupt1 \
	arfupt 	arrfun2 arrobj 

calling:calling.cpp
	$(CC) $(CFLAGS) $< -o$@
twoarg:twoarg.cpp
	$(CC) $(CFLAGS) $< -o$@
lotto:lotto.cpp
	$(CC) $(CFLAGS) $< -o$@
arrfun1:arrfun1.cpp
	$(CC) $(CFLAGS) $< -o$@
arrfun3:arrfun3.cpp
	$(CC) $(CFLAGS) $< -o$@
arrfun4:arrfun4.cpp
	$(CC) $(CFLAGS) $< -o$@
strgfun:strgfun.cpp
	$(CC) $(CFLAGS) $< -o$@
strgback:strgback.cpp
	$(CC) $(CFLAGS) $< -o$@
travel:travel.cpp
	$(CC) $(CFLAGS) $< -o$@
structfun:structfun.cpp
	$(CC) $(CFLAGS) $< -o$@ -lm
strctptr:strctptr.cpp
	$(CC) $(CFLAGS) $< -o$@
topfive:topfive.cpp
	$(CC) $(CFLAGS) $< -o$@
recur:recur.cpp
	$(CC) $(CFLAGS) $< -o$@
ruler:ruler.cpp
	$(CC) $(CFLAGS) $< -o$@
fun_ptr:fun_ptr.cpp
	$(CC) $(CFLAGS) $< -o$@
protos:protos.cpp
	$(CC) $(CFLAGS) $< -o$@
arfupt1:arfupt1.cpp
	g++472 	$(CFLAGS) $< -o$@ -std=c++0x
arfupt:arfupt.cpp
	g++472 $(CFLAGS) $< -o$@ -std=c++0x
arrfun2:arrfun2.cpp
	g++472 $(CFLAGS) $< -o$@ -std=c++0x
arrobj:arrobj.cpp
	g++472 $(CFLAGS) $< -o$@ -std=c++0x

clean:
	rm -f calling twoarg lotto arrfun1 arrfun3 arrfun4 strgfun strgback \
	travel structfun strctptr topfive recur ruler fun_ptr protos arfupt1 \
	arfupt 	arrfun2 arrobj 
