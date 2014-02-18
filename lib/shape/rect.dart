part of smartcanvas;

class Rect extends Node {
  Rect(Map<String, dynamic> config): super(config) {}

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas) {
    return new SvgRect(canvas, _attrs);
  }

  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas) {
    throw 'Not implemented';
  }
}