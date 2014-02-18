part of smartcanvas;

class SvgLine extends SvgNode {
  SvgLine(SvgCanvas canvas, Map<String, dynamic> attrs): super(canvas, attrs) {}

  SVG.SvgElement _createElement() {
    return new SVG.LineElement();
  }

  Set<String> _getElementAttributeNames() {
    var attrs = super._getElementAttributeNames();
    attrs.addAll(['x1', 'y1', 'x2', 'y2']);
    return attrs;
  }
}