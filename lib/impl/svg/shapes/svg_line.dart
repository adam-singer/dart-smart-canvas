part of smartcanvas.svg;

class SvgLine extends SvgNode {
  SvgLine(Line shell): super(shell) {}

  SVG.SvgElement _createElement() {
    return new SVG.LineElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll([X1, Y1, X2, Y2]);
    return attrs;
  }

  String get _nodeName => SC_LINE;
}