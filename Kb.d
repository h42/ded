import std.stdio;

enum Fkey {F1=1000,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,
        F17,F18,F19,F20,F21,F22,F23,F24,INS,DEL,HOME,HOME2,END,END2,PGUP,PGDOWN,
        BTAB,UP,DOWN,RIGHT,LEFT,ERROR};

private struct Funckeys {
    Fkey kval;
    string kstr;
    int status;
};

private Funckeys[] xterm_fkey = [
     {Fkey.F1, "\x1b""OP"}
    ,{Fkey.F2, "\x1b""OQ"}
    ,{Fkey.F3, "\x1b""OR"}
    ,{Fkey.F4, "\x1b""OS"}
    ,{Fkey.F5, "\x1b""[15~"}
    ,{Fkey.F6, "\x1b""[17~"}
    ,{Fkey.F7, "\x1b""[18~"}
    ,{Fkey.F8, "\x1b""[19~"}
    ,{Fkey.F9, "\x1b""[20~"}
    ,{Fkey.F10, "\x1b""[21~"}
    ,{Fkey.F11, "\x1b""[23~"}
    ,{Fkey.F12, "\x1b""[24~"}
    ,{Fkey.F13, "\x1b\x1b""OP"}
    ,{Fkey.F14, "\x1b\x1b""OQ"}
    ,{Fkey.F15, "\x1b\x1b""OR"}
    ,{Fkey.F16, "\x1b\x1b""OS"}
    ,{Fkey.F17, "\x1b\x1b""[15~"}
    ,{Fkey.F18, "\x1b\x1b""[17~"}
    ,{Fkey.F19, "\x1b\x1b""[18~"}
    ,{Fkey.F20, "\x1b\x1b""[19~"}
    ,{Fkey.F21, "\x1b\x1b""[20~"}
    ,{Fkey.F22, "\x1b\x1b""[21~"}
    ,{Fkey.F23, "\x1b\x1b""[23~"}
    ,{Fkey.F24, "\x1b\x1b""[24~"}
    ,{Fkey.INS, "\x1b""[2~"}
    ,{Fkey.DEL, "\x1b""[3~"}
    ,{Fkey.HOME, "\x1b""[H"}
    ,{Fkey.END, "\x1b""[F"}
    ,{Fkey.PGUP, "\x1b""[5~"}
    ,{Fkey.PGDOWN, "\x1b""[6~"}
    ,{Fkey.BTAB, "\x1b""[Z"}
    ,{Fkey.UP, "\x1b""[A"}
    ,{Fkey.DOWN, "\x1b""[B"}
    ,{Fkey.RIGHT, "\x1b""[C"}
    ,{Fkey.LEFT, "\x1b""[D"}
    ,{Fkey.HOME2, "\x1b""OH"}
    ,{Fkey.END2, "\x1b""OF"}
];

//
// CLASS KB
//
class Kb {
private:
    Funckeys[] fkeys;
    char[] zbuf;
    int zstate;
public:
this() {
    fkeys=xterm_fkey;
    zstate=0;
}

int get() {
    uint c,gotsome;
    c = getchar();
    if (zstate==0) {
        if (c==27) {
            zbuf.length=0;
            zbuf ~= 27;
	    zstate=1;
            foreach (k;fkeys) k.status=0;
            return 0;
	}
        else if (c<256) return c;
    }
    else if (zstate==1) {
        if (zbuf.length==1 && c>='a' && c<='z') {
            zstate=0;
            return c+128;
        }
        zbuf ~= c;
        int ind=cast(int)zbuf.length - 1;
	gotsome=0;
        foreach (k; fkeys) {
            if (k.kstr.length <= ind) k.status=1;
            if (k.status) continue;
            if (k.kstr[ind] != zbuf[ind]) {
                k.status=1;
                continue;
            }
            if (k.kstr == zbuf) {
		zstate=0;
                return k.kval;
	    }
	    gotsome=1;
	}
	if (gotsome==0) {
	    zstate=0;
            return Fkey.ERROR;
	}
    }
    return 0;
}

static if (false) {
void kbtest() {
    int c=0,c2;
    string s;
    while (c!='q') {
        c=get();
        c2=' ';
        if (c<' ') {
            s="control char";
            c2='a' + c - 1;
        }
        else if (c<128) {
            s="regular char";
            c2=c;
        }
        else if (c<256) {
            s="alt char";
            c2=c-128;
        }
        else if (c>=Fkey.F1 && c<=Fkey.F12) s="Fkey";
        else if (c==Fkey.INS) s="Insert";
        else if (c==Fkey.DEL) s="Delete";
        else if (c==Fkey.HOME|| c==Fkey.HOME2) s="Home";
        else if (c==Fkey.END || c==Fkey.END2) s="End";
        else if (c==Fkey.PGUP) s="Page Up";
        else if (c==Fkey.PGDOWN) s="Page Down";
        else if (c==Fkey.DOWN) s="Down";
        else if (c==Fkey.UP) s="Up";
        else if (c==Fkey.RIGHT) s="Right";
        else if (c==Fkey.LEFT) s="Left";
        else if (c==Fkey.BTAB) s="Btab";
        else s="???";
	char dc;
        dc =  (c2>='a' && c2<='z') ? cast(char) c2 : '?';
        writef("c=%d c2=%c %s\n",c,dc,s);
    }
}
}

}; // END CLASS

