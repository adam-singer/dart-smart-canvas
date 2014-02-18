part of smartcanvas;

class Ellipse extends Node {

  Ellipse(Map<String, dynamic> config): super(config) {}

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas) {
    return new SvgEllipse(canvas, _attrs);
  }

  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas) {
    throw 'Not implemented';
  }

  void set rx(num value) => _setAttribute('rx', value);
  num get rx => _getAttribute('rx');

  void set ry(num value) => _setAttribute('ry', value);
  num get ry => _getAttribute('ry');
}