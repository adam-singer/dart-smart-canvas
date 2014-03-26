part of smartcanvas;

class PolyLine extends Node {
  PolyLine(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgPolyLine(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }
}