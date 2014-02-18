part of smartcanvas;

abstract class _ICanvasImpl extends _INodeImpl {
  DOM.Element _container;
  DOM.Element _element;
  Position _pointerPositioin;

  _ICanvasImpl(containerId, Map<String, dynamic> attrs): super(attrs) {
    this._element = _createElement();
    this._container = DOM.querySelector(containerId);
    if (this._container == null) {
      throw containerId + " doesn't exit";
    }
    this._container.nodes.add(this._element);

    this._element.onMouseDown.listen(_setPointerPosition);
    this._element.onMouseMove.listen(_setPointerPosition);
    this._element.onMouseUp.listen(_setPointerPosition);
    this._element.onMouseEnter.listen(_setPointerPosition);
    this._element.onMouseLeave.listen(_setPointerPosition);
  }

  DOM.Element _createElement();

  /**
   * Add a node to canvas
   */
  void appendChild(_INodeImpl node);

  void _setPointerPosition(e);

  Position getPointerPosition();
}