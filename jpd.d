import std.stdio;
import  File, Kb, Func1;

class Ded : Func1 {

//
// DED.MAIN
//
void main(string[] args) {
    int c, rc = getFile("temp", zl);
    if (rc<0) {
        dsp.tclrscr();
        writefln("getFile rc = %d",rc);
        kb.get();
        return;
    }

/*
    for (auto i=0; i<zl.len(); i++) {
        string s = zl.get(i);
        writef("%d %s\n",i,s);
    }

    kb.get();
*/

    disppage(0);

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
            else if (c==Fkey.PGDOWN) pgdown();
        }
        dispstat();
    }
}

}; // END DED

import List;
void main(string[] args) {
    auto ded = new Ded;
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
