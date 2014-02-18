part of smartcanvas;

abstract class Node extends NodeBase {
  _ICanvasImpl _canvas = null;
  _INodeImpl _impl = null;
  Node _parent = null;

  Node([Map<String, dynamic> config = null]): super() {
    if (config == null) {
      config = {};
    }
    populateConfig(config);
  }

  void populateConfig(Map<String, dynamic> config) {
    config.forEach(_setAttribute);
    if (_attrs['fill'] == null) {
      _attrs['fill'] = 'transparent';
    }
  }

  void addToCanvas(Canvas canvas) {
    _canvas = canvas._impl;
    _impl = _createImpl(_canvas);
    _canvas.appendChild(_impl);
  }

  _INodeImpl _createImpl(canvasOrType) {
    var type = canvasOrType is String ? canvasOrType : canvasOrType.type;
    switch (type) {
      case 'svg':
        return _createSvgImpl(canvasOrType);
      default:
        return _createCanvasImpl(canvasOrType);
    }
  }

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas);
  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas);

  void set id(String value) => _setAttribute('id', value);
  String get id => _getAttribute('id');

  void set x(num value) => _setAttribute('x', value);
  num get x => _getAttribute('x');

  void set y(num value) => _setAttribute('y', value);
  num get y => _getAttribute('y');

  void set stroke(String value) => _setAttribute('stroke', value);
  String get stroke => _getAttribute('stroke');

  void set strokeWidth(num value) => _setAttribute('stroke-width', value);
  num get strokeWidth => _getAttribute('strokeWidth');

  void set strokeOpacity(num value) => _setAttribute('stroke-opacity', value);
  num get strokeOpacity => _getAttribute('stroke-opacity');

  void set fill(String value) => _setAttribute('fill', value);
  String get fill => _getAttribute('fill');
}