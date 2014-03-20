part of smartcanvas.canvas;

class CanvasNode extends NodeImpl {

  CanvasNode(Node shell): super(shell) {}

  void remove() {
    throw 'not implemented';
  }
  String get type => canvas;

}