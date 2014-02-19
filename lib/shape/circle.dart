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
    setAttribute('width', width);
    setAttribute('height', width);
  }

  NodeImpl _createSvgImpl() {
    return new SvgCircle(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }

  void set r(num value) => setAttribute('r', value);
  num get r => getAttribute('r');
}