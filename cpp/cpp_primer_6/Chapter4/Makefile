CC = g++
CFLAGS = -g -Wall

all:strings instr3 instr2 strtype2 strtype1 strtype3 strtype4 \
	assgn_st arrstruct address pointer init_ptr use_new arraynew \
	ptrstr delete choices mixtypes instr1 arrayone addpntrs structur \
	newstrct numstr


strings:strings.cpp
	@$(CC) $(CFLAGS) $< -o$@
instr3:instr3.cpp 
	@$(CC) $(CFLAGS) $< -o$@
instr2:instr2.cpp
	@$(CC) $(CFLAGS) $< -o$@
strtype2:strtype2.cpp
	@$(CC) $(CFLAGS) $< -o$@
strtype1:strtype1.cpp
	@$(CC) $(CFLAGS) $< -o$@
strtype3:strtype3.cpp
	@$(CC) $(CFLAGS) $< -o$@
strtype4:strtype4.cpp 
	@$(CC) $(CFLAGS) $< -o$@
assgn_st:assgn_st.cpp
	@$(CC) $(CFLAGS) $< -o$@
arrstruct:arrstruct.cpp
	@$(CC) $(CFLAGS) $< -o$@
address:address.cpp
	$(CC) $(CFLAGS) $< -o$@
pointer:pointer.cpp
	$(CC) $(CFLAGS) $< -o$@
init_ptr:init_ptr.cpp
	$(CC) $(CFLAGS) $< -o$@
use_new:use_new.cpp
	$(CC) $(CFLAGS) $< -o$@
arraynew:arraynew.cpp
	$(CC) $(CFLAGS) $< -o$@
ptrstr:ptrstr.cpp 
	$(CC) $(CFLAGS) $< -o$@
delete:delete.cpp 
	$(CC) $(CFLAGS) $< -o$@
choices:choices.cpp 
	g++472 $(CFLAGS) $< -o$@ -std=c++0x
mixtypes:mixtypes.cpp 
	$(CC) $(CFLAGS) $< -o$@
instr1:instr1.cpp 
	$(CC) $(CFLAGS) $< -o$@
arrayone:arrayone.cpp 
	$(CC) $(CFLAGS) $< -o$@
addpntrs:addpntrs.cpp 
	$(CC) $(CFLAGS) $< -o$@
structur:structur.cpp 
	$(CC) $(CFLAGS) $< -o$@
newstrct:newstrct.cpp
	$(CC) $(CFLAGS) $< -o$@
numstr:numstr.cpp
	$(CC) $(CFLAGS) $< -o$@


clean:
	@rm -f strings instr3 instr2 strtype2 strtype1 strtype3 strtype4 \
	assgn_st arrstruct address pointer init_ptr use_new arraynew \
	ptrstr delete choices mixtypes instr1 arrayone addpntrs structur \
	newstrct numstr


.SUFFIXES: .cpp .c .o
.cpp.o:
	$(CC) $(CFLAGS) -c $<
