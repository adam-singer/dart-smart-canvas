part of smartcanvas;

abstract class _IDraggable {
  bool _dragging;
  Position _dragOffset;
  _ICanvasImpl _canvas;

  void _onMouseDown(DOM.MouseEvent e) {
    e.preventDefault();
    this._dragging = true;

    this._dragOffset = this._getDragOffest();

//    var pointerPosition = this._canvas.getPointerPosition();
//    this._dragOffsetX = pointerPosition.x - (this._element as SVG.GraphicsElement).getCtm().e;
//    this._dragOffsetY = pointerPosition.y - (this._element as SVG.GraphicsElement).getCtm().f;

    this._registerDragEvents();
//    this._canvas._element.onMouseMove.listen(dragStart).resume();
//    this._canvas._element.onMouseUp.listen(dragEnd).resume();
  }

  void dragStart(DOM.MouseEvent e) {
    e.preventDefault();
    if (this._dragging) {
      var pointerPosition = this._canvas.getPointerPosition();
      num x = pointerPosition.x - this._dragOffset.x;
      num y = pointerPosition.y - this._dragOffset.y;
      this._translate(x, y);
//      this._element.setAttribute('transform', 'translate($x, $y)');
    }
  }

  void dragEnd(DOM.MouseEvent e) {
    e.preventDefault();
    this._dragging = false;
    _unregisterDragEvents();

//    this._canvas._element.onMouseDown.listen(dragStart).cancel();
//    this._canvas._element.onMouseUp.listen(dragEnd).cancel();
  }

  Position _getDragOffest();
  void _registerDragEvents();
  void _unregisterDragEvents();

  void _translate(num x, num y);
}