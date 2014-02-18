part of smartcanvas;

class SvgRect extends _SvgNode {
  SvgRect(SvgCanvas canvas, Map<String, dynamic> attrs): super(canvas, attrs) {}

  SVG.SvgElement _createElement() {
    return new SVG.RectElement();
  }
}