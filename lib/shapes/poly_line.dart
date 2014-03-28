part of smartcanvas;

class Polyline extends Node {
  Polyline(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgPolyline(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }
}