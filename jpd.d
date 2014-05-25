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

    disppage(0);
    dispstat();
    dsp.tgoto(zy-ztop, zx-zoff);

    while (true) {
        c=kb.get();
        if (c==0) continue;
        else if (c<' ') {    //CONTROL CHARS
            if (c==17) break; //ctrl q
            else if (c==2) bottom();
            else if (c==20) top();
        }
        else if (c<128) {    //REGULAR CHARS
            writeln(c);
        }
        else if (c>=Fkey.F1 && c<=Fkey.ERROR) { //FUNCTION KEYS
            if (c==Fkey.F12) break;
            else if (c==Fkey.PGDOWN) pgdown();
            else if (c==Fkey.PGUP) pgup();
        }
        dispstat();
        dsp.tgoto(zy-ztop, zx-zoff);
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
