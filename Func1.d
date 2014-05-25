import Base;

class Func1 : Base {

void bottom() {
    pline();
    zy=zlines - (zrows);
    zy = (zy>=0) ? zy : 0;
    disppage(zy);
    zx=0;
    zy=zlines-2;
    gline();
}

void pgdown() {
    int y = zy - ztop;
    if (ztop >= zlines-zrows-1) return;
    pline();
    ztop += zrows - 1;
    zy = ztop + y;
    if (zy >= zlines) zy=zlines-1;
    disppage(ztop);
    gline();
}

void pgup() {
    int y=zy-ztop;
    pline();
    if (ztop==0) {
        zy=0;
        return;
    }
    ztop-=zrows - 1;
    if (ztop<0) ztop=0;
    zy=ztop + y;
    if (zy >= zlines) zy=zlines-1;
    disppage(ztop);
    gline();
}

void top() {
    pline();
    zy=zx=0;
    disppage(zy);
    gline();
}

};  // END FUNC1
