#!/bin/bash

:<<comment
比较oldfile newfile两文件的不同
comment

diff oldfile newfile > patch.diff
patch -p0 < patch.diff
patch -RE -p0 < patch.diff


:<<comment
比较old-dir new-dir两个目录下的文件的不同
comment

diff -uNr old-dir new-dir > patch.diff
patch -p1 < patch.diff
patch -R -p1 < patch.diff
