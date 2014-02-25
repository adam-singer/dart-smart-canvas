import 'dart:html';
import '../lib/smartcanvas.dart';

void main() {
  Element container = document.querySelector('#smartCanvas');
  Canvas canvas = new Canvas(container, 'svg', {
      'width': 600,
      'height': 600,
      'id': 'one'
    });

    Circle circle = new Circle({
      'x': 50,
      'y': 50,
      'r': 40,
    'stroke': 'green',
//    'strokeWidth': 4,
      'fill': 'yellow',
//      'draggable': true,
      'name': 'circle',
      'listening': true
    });

    Rect rect = new Rect({
      'x': 30,
      'y': 30,
      'width': 40,
      'height': 40,
      'stroke': 'red',
      'strokeWidth': 2,
//      'draggable': true,
      'name': 'rect'
    });

    Ellipse ellipse = new Ellipse({
      'x': 300,
      'y': 200,
      'rx': 100,
      'ry': 50,
      'fill': 'green',
      'stroke': 'purple',
      'listening': true
    });
    ellipse.on(mousedown, (e){ ellipse.moveToTop(); });

    Line line = new Line({
      'x1': 100,
      'y1': 100,
      'x2': 150,
      'y2': 150,
      'stroke': 'powderblue',
      'stroke-width': 4
    });

    Group g = new Group({
      'draggable': true,
      'listening': true,
      'name': 'group'
    });
    g.add(circle);
    g.add(rect);
//    g.on('mousedown', (e) => print('group clicked'));
//    g.on(mousemove, (e) => print('....'));

//  canvas.add(circle);
    canvas.add(g);
    int i = 0;
//    g.on('mousedown', (e){
//      if (i < 2) {
//        g.moveUp();
//        ++i;
//      } else {
//        g.moveDown();
//        --i;
//      }
//
//    });
    g.on(click, (e) => print('group clicked'));
    g.on(dblclick, (e) => print('group double clicked'));

//  canvas.add(rect);
    canvas.add(ellipse);
    canvas.add(line);

    Circle c2 = new Circle({
      'x': 100,
      'y': 100,
      'r': 50,
      'fill': 'red',
      'listening': true,
//      'draggable': true
    });

//    Canvas canvas2 = new Canvas(container, svg, {
//      'width': 600,
//      'height': 600,
//      'id': 'two'
//    });
//
//    c2.on(click, (e) => print('c2 clicked'));
//    canvas2.add(c2);

    Layer layer = new Layer({
      'id': 'addOnLayer',
    });
    layer.add(c2);
    canvas.add(layer);
    canvas.defaultLayer.moveUp();
//    c2.moveTo(canvas.defaultLayer);
    layer.draggalbe = true;
}
