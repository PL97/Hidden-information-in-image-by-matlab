function hiddenInfor = revealImage(I, imageLen, h, w, d)
    x = reveal(I, imageLen);
    hiddenInfor = compose(x, h, w, d);