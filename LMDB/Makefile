# Makefile for liblmdb (Lightning memory-mapped database library).

########################################################################
# Configuration. The compiler options must enable threaded compilation.
#
# Preprocessor macros (for CPPFLAGS) of interest...
# Note that the defaults should already be correct for most
# platforms; you should not need to change any of these.
# Read their descriptions in mdb.c if you do:
#
# - MDB_USE_POSIX_MUTEX, MDB_USE_POSIX_SEM, MDB_USE_SYSV_SEM
# - MDB_DSYNC
# - MDB_FDATASYNC
# - MDB_FDATASYNC_WORKS
# - MDB_USE_PWRITEV
# - MDB_USE_ROBUST
#
# There may be other macros in mdb.c of interest. You should
# read mdb.c before changing any of them.
#
CC	= gcc
AR	= ar
W	= -W -Wall -Wno-unused-parameter -Wbad-function-cast -Wuninitialized
THREADS = -pthread
OPT = -O2 -g
CFLAGS	= $(THREADS) $(OPT) $(W) $(XCFLAGS)
LDLIBS	=
SOLIBS	=
SOEXT	= .so

########################################################################

IHDRS	= lmdb.h
ILIBS	= liblmdb.a liblmdb$(SOEXT)
all:	$(ILIBS)

clean:
	rm -rf *.[ao] *.[ls]o *~

liblmdb.a:	mdb.o midl.o
	$(AR) rs $@ mdb.o midl.o

liblmdb$(SOEXT):	mdb.lo midl.lo
#	$(CC) $(LDFLAGS) -pthread -shared -Wl,-Bsymbolic -o $@ mdb.o midl.o $(SOLIBS)
	$(CC) $(LDFLAGS) -pthread -shared -o $@ mdb.lo midl.lo $(SOLIBS)

mdb.o: mdb.c lmdb.h midl.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -c mdb.c

midl.o: midl.c midl.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -c midl.c

mdb.lo: mdb.c lmdb.h midl.h
	$(CC) $(CFLAGS) -fPIC $(CPPFLAGS) -c mdb.c -o $@

midl.lo: midl.c midl.h
	$(CC) $(CFLAGS) -fPIC $(CPPFLAGS) -c midl.c -o $@

%:	%.o
	$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@

%.o:	%.c lmdb.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $<
