import std.stdio, std.string;
import  Kb, List, Term, File;

//
// CLASS DED0
//
class Ded0 {
public:

    string  zfn;
    Term    dsp;
    Kb      kb;
    List    zl;
    int ztabsize=8;

// UNDO VARS
    int     zused;
    string  zubuf;
    char[]  zbuf,zbuf2;
    int     zbufl;
    int     zcur;
    int     zdel1,zdlen;
    int     zedit,zedit2;
    int     zindent;
    int     zins;
    int     zx,zy,ztop,zoff;
    int     zkx1,zkx2,zky1,zky2,zkh;
// UNDO VARS

this() {
    zl = new List;
    kb = new Kb;
    dsp = new Term();
}

void gline(int up) {
    int i;
    char c;
    string llbuf;
    if (up) zedit=zedit2=1;
    if (zy==zcur) return; // ALL FUNCTIONS MUST SET ZY!=ZCUR IF ZBUF NOT VALID
    zcur=zy;
    llbuf=zl.get(zy);

    for (i=zbufl=0; i<llbuf.length; i++) {
        if ((c=llbuf[i])==0) break;
        if (zbuf.length <= zbufl+8) {
            zbufl += 32;
            zbuf.length = zbufl;
        }
        if (c == 9) {
            zbuf[zbufl++]=' ';
            while(zbufl%ztabsize) zbuf[zbufl++]=' ';
        }
        else zbuf[zbufl++]=c;
    }
    if (zbuf.length != zbuf2.length) zbuf2.length = zbuf.length;
}

//
// DISPLAY
//

bool in_k(int x, int y) { return false;}

void dispchar(int c, int y, int x) {
    int hi=0;
    if (y<0) y = zy;
    if (x<0) x = zx;
    if (in_k(x,y)) {
        hi=1;
        dsp.tattr(dsp.Cyan);
    }
    y -= ztop ;
    x -= zoff ;
    if (hi) dsp.tattr(dsp.White);
    dsp.tgoto(y,x);
    putchar(c);
}

void displine(string sx, int y) {
    int hi=0;
    dsp.tgoto(y-ztop, 0);
    dsp.tclreol();
    if (zoff>=sx.length) return;
    sx=sx[zoff..$];
    int cols = dsp.zterm.cols;
    if (sx.length > cols) sx.length = cols;
    for (int i=0; i<sx.length; i++) {
        if (in_k(zoff+i, y)) {
            if (!hi) {
                dsp.tattr(dsp.White);
                hi=1;
            }
        }
        else {
            if (hi) {
                dsp.tattr(dsp.Cyan);
                hi=0;
            }
        }
        putchar(sx[i]);
    }
    if (hi) dsp.tattr(dsp.White);
}

/*
void ced::disppage(int top) {
    int i;
    pline();
    ztop=top;
    for (i=0; i<zmaxy-2 && i+top<ll.size(); i++) {
	gline2(i+top);
	zbuf2[zbufl2]=0;
	displine(zbuf2, i+top, zbufl2);
    }
    dsp.eos();
}
*/

/*
void ced::dispstat() {
    char sx[80];
    if (1) {
	dsp.cup(zmaxy,1);
	dsp.eol();
    }
    if (zmsg[0]) {
        int mlen=(zmaxx>50) ? 50 : zmaxx-1;
	//dsp.cup(rows,1);
	zmsg[mlen]=0;
        dsp.fg6();
	dsp.puts(zmsg,0,zmaxy,1);
        dsp.fg7();
    }
    sprintf(sx,"%4d,%d %d  ",zy+1,zx+1,ztabcomp);
    sx[12]=0;
    dsp.puts(sx,0,zmaxy,zmaxx-12);
}
*/

//
// DED MAIN
//
void main(string[] args) {
    foreach (i; 'a' .. 'z'+1) dispchar(i, 0, i-'a');
    foreach (i; 2..11) displine(format("This is line %d",i), i);

    kb.get();

    /*
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
    */
}

}; // END DED

