import Base;

class Func1 : Base {

void bottom() {
    pline;
    zy=zlines - (zrows);
    zy = (zy>=0) ? zy : 0;
    disppage(zy);
    zx=0;
    zy=zlines-2;
}

void btab() {
    gline;
    int x = zx%4;
    if (x>0) zx-=x;
    else if (zx>0) zx-=4;
    upoff;
}

void down() {
    pline;
    if (zy>=zlines-1) return;
    zy++;
    if (zy-ztop < zrows-2) return;
    disppage(ztop+1);
}

void end() {
    gline;
    zx=zbufl;
    upoff;
}

void home() {
    zx=0;
    upoff;
}

void left() {
    if (zx>0) zx--;
    upoff;
}

void pgdown() {
    int y = zy - ztop;
    if (ztop >= zlines-zrows-1) return;
    pline;
    ztop += zrows - 1;
    zy = ztop + y;
    if (zy >= zlines) zy=zlines-1;
    disppage(ztop);
    gline;
}

void pgup() {
    int y=zy-ztop;
    pline;
    if (ztop==0) {
        zy=0;
        return;
    }
    ztop-=zrows - 1;
    if (ztop<0) ztop=0;
    zy=ztop + y;
    if (zy >= zlines) zy=zlines-1;
    disppage(ztop);
}

void right() {
    zx++;
    upoff;
}

void tab() {
    zx+=4+zx%4;
    upoff();
}

void top() {
    pline;
    zy=zx=0;
    disppage(zy);
}

void up() {
    pline;
    if (zy>0) zy--;
    if (zy-ztop<0) disppage(zy);
}

void upoff() {
    if (zx-zoff < zcols && zx>=zoff) return;
    zoff = zx - zcols / 2;
    if (zoff<0) zoff = 0;
    disppage(ztop);
}

};  // END FUNC1
