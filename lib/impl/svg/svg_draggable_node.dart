part of smartcanvas;

class _SvgDraggableNode extends _SvgNode implements _IDraggable {
  bool _dragging;
  Position _dragOffset;

  _SvgDraggableNode(_ICanvasImpl canvas, Map<String, dynamic> attrs) : super(canvas, attrs) {

    if (_getAttribute('draggable') == true) {
      _listenMouseDown();
    }
  }

  void _listenMouseDown() {
    _element.onMouseDown.listen(_onMouseDown);
  }

  Position _getDragOffest() {
    var pointerPosition = this._canvas.getPointerPosition();
    var x, y;
    x = pointerPosition.x - (this._element as SVG.GraphicsElement).getCtm().e;
    y = pointerPosition.y - (this._element as SVG.GraphicsElement).getCtm().f;
    return new Position(x, y);
  }

  void _registerDragEvents() {
    this._canvas._element.onMouseDown.listen(dragStart).resume();
    this._canvas._element.onMouseUp.listen(dragEnd).resume();
  }

  void _unregisterDragEvents() {
    this._canvas._element.onMouseDown.listen(dragStart).cancel();
    this._canvas._element.onMouseUp.listen(dragEnd).cancel();
  }

  void _translate(num x, num y) {
    this._element.setAttribute('transform', 'translate($x, $y)');
  }
}