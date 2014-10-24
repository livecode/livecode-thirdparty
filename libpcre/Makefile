NAME=libpcre
TYPE=archive

include ../../rules/environment.linux.makefile

# TDZ-2013-09-29 : [[ libpcre update ]]
# SN-2014-01-14: [[ libpcre update ]] now handles unicode-encoded inputs
SOURCES=\
	pcre16_byte_order.c pcre16_chartables.c pcre16_compile.c pcre16_config.c pcre16_dfa_exec.c \
	pcre16_exec.c pcre16_fullinfo.c pcre16_get.c pcre16_globals.c pcre_info_fullinfo.c \
	pcre16_jit_compile.c pcre16_maketables.c pcre16_newline.c pcre16_ord2utf16.c pcre16_refcount.c \
	pcre16_string_utils.c pcre16_study.c pcre16_tables.c pcre16_ucd.c pcre16_valid_utf16.c \
	pcre16_version.c pcre16_xclass.c

CUSTOM_DEFINES=

CUSTOM_INCLUDES=./src

# SN-2014-01-14: [[ libpcre update ]] config file existence flag set here instead of doing it in each
# compiled file
CUSTOM_CCFLAGS=-DHAVE_CONFIG_H

include ../../rules/archive.linux.makefile
