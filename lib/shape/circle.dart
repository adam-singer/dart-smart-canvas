part of smartcanvas;

class Circle extends Node {

  Circle(Map<String, dynamic> config): super(config) {}

  void populateConfig(Map<String, dynamic> config) {
    super.populateConfig(config);
    var r = _attrs['r'];
    if (r == null) {
      r = _attrs['r'] = 0;
    }
    var width = r * 2;
    _setAttribute('width', width);
    _setAttribute('height', width);
  }

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas) {
    return new _SvgCircle(canvas, _attrs);
  }

  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas) {
    throw 'Not implemented';
  }

  void set r(num value) => _setAttribute('r', value);
  num get r => _getAttribute('r');
}