import std.stdio;
import Term, Kb, List;

void main(string[] args) {
    int c='1';
    auto dsp = new Term;
    auto kb=new Kb;
    auto ll = new List;

    tlist();

    //kb.kbtest();

    if (0) {
        while (c!='q') {
            c=getchar();
            dsp.tattr(dsp.Red);
            putchar(c);
        }
    }
}
