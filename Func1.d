import Base;

class Func1 : Base {

void pgdown() {
    pline();
    if (ztop<0) ztop=0;
    if (ztop >= zrows-1) return;
    int y = zy - ztop;
    ztop += zrows - 1;
    zy = ztop + y;
    if (zy >= zlines) zy=zlines-1;
    disppage(ztop);
}

};  // END FUNC1
