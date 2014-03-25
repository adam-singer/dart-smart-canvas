part of smartcanvas.svg;

abstract class SvgNode extends NodeImpl {
  SVG.SvgElement _element;

  bool _dragging = false;
  bool _dragStarted = false;
  num _dragOffsetX;
  num _dragOffsetY;

  Set<String> _classNames = new Set<String>();

  SvgNode(Node shell) : super(shell) {
//    this.stage = shell.stage;
    _setClassName();
    _element = _createElement();
    _setElementAttributes();
    _setElementStyles();
//    _applyOffset();

    if (getAttribute('draggable') == true) {
      _startDragHandling();
    }

    if(getAttribute('listening') == true) {
      this.eventListeners.forEach((k, v) {
        _registerDOMEvent(k);
      });
    }

    this.shell
    .on('draggableChanged', (oldValue, newValue) {
      if (newValue) {
        _startDragHandling();
      } else {
        _stopDragHandling();
      }
    })
    .on('*Changed', _handleAttrChange);
  }

  String get type => svg;

  SVG.SvgElement get element => _element;

  SVG.SvgElement _createElement();

  void _setClassName() {
    _classNames.add(_nodeName);
    if (hasAttribute('class')) {
      _classNames.add(getAttribute('class'));
    }
    setAttribute('class', _classNames.join(' '));
  }

  void _startDragHandling() {
    _element.onMouseDown.listen(_dragStart).resume();
  }

  void _stopDragHandling() {
    _element.onMouseDown.listen(_dragStart).cancel();
  }

  Set<String> _getElementAttributeNames() {
    return new Set<String>.from(['id', 'class']);
  }

  Map<String, dynamic> _getStyles() {
    return _createStyles(_getStyleNames());
  }

  List<String> _getStyleNames() {
    return ['stroke', 'stroke-width', 'stroke-opacity',
            'fill', 'opacity'];
  }

  Map<String, dynamic> _createStyles(List<String> styleNames) {
    var rt = new Map<String, dynamic>();
    styleNames.forEach((name) {
      if (hasAttribute(name)) {
        rt[name] = getAttribute(name);
      }
    });
    return rt;
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

  void _setElementStyles() {
    Map<String, dynamic> styles = _getStyles();
    List<String> strStyles = [];
    styles.forEach((k, v) {
      if (v != null) {
        strStyles.add(k + ':' + '$v');
      }
    });
    if (styles.length > 0) {
      _element.setAttribute('style', strStyles.join(';'));
    }
  }

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

    var pointerPosition = this.stage.pointerPosition;
    this._dragOffsetX = pointerPosition.x - (this._element as SVG.GraphicsElement).getCtm().e;
    this._dragOffsetY = pointerPosition.y - (this._element as SVG.GraphicsElement).getCtm().f;

    this.stage.element.onMouseMove.listen(_dragMove).resume();
    this.stage.element.onMouseUp.listen(_dragEnd).resume();
  }

  void _dragMove(DOM.MouseEvent e) {
    if (_dragging) {
      e.preventDefault();
      if (!_dragStarted) {
        fire('dragstart', e);
        _dragStarted = true;
      }
      var pointerPosition = this.stage.pointerPosition;
      num x = pointerPosition.x - this._dragOffsetX;
      num y = pointerPosition.y - this._dragOffsetY;
      this._element.setAttribute('transform', 'translate($x, $y)');
      fire('dragmove', e);
    }
  }

  void _dragEnd(DOM.MouseEvent e) {
    e.preventDefault();
    _dragging = false;
    this.stage.element.onMouseMove.listen(_dragMove).cancel();
    this.stage.element.onMouseUp.listen(_dragEnd).cancel();
  }

  void _onMouseMove(DOM.MouseEvent e) {
    if (!_dragging) {
      fire('mousemove', e);
      var name = getAttribute('name');
      print (name + ' mousemove');
    }
  }

  NodeBase on(String event, Function handler, [String id]) {
    _registerDOMEvent(event);
    return this;
  }

  void _handleAttrChange(String attr, oldValue, newValue) {
    // apply translate to position changes
    if (attr == 'x' || attr == 'y') {
      if (oldValue == null) {
        oldValue = 0;
      }
      num diff = newValue - oldValue;

      if (attr == 'x') {
        _element.setAttribute('transform', 'translate($diff, ${getAttribute('y', 0)})');
      } else {
        _element.setAttribute('transform', 'translate(${getAttribute('x', 0)}, $diff)');
      }
    } else if (_isStyle(attr)) {
      _setElementStyles();
    } else {
      // apply attribute change to svg element
      var elementAttr = _mapToElementAttr(attr);
      if (elementAttr != null) {
        _element.setAttribute(elementAttr, '$newValue');
      }
    }
  }

  bool _isStyle(String attr) {
    return _getStyleNames().contains(attr);
  }

  String _mapToElementAttr(String attr) {
    if (_getElementAttributeNames().contains(attr)) {
      return attr;
    }
    return null;
  }

  String get _nodeName;
}