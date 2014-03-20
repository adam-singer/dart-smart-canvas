part of smartcanvas;

class Path extends Node {
  Path(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgPath(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }
}