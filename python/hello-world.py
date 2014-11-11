#!/usr/bin/python

print 'hello world'

print "hello jakcliu"

'''
this is annotation
'''

while True:
    x = int(raw_input("please enter an integer:"))
    if x < 0:
        x = 0
        print "Negative changed to zero"
    elif x == 0:
        print "zero"
    elif x == 1:
        print "single"
    else:
        print "more"
        break

print "break out while"
