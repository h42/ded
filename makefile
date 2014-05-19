PROGS=jpd
OBJS=Term.o Kb.o List.o File.o Ded0.o
DFLAGS=-w

all:$(PROGS)

#%.o : %.d
#        ghc $(CLG) -c -o $@ $<

%.o : %.d
	dmd -c -w $<

% : %.d
	dmd -w $<

jpd:jpd.d $(OBJS)
	dmd -w -g jpd.d $(OBJS)

clean:
	-rm *.o $(PROGS)
