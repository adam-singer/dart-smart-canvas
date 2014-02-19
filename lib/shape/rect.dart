part of smartcanvas;

class Rect extends Node {
  Rect(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgRect(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }
}