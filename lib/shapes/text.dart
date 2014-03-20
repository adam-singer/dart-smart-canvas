part of smartcanvas;

class Text extends Node {
  Text(Map<String, dynamic> config): super(config) {}

  NodeImpl _createSvgImpl() {
    return new SvgText(this);
  }

  NodeImpl _createCanvasImpl() {
    throw 'Not implemented';
  }

  void set text(String value) => setAttribute('text', value);
  String get text => getAttribute('text');

  num get width {
    num fontSize = getAttribute('font-size', 12);
    return fontSize * text.length;
  }

  num get height => getAttribute('font-size', 12);
}