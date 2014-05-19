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
    bool ztabcomp=false;

// UNDO VARS
    int     zused;
    string  zubuf;
    char[]  zbuf,zbuf2;
    int     zbufl,zbufl2;
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

//
// GLINE / PLINE
//
void gline(int up) {
    int i;
    char c;
    string llbuf;
    if (up) zedit=zedit2=1;
    if (zy==zcur) return;
    zcur=zy;
    llbuf=zl.get(zy);
    for (i=zbufl=0; i<llbuf.length; i++) {
        if ((c=llbuf[i])==0) break;
        if (zbuf.length <= zbufl+8) zbuf.length = zbufl+32;
        if (c == 9) {
            zbuf[zbufl++]=' ';
            while(zbufl%ztabsize) zbuf[zbufl++]=' ';
        }
        else zbuf[zbufl++]=c;
    }
}

void gline2(int y) {
    int i;
    char c;
    string llbuf;
    llbuf=zl.get(y);
    for (i=zbufl2=0; i<llbuf.length; i++) {
        if ((c=llbuf[i])==0) break;
        if (zbuf2.length <= zbufl2+8) zbuf2.length = zbufl2+32;
        if (c == 9) {
            zbuf2[zbufl2++]=' ';
            while(zbufl2%ztabsize) zbuf2[zbufl2++]=' ';
        }
        else zbuf2[zbufl2++]=c;
    }
}

int tabstop(int x) {
    return x + ztabsize - x % ztabsize;
}

void pline() {
    int i,j,k,state;
    char c;
    if (!zedit2) return;

    j=zbufl;
    zbufl=0;
    for (i=j-1;i>=0;i--)
	if (zbuf[i]!=' ') {
	    zbufl=i+1;
	    break;
	}
    zbuf[zbufl]=0;

    if (ztabcomp) {
        for (i=j=k=state=0; i<zbufl; i++) {
            c=zbuf[i];
            if (state==0) {
                if (c==' ') {
                    k++;
                    if (k==ztabsize) {
                        zbuf[j++]=9;
                        k=0;
                    }
                }
                else {
                    state=1;
                    if (k) {
                        for (int k2=0; k2<k; k2++) zbuf[k2]=' ';
                        j+=k;
                    }
                    zbuf[j++]=c;
                }
            }
            else zbuf[j++]=c;
        }
        zbuf[j]=0;
        zbufl=j;
    }

    zl.update(zcur,zbuf[0..zbufl].idup);
    zedit2=0;
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

void displine(char[] sx, int y) {
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

void disppage(int top) {
    int i;
    pline();
    ztop=top;
    for (i=0; i<dsp.zterm.cols-2 && i+top<zl.zlen; i++) {
	gline2(i+top);
	zbuf2[zbufl2]=0;
        displine(zbuf2[0..zbufl2], i+top);
    }
    dsp.tclreos();
}

/*
void dispstat() {
    char sx[80];
    if (1) {
        dsp.tgoto(dsp.zterm.rows-1,0);
        dsp.tclreol();
    }
    if (zmsg!="") {
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
    foreach (i; 2..11) displine(cast(char[])format("This is line %d",i), i);

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

