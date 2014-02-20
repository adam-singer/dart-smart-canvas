part of smartcanvas.canvas;

class CanvasCanvas extends CanvasImpl {

  List<CanvasNode> _children = new List<CanvasNode>();
  Position _pointerPosition;

  CanvasCanvas(DOM.Element container, Node shell): super(container, shell) {}

  String get type => canvas;

  List<CanvasNode> get children => _children;

  DOM.Element createElement() {
    throw notImplemented;
  }



  void setPointerPosition(DOM.MouseEvent e) {
    throw notImplemented;
  }

  Position getPointerPosition() { return _pointerPosition; }

  void remove() {
    throw notImplemented;
  }

  void add(CanvasNode node) {
    throw notImplemented;
  }

  void removeChild(CanvasNode node) {
    throw notImplemented;
  }

  void removeChildAt(int index) {
    throw notImplemented;
  }

  void insert(int index, CanvasNode node) {
    throw notImplemented;
  }


}