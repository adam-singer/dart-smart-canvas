part of smartcanvas;

class Line extends Node {
  Line(Map<String, dynamic> config): super(config) {}

  _INodeImpl _createSvgImpl(_ICanvasImpl canvas) {
    return new SvgLine(canvas, _attrs);
  }

  _INodeImpl _createCanvasImpl(_ICanvasImpl canvas) {
    throw 'Not Implemented';
  }
}