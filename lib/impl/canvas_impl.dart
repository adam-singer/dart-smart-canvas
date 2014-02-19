part of smartcanvas;

abstract class CanvasImpl extends NodeImpl implements Container<NodeImpl>{
  DOM.Element _container;
  DOM.Element _element;

  CanvasImpl(this._container, Canvas shell): super(shell) {
    this._element = createElement();
    if (this._container == null) {
      throw "container doesn't exit";
    }
    this._container.nodes.add(this._element);

    this._element.onMouseDown.listen(setPointerPosition);
    this._element.onMouseMove.listen(setPointerPosition);
    this._element.onMouseUp.listen(setPointerPosition);
    this._element.onMouseEnter.listen(setPointerPosition);
    this._element.onMouseLeave.listen(setPointerPosition);
  }

  DOM.Element createElement();

  /**
   * Add a node to canvas
   */
  void appendChild(NodeImpl node);

  void setPointerPosition(e);

  Position getPointerPosition();

  DOM.Element get element => _element;
}