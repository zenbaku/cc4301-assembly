SRCS = $(wildcard *.s)

PROGS = $(patsubst %.s,%,$(SRCS))

all: $(PROGS)

%: %.s
	$(CC) $(CFLAGS) -nostdlib -o $@ $<
