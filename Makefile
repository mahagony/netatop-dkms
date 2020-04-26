MYMODULE = netatop
KERNDIR = /lib/modules/$(shell uname -r)/build
THISDIR = $(shell pwd)

all: $(MYMODULE).ko

obj-m := $(MYMODULE).o

$(MYMODULE).ko: $(MYMODULE).c $(MYMODULE).h
	./mkversion
	make -C $(KERNDIR) M=$(THISDIR) modules

install: $(MYMODULE).ko
	make -C $(KERNDIR) M=$(THISDIR) modules_install

clean:
	make -C $(KERNDIR) M=$(THISDIR) clean

load:
	-/sbin/rmmod $(MYMODULE)
	/sbin/insmod $(MYMODULE).ko
