import std.stdio, std.string;

struct node {
    node *fp;
    string s;
};

class List {

node zhead;
int zlen;
int zcur;
node *zcurp;

public:

this() {zhead.fp=null; zcur=-1; zcurp=null; zlen=0;}

int len() { return zlen;}

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
    zcurp.s = s;
}

void insert(int x, string s) {
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
    int lcnt=25000;
    
    void mklist(List l) {
        string s;
        foreach (i; 0..lcnt) {
            s=format("hey now - %d", i);
            //writeln(s);
            l.insert(i, s);
        }
        writefln("len=%d\n",l.len());
    }

    List l = new List();
    string s;
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
}
