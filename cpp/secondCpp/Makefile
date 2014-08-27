G++ = g++
CFLAGS = -o

BIN1 = secondcpp
BIN2 = thirdcpp
BIN3 = fourthcpp
BIN4 = fivecpp

OBJECT1 = secondcpp.cpp
OBJECT2 = thirdcpp.cpp
OBJECT3 = fourthcpp.cpp
OBJECT4 = fivecpp.cpp

all:$(BIN1) $(BIN2) $(BIN3) $(BIN4)

$(BIN1):$(OBJECT1)
	$(G++) $(CFLAGS) $@ $<

$(BIN2):$(OBJECT2)
	$(G++) $(CFLAGS) $@ $<

$(BIN3):$(OBJECT3)
	$(G++) $(CFLAGS) $@ $<

$(BIN4):$(OBJECT4)
	$(G++) $(CFLAGS) $@ $<


clean:
	rm -f $(BIN1) $(BIN2) $(BIN3) $(BIN4)
