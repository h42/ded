import std.stdio, std.string;

struct node {
    node *fp;
    string s;
};

class list {
public:

node head;
int len;
int cur;

this() {head.fp=null; cur=-1; len=0;}

string get(int x) {
    if (x>=len || x<0) throw new Exception("bad index for list.get");
    int i;
    node *n=&head;
    for (i=0; i<=x; i++) n=n.fp;
    return n.s;
}

void insert(int x, string s) {
    int i;
    if (x>len || x<0) throw new Exception("bad index for list.insert");
    node* n=&head, n2=new node;
    for (i=0; i<x; i++) n=n.fp;
    n2.s=s;
    n2.fp = n.fp;
    n.fp=n2;
    len++;
}

} // END OF LIST

void mklist(list l) {
    string s;
    foreach (i; 0..10) {
        s=format("hey now - %d", i);
        writeln(s);
        l.insert(i, s);
    }
    writefln("len=%d\n",l.len);
}

void main() {
    list l = new list();
    string s;
    mklist(l);
    for (int i=0; i<l.len; i++) {
        s=l.get(i);
        writefln("%d. - %s",i,s);
    }
}
