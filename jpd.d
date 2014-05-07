import std.stdio;
import std.process;
import std.c.linux.linux;
import std.c.linux.termios;

extern(C) void cfmakeraw(termios *termios_p);

struct Termdef {
    int rows;
    int cols;
    string clrscr;
    string cup;
    string eol;
    string eos;
    string del_line;
    string ins_line;
    string clr_scr;
    string bg;
    string fg;
    string fg0;
    string fg1;
    string fg2;
    string fg3;
    string fg4;
    string fg5;
    string fg6;
    string fg7;
    string reverse;
    string bold;
    string underline;
    string blink;
    string exit;
};

Termdef xterm = {
     24
    ,80
    ,"\x1b[H\x1b[2J"
    ,  "\x1b[%d;%dH"
    ,"\x1b[K"
    ,"\x1b[J"
    ,"\x1b[M"
    ,"\x1b[L"
    ,"\x1b[H\x1b[2J"
    ,"\x1b[0;40m"
    ,"\x1b[m" // exit att mode
    ,"\x1b[1;30m"
    ,"\x1b[0;31m"
    ,"\x1b[0;32m"
    ,"\x1b[0;33m"
    ,"\x1b[0;34m"
    ,"\x1b[0;35m"
    ,"\x1b[0;36m"
    ,"\x1b[0;30m"
    ,"\x1b[7m"
    ,"\x1b[1m"
    ,"\x1b[4m"
    ,"\x1b[5m"
    ,"\x1b[m" // exit att mode
  };

Termdef linux = {
    25
    ,80
    ,"\x1b[H\x1b[2J"
    ,  "\x1b[%d;%dH"
    ,"\x1b[K"
    ,"\x1b[J"
    ,"\x1b[M"
    ,"\x1b[L"
    ,"\x1b[H\x1b[2J"
    ,"\x1b[0;40m"
    ,"\x1b[m" // exit att mode
    ,"\x1b[1;30m"
    ,"\x1b[0;31m"
    ,"\x1b[0;32m"
    ,"\x1b[0;33m"
    ,"\x1b[0;34m"
    ,"\x1b[0;35m"
    ,"\x1b[0;36m"
    ,"\x1b[0;30m"
    ,"\x1b[7m"
    ,"\x1b[1m"
    ,"\x1b[4m"
    ,"\x1b[5m"
    ,"\x1b[m" // exit att mode
  };

enum attr:int {Norm=0, Black, Red, Green, Yello, Blue, Magenta, Cyan, White,
            Under, Bold, Reverse, Blink};

class Term {
    termios termios1,termios2;
    Termdef zterm;
    string attrs[];

    this() {
        tcgetattr(0,&termios1);
        termios2=termios1;
        cfmakeraw(&termios2);
        termios2.c_oflag |= OPOST;
        //if (x==2) termios2.c_lflag |= ISIG;
        int rc=tcsetattr(0,TCSANOW,&termios2);

        string t = environment.get("TERM");
        zterm =  (t=="linux") ? linux : xterm;
        writef("term=%s\n",t);

        attrs = [zterm.fg, zterm.fg0, zterm.fg1, zterm.fg2, zterm.fg3,
                          zterm.fg4, zterm.fg5, zterm.fg6, zterm.fg7];
    }

    ~this() {
        tattr(attr.Norm);
        tcsetattr(0,TCSANOW,&termios1);
    }

    void tattr(int a) {
        if (a<0 || a>= attrs.length) return;
        write(attrs[a]);
        return;
    }
    void tclreol() {write(zterm.eol);}
    void tclreos() {write(zterm.eos);}
    void tclrscr() {tattr(attr.Norm);write(zterm.clrscr);}
    void tdelline() {write(zterm.del_line);}
    void tgoto(int y, int x) {writef("\x1b[%d;%dH", y+1, x+1);}
    void tinsline() {write(zterm.ins_line);}

};

void main(string[] args) {
    int c='1';
    auto dsp = new Term;
    while (c!='q') {
        c=getchar();
        dsp.tattr(attr.Blue);
        putchar(c);
    }
}
