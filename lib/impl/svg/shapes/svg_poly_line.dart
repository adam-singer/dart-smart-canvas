part of smartcanvas.svg;

class SvgPolyLine extends SvgNode {
  SvgPolyLine(PolyLine shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.PolylineElement();
  }

  String get _nodeName => SC_POLYLINE;
}