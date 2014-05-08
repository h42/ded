import std.stdio;
import Term;

void main(string[] args) {
    int c='1';
    auto dsp = new Term;
    while (c!='q') {
        c=getchar();
        dsp.tattr(dsp.Red);
        putchar(c);
    }
}
