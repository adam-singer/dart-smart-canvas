part of smartcanvas.canvas;

abstract class CanvasNode extends NodeImpl {

  CanvasNode(Node shell): super(shell) {}

  void remove() {
    throw ExpNotImplemented;
  }
  String get type => canvas;

}