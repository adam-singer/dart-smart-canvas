part of smartcanvas.canvas;

class CanvasNode extends NodeImpl {

  CanvasNode(Node shell): super(shell) {}

  void remove() {
//    _element.remove();
//    (parent as Container).children.remove(this);
//    parent = null;
    throw 'not implemented';
  }
  String get type => canvas;

}