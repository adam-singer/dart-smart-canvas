part of smartcanvas.svg;

class SvgRect extends SvgNode {
  SvgRect(Rect shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.RectElement();
  }
}