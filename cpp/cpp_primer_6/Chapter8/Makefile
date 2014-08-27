CC = g++
CFLAGS = -g -Wall

all:inline firstref secref swaps cubes strtref left \
	leftover strc_ref tempover funtemp twotemps twoswap choices \
	filefunct arrtemp strquote strquote2 

inline:inline.cpp
	$(CC) $(CFLAGS) $< -o$@
firstref:firstref.cpp
	$(CC) $(CFLAGS) $< -o$@
secref:secref.cpp
	$(CC) $(CFLAGS) $< -o$@
swaps:swaps.cpp
	$(CC) $(CFLAGS) $< -o$@
cubes:cubes.cpp
	$(CC) $(CFLAGS) $< -o$@
strtref:strtref.cpp
	$(CC) $(CFLAGS) $< -o$@
left:left.cpp
	$(CC) $(CFLAGS) $< -o$@
leftover:leftover.cpp
	$(CC) $(CFLAGS) $< -o$@
strc_ref:strc_ref.cpp
	$(CC) $(CFLAGS) $< -o$@
tempover:tempover.cpp
	$(CC) $(CFLAGS) $< -o$@
funtemp:funtemp.cpp
	$(CC) $(CFLAGS) $< -o$@
twotemps:twotemps.cpp
	$(CC) $(CFLAGS) $< -o$@
twoswap:twoswap.cpp
	$(CC) $(CFLAGS) $< -o$@
choices:choices.cpp
	$(CC) $(CFLAGS) $< -o$@
filefunct:filefunct.cpp
	$(CC) $(CFLAGS) $< -o$@
arrtemp:arrtemp.cpp
	g++472 $(CFLAGS) $< -o$@ -std=c++0x
strquote:strquote.cpp
	$(CC) $(CFLAGS) $< -o$@
strquote2:strquote2.cpp
	$(CC) $(CFLAGS) $< -o$@

clean:
	rm -f inline firstref secref swaps cubes strtref left \
	leftover strc_ref tempover funtemp twotemps twoswap choices \
	filefunct arrtemp strquote strquote22 
