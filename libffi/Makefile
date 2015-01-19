NAME=libffi
TYPE=archive

include ../../rules/environment.linux.makefile

# TODO: support for non-x86 architectures

ifeq ($(ARCH),i386)
  include linux/i686-pc-linux-gnu/Makefile
else ifeq ($(ARCH),x86_64)
  include linux/x86_64-unknown-linux-gnu/Makefile
else
  error "Unknown architecture for libffi"
endif

include ../../rules/archive.linux.makefile

