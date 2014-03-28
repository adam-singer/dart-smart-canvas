part of smartcanvas;

class Line extends Node {
  Line(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgLine(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }

  void set points(List<num> points) {
    assert(points.length >= 4);
    setAttribute('x1', points[0]);
    setAttribute('y1', points[1]);
    setAttribute('x2', points[2]);
    setAttribute('y2', points[3]);
  }
  List<num> get points => [getAttribute('x1', 0), getAttribute('y1', 0),
                           getAttribute('x2', 0), getAttribute('y2', 0)];
}