import std.c.linux.linux;
import std.stdio, std.string, std.file;
import List, Zvars;

int getFile(string fn, List l) {
    int rc = access(toStringz(fn), W_OK);
    if (rc<0) {
        return -1;
    }
    char[] buf;
    string s;
    auto fh = File(fn,"rb");
    int i=0;
    while (fh.readln(buf)) {
        s=chomp(buf.idup);
        l.insert(i,s);
    }
    return 0;
}

/*
void xxx() {
    auto l = new List;
    getFile("testfile.txt", l, );
    string s;
    for (int i=0; i<l.len(); i++) {
        s=l.get(i);
        writeln(s);
    }
    return ;
}
*/
