import std.stdio, std.string;

private const int INS=0, REM=1, UPD=2;

struct ListLog {
    const int cmd;
    const int pos;
    const string s;
};

//
// CLASS LIST
//
class List {

string[] zman;
ListLog[] zlog;
bool zlogging;

public:

this() {zman=new string[0]; zlog=new ListLog[0]; zlogging=false;}

auto length() {
    return zman.length;
}

void startlog() { zlogging=true; }
void stoplog() { zlogging=false; }

ListLog[] commit() {
    auto t=zlog;
    zlog = new ListLog[0];
    return t;
}

int rollback(ListLog[] log) {
    auto rb = zlogging;
    zlogging = false;
    foreach (l;log.reverse) {
        if (l.cmd==INS) insert(l.pos,l.s);
        else if (l.cmd==REM) remove(l.pos);
        else if (l.cmd==UPD) update(l.pos,l.s);
    }
    zlogging = rb;
    return 0;
}

int len() {return cast(int)zman.length;}

string get(int x) {
    if (x>=zman.length || x<0) throw new Exception("bad index for list.get");
    return zman[x];
}

void update(int x, string s) {
    get(x);
    if (zlogging) zlog ~= ListLog(UPD, x , zman[x]);
    zman[x] = s;
}

void insert(int x, string s) {
    if (x>zman.length || x<0)
        throw new Exception(
            format("bad index %d-%s for list.insert - %s",x,zman.length,s)
        );
    if (zlogging) zlog ~= ListLog(REM, x , "");
    auto l=zman.length;
    zman.length++;
    for (auto i=l; i>x; i--) zman[i]=zman[i-1];
    zman[x]=s;
}

void remove(int x) {
    if (x>=zman.length || x<0) throw new Exception("bad index for list.remove");
    if (zlogging) zlog ~= ListLog(INS, x , zman[x]);
    for (auto i=x; i<zman.length-1; i++) zman[i]=zman[i+1];
    zman.length--;
}

} // END OF LIST

/*
void tlist() {
    int lcnt=25;
    
    void mklist(List l) {
        string s;
        foreach (i; 0..lcnt) {
            s=format("hey now - %d", i);
            l.insert(i, s);
            if (i==lcnt-5) l.commit();
        }
        writefln("len=%d\n",l.len());
    }

    List l = new List();
    string s;
    l.startlog();
    mklist(l);

    for (auto i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. - %s",i,s);
    }

    l.remove(l.len()-3);
    l.remove(l.len()-5);
    l.update(l.len()-1, "how now brown cow");
    writeln();

    for (auto i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. %s",i,s);
    }

    auto log = l.commit();
    writeln();
    writeln(log);
    l.stoplog();
    l.rollback(log);

    for (auto i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. %s",i,s);
    }
}
*/
