part of smartcanvas;

class _ReflectionNode extends Node {
  Node _node;
  SvgNode _impl;
  DOM.Element _element;
  Stage _stage;

  _ReflectionNode(this._node): super() {
    _node._reflection = this;
  }

  NodeImpl _createSvgImpl() {
    assert(_node._impl != null);
    SvgNode impl = _node.reflect();
    impl.on('dragmove', _onDragMove);
    return impl;
  }

  NodeImpl _createCanvasImpl() {
    throw 'Reflection Node should alwyas on svg canvas';
  }

  void _onDragMove(DOM.MouseEvent e) {
    (_node._impl as SvgNode).element.setAttribute('transform', _impl.element.attributes['transform']);
  }
}