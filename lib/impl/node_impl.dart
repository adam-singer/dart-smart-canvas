part of smartcanvas;

abstract class NodeImpl extends NodeBase {
  CanvasImpl canvas = null;
  NodeImpl parent = null;
  Node shell = null;

  NodeImpl(this.shell): super() {
    this.canvas = shell._canvas;
    this._attrs = this.shell._attrs;
    this._eventListeners = this.shell._eventListeners;
  }

  void on(String events, Function handler, [String id]) {}

  String get type;

  void remove();
}