PROGS=jpd
OBJS=Term.o Kb.o List.o File.o Base.o Func1.o
DFLAGS=-w

all:$(PROGS)

#%.o : %.d
#        ghc $(CLG) -c -o $@ $<

#%.o : %.d
#        dmd -c -w -g $<

#% : %.d
#        dmd -w -g $<

%.o : %.d
	gdc -c -Wall -g $<

% : %.d
	gdc -Wall -g $<

jpd:jpd.d $(OBJS)
	gdc -w -g jpd.d $(OBJS) -o jpd # -fuse-linker-plugin

clean:
	-rm *.o $(PROGS)
