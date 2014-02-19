part of smartcanvas;

class Ellipse extends Node {

  Ellipse(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgEllipse(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }

  void set rx(num value) => setAttribute('rx', value);
  num get rx => getAttribute('rx');

  void set ry(num value) => setAttribute('ry', value);
  num get ry => getAttribute('ry');
}