part of smartcanvas;

abstract class NodeImpl extends NodeBase {
//  Stage _stage;
  NodeImpl parent;
  Node _shell;
  TransformMatrix _transformMatrix;

  NodeImpl(this._shell): super() {
    this._attrs = _shell._attrs;
    this._transformMatrix = _shell._transformMatrix;
    this._eventListeners.addAll(_shell._eventListeners);
  }

  String get type;

  void remove();
  void translate();

  NodeImpl clone() {
    ClassMirror cm = reflectClass(this.runtimeType);
    NodeImpl clone = cm.newInstance(const Symbol(EMPTY), [_attrs]).reflectee;
    return clone;
  }

//  void set stage(Stage stage) { _stage = stage; }
//  Stage get stage => _stage;

  Node get shell => _shell;

  LayerImpl get layer {
    NodeImpl parent = this.parent;
    while(parent != null && parent.parent != null) {
      parent = parent.parent;
    }
    return (parent is LayerImpl) ? parent : null;
  }

  Stage get stage {
    LayerImpl layer = this.layer;
    if (layer != null) {
      return (layer.shell as Layer)._stage;
    }
    return null;
  }

  num get width => getAttribute(WIDTH);
  num get height => getAttribute(HEIGHT);
  bool get isDragging;
  num get absolutePosition;
  TransformMatrix get transformMatrix => _transformMatrix;
}