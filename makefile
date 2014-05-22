PROGS=jpd
OBJS=Term.o Kb.o List.o File.o Base.o
DFLAGS=-w

all:$(PROGS)

#%.o : %.d
#        ghc $(CLG) -c -o $@ $<

%.o : %.d
	dmd -c -w -g $<

% : %.d
	dmd -w -g $<

jpd:jpd.d $(OBJS)
	dmd -w -g jpd.d $(OBJS)

clean:
	-rm *.o $(PROGS)
