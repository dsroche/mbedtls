# Makefile for detworam version of mbedtls library

CPPFLAGS += -I./include
CPPFLAGS += -Wall -Wextra -Werror
LDFLAGS += -L.
LDLIBS += -lcr
DEPFLAGS = -MMD -MP -MQ $@
CC ?= gcc
CODEDIR = ./library
COMPONENTS = aes aesni entropy entropy_poll ctr_drbg sha512 timing

# debugging options
#CPPFLAGS += -ggdb -DWORAM_DEBUG
# high-speed options
CPPFLAGS += -Ofast -march=native

LIBRARY=libcr.a

all: $(LIBRARY)

$(LIBRARY): $(COMPONENTS:=.o)
	ar rcs $@ $^

$(COMPONENTS:=.o): %.o: $(CODEDIR)/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(LIBRARY) *.o

.INTERMEDIATE: $(COMPONENTS:=.o)
.PHONY: all clean
