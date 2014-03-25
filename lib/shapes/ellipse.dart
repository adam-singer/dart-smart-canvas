part of smartcanvas;

class Ellipse extends Node {

  Ellipse(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgEllipse(this);
  }

  NodeImpl _createCanvasImpl() {
    throw ExpNotImplemented;
  }

  void set rx(num value) => setAttribute(RX, value);
  num get rx => getAttribute(RX);

  void set ry(num value) => setAttribute(RY, value);
  num get ry => getAttribute(RY);
}