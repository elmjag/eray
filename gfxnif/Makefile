CFLAGS = $(shell pkg-config --cflags sdl2)
LDFLAGS = $(shell pkg-config --libs sdl2)

all: $(MIX_APP_PATH)/graphics.so
	@test 1  # suppresses 'make: Nothing to be done for 'all'.' message

graphics.so: nif.c graphics.c graphics.h
	gcc -o graphics.so -shared -fpic $(CFLAGS) nif.c graphics.c $(LDFLAGS)

$(MIX_APP_PATH)/graphics.so: graphics.so
	cp graphics.so $(MIX_APP_PATH)

clean:
	rm graphics.so
