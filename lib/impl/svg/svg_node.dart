part of smartcanvas.svg;

abstract class SvgNode extends NodeImpl {
  SVG.SvgElement _element;

  bool _dragging = false;
  bool _dragStarted = false;
  num _dragOffsetX;
  num _dragOffsetY;

  SvgNode(Node shell) : super(shell) {
    this.canvas = shell.canvas;
    _element = _createElement();
    _setElementAttributes();
//    _setStyles();

    if (getAttribute('draggable') == true) {
      _startDragHandling();
    }

    if(getAttribute('listening') == true) {
      this.eventListeners.forEach((k, v) {
        _registerDOMEvent(k);
      });
    }

    this.shell.on('draggableChanged', (oldValue, newValue) {
      if (newValue) {
        _startDragHandling();
      } else {
        _stopDragHandling();
      }
    });
  }

  String get type => svg;

  SVG.SvgElement get element => _element;

  SVG.SvgElement _createElement();

  void _startDragHandling() {
    _element.onMouseDown.listen(_dragStart).resume();
  }

  void _stopDragHandling() {
    _element.onMouseDown.listen(_dragStart).cancel();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'class', 'name', 'x', 'y', 'width',
                                 'height', 'stroke', 'stroke-width',
                                 'stroke-opacity', 'fill', 'opacity']);
  }

  void _setElementAttributes() {
    var attrs = _getElementAttributeNames();
    attrs.forEach(_setElementAttribute);
  }

  void _setElementAttribute(String attr) {
    var value = getAttribute(attr);
    if (value != null) {
      if (!(value is String) || !value.isEmpty) {
        _element.attributes[attr] = '$value';
      }
    }
  }

//  void _setStyles() {
//    String style = 'stroke:' + this.stroke
//        + ';stroke-width:' + '$this.strokeWidth'
//        + ';stroke-opacity:' + '$this.strokeOpacity'
//        + ';fill:' + this.fill;
//    _element.setAttribute('style', style);
//  }

  void remove() {
    _element.remove();
    (parent as Container).children.remove(this);
    parent = null;
  }

  void _registerDOMEvent(String event) {
    Function eventHandler = fireEvent(event);
    switch (event) {
      case 'mousedown':
        _element.onMouseDown.listen(eventHandler);
        break;
      case 'mouseup':
        _element.onMouseUp.listen(eventHandler);
        break;
      case 'mouseenter':
        _element.onMouseEnter.listen(eventHandler);
        break;
      case 'mouseleave':
        _element.onMouseLeave.listen(eventHandler);
        break;
      case 'mouseover':
        _element.onMouseOver.listen(eventHandler);
        break;
      case 'mouseout':
        _element.onMouseOut.listen(eventHandler);
        break;
      case 'mousemove':
        _element.onMouseMove.listen(_onMouseMove);
        break;
      case 'click':
        _element.onClick.listen(eventHandler);
        break;
      case 'dblclick':
        _element.onDoubleClick.listen(eventHandler);
        break;
     }
  }

  Function fireEvent(String event) {
    return (e) => fire(event, e);
  }

  void _dragStart(DOM.MouseEvent e) {
    e.preventDefault();
    this._dragging = true;

    var pointerPosition = this.canvas.getPointerPosition();
    this._dragOffsetX = pointerPosition.x - (this._element as SVG.GraphicsElement).getCtm().e;
    this._dragOffsetY = pointerPosition.y - (this._element as SVG.GraphicsElement).getCtm().f;

    this.canvas.element.onMouseMove.listen(_dragMove).resume();
    this.canvas.element.onMouseUp.listen(_dragEnd).resume();
  }

  void _dragMove(DOM.MouseEvent e) {
    if (_dragging) {
      e.preventDefault();
      if (!_dragStarted) {
        fire('dragstart', e);
        _dragStarted = true;
      }
      var pointerPosition = this.canvas.getPointerPosition();
      num x = pointerPosition.x - this._dragOffsetX;
      num y = pointerPosition.y - this._dragOffsetY;
      this._element.setAttribute('transform', 'translate($x, $y)');
    }
  }

  void _dragEnd(DOM.MouseEvent e) {
    e.preventDefault();
    _dragging = false;
    this.canvas.element.onMouseMove.listen(_dragMove).cancel();
    this.canvas.element.onMouseUp.listen(_dragEnd).cancel();
  }

  void _onMouseMove(DOM.MouseEvent e) {
    if (!_dragging) {
      fire('mousemove', e);
      var name = getAttribute('name');
      print (name + ' mousemove');
    }
  }

  void on(String event, Function handler, [String id]) {
    _registerDOMEvent(event);
  }
}