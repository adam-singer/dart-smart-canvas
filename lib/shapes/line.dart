part of smartcanvas;

class Line extends Node {
  Line(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgLine(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }
}