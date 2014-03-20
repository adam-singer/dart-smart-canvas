part of smartcanvas;

class Size {
  num width;
  num height;

  Size.defautl() {
    width = 0;
    height = 0;
  }

  Size(this.width, this.height) {
    if (width == null) { width = 0; }
    if (height == null) { height = 0; }
  }
}