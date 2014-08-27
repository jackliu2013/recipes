#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dump;
use Digest::MD5 qw(md5 md5_hex md5_base64);

#
#
# perl md5.pl ./test
# perl md5.pl ./test/aa
#

#校验文件函数
sub calc_md5_hex() {
    my ( $file_name, $ctx, $md5 );

    ($file_name) = @_;

    open( FILEHANDLE, $file_name ) or die "Can not open $file_name: $!";
    $ctx = Digest::MD5->new;
    binmode(FILEHANDLE);
    $ctx->addfile(*FILEHANDLE) || die "$!\n";
    $md5 = $ctx->hexdigest;
    close FILEHANDLE;

    return $md5;
}

sub calc_md5_ASCII() {
    my ( $file_name, $ctx, $md5 );

    ($file_name) = @_;

    open( FILEHANDLE, $file_name ) or die "Can not open $file_name: $!";
    $ctx = Digest::MD5->new;

    #binmode(FILEHANDLE);
    $ctx->addfile(*FILEHANDLE) || die "$!\n";
    $md5 = $ctx->hexdigest;
    close FILEHANDLE;

    return $md5;
}

# 定义目录路径
my $dirhandle = $ARGV[0];
Data::Dump->dump($dirhandle);

#my $file_only = $ARGV[1]; #定义是否只是文件测试,给验证单个文件调用

if ( -f $dirhandle ) {
    my $file_md5;
    if ( -T $dirhandle ) {
        $file_md5 = &calc_md5_ASCII($dirhandle);
    }
    elsif ( -B $dirhandle ) {
        $file_md5 = &calc_md5_hex($dirhandle);
    }

    print "开始计算文件MD5值:\n${dirhandle}\n[${file_md5}][MD5_hex]\n";

    exit 0;
}
elsif ( -d $dirhandle ) {
    my $file_md5;
    print "开始验证目录下所有文件:\n";
    opendir( DH, "$dirhandle" ) or die "Can not open dir $dirhandle: $!";

    foreach my $file ( readdir DH ) {
        $file = $dirhandle . '/' . $file;

        if ( -f $file ) {
            next if ( $file =~ m{/.$} || $file =~ m{/..$} || -l $file );

            if ( -T $file ) {

                #print "按照文本文件进行计算MD5!\n";
                $file_md5 = &calc_md5_ASCII($file);
                print "开始计算文件MD5值:\n${file}\n[${file_md5}][MD5_ascii]\n";
            }
            elsif ( -B $file ) {

                #print "按照二进制文件进行计算MD5!\n";
                $file_md5 = &calc_md5_hex($file);
                print "开始计算文件MD5值:\n${file}\n[${file_md5}][MD5_hex]\n";
            }
            else {
                print "不能识别文件文件为二进制还是文本,按照二进制文件进行计算!\n";
                $file_md5 = &calc_md5_hex($file);
                print "开始计算文件MD5值:\n${file}\n[${file_md5}][MD5_hex]\n";
            }
        }
    }

    closedir DH;
}
