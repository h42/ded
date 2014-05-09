import std.stdio;
import Term;
import Kb;

void main(string[] args) {
    int c='1';
    auto dsp = new Term;
    auto kb=new Kb;

    //kb.kbtest();

    if (0) {
        while (c!='q') {
            c=getchar();
            dsp.tattr(dsp.Red);
            putchar(c);
        }
    }
}
