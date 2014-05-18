import std.stdio;
import Term, Kb, List, File, Zvars;

//
// CLASS DED
//
class ded {
public:

Zvars   z;
string  zfn;
Term    dsp;
Kb      kb;
List    zl;

this() {
    zl = new List;
    kb = new Kb;
    dsp = new Term;
    Zvars z;
}

void main(string[] args) {
    int c;
    while (true) {
        c=kb.get();
        if (c==0) continue;
        else if (c<' ') {    //CONTROL CHARS
            if (c==17) break;
        }
        else if (c<128) {    //REGULAR CHARS
            writeln(c);
        }
        else if (c>=Fkey.F1 && c<=Fkey.ERROR) { //FUNCTION KEYS
            if (c==Fkey.F12) break;
        }
    }
}

}; // END DED

void main(string[] args) {
    auto ded = new ded;
    ded.main(args);

    /*
    ll.startlog();
    ll.stoplog();
    ListLog[] v;
    v=ll.commit();
    tlist();
    xxx();
    */
}
