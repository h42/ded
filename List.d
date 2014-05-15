import std.stdio, std.string;

//
// STRUCT NODE
//
private struct node {
    node *fp;
    string s;
};

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

node zhead;
int zlen;
int zcur;
node *zcurp;

ListLog[] zlog;
bool zlogging;

public:

this() {zhead.fp=null; zcur=-1; zcurp=null; zlen=0;
        zlog=new ListLog[1]; zlogging=false;}

int len() { return zlen;}

void startlog() { zlogging=true; }
void stoplog() { zlogging=false; }

ListLog[] commit() {
    auto t=zlog;
    zlog = new ListLog[0];
    return t;
}

int rollback(ListLog[] log) {
    foreach (l;log.reverse) {
        if (l.cmd==INS) insert(l.pos,l.s);
        else if (l.cmd==REM) remove(l.pos);
        else if (l.cmd==UPD) update(l.pos,l.s);
    }
    return 0;
}

string get(int x) {
    if (x>=zlen || x<0) throw new Exception("bad index for list.get");
    int i,j=0;
    node *n=&zhead;
    if (x==zcur) return zcurp.s;
    if (x>zcur && zcur>0) {
        j=zcur+1;
        n=zcurp;
    }
    for (i=j; i<=x; i++) n=n.fp;
    zcur = x;
    zcurp = n;
    return n.s;
}

void update(int x, string s) {
    get(x);
    if (zlogging) zlog ~= ListLog(UPD, x , zcurp.s);
    zcurp.s = s;
}

void insert(int x, string s) {
    if (zlogging) zlog ~= ListLog(REM, x , "");
    int i,j;
    if (x>zlen || x<0) throw new Exception("bad index for list.insert");
    node* n=&zhead, n2=new node;
    if (x>zcur && zcur>0) {
        j=zcur+1;
        n=zcurp;
    }
    for (i=j; i<x; i++) n=n.fp;
    n2.s=s;
    n2.fp = n.fp;
    n.fp=n2;
    zcur = x;
    zcurp = n2;
    zlen++;
}

void remove(int x) {
    int i,j;
    if (x>zlen || x<0) throw new Exception("bad index for list.insert");
    node* n=&zhead, n2;
    if (x>zcur && zcur>0) {
        j=zcur+1;
        n=zcurp;
    }
    for (i=j; i<x; i++) n=n.fp;
    n2=n.fp;
    if (zlogging) zlog ~= ListLog(INS, x , n2.s);
    n.fp=n2.fp;
    if (x < zcur) zcur --;
    else if (x == zcur) {
        zcur = -1;
        zcurp = null;
    }
    zlen--;
}

} // END OF LIST

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

    for (int i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. - %s",i,s);
    }

    l.remove(l.len()-3);
    l.remove(l.len()-5);
    l.update(l.len()-1, "how now brown cow");
    writeln();

    for (int i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. %s",i,s);
    }

    auto log = l.commit();
    writeln();
    writeln(log);
    l.rollback(log);

    for (int i=l.len()-7; i<l.len(); i++) {
        s=l.get(i);
        writefln("%d. %s",i,s);
    }
}
