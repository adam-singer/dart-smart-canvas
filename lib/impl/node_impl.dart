part of smartcanvas;

abstract class NodeImpl extends NodeBase {
  CanvasImpl _canvas = null;
  NodeImpl parent = null;
  Node shell = null;

  NodeImpl(this.shell): super() {
    this._canvas = shell._canvas;
    this._attrs = this.shell._attrs;
    this._eventListeners = this.shell._eventListeners;
  }

  String get type;

  void remove();

  void set canvas(CanvasImpl canvas) { _canvas = canvas; }
  CanvasImpl get canvas => _canvas;
}