import 'dart:html';
import '../lib/smartcanvas.dart';

void main() {
  Canvas canvas = new Canvas('#smartCanvas', 'svg', {
      'width': 600,
      'height': 600,
      'draggable': true
    });

    Circle circle = new Circle({
      'x': 50,
      'y': 50,
      'r': 40,
    'stroke': 'green',
//    'strokeWidth': 4,
      'fill': 'yellow',
//      'draggable': true
    });

    Rect rect = new Rect({
      'x': 50,
      'y': 50,
      'width': 40,
      'height': 40,
      'stroke': 'red',
      'strokeWidth': 2,
//      'draggable': true
    });

    Ellipse ellipse = new Ellipse({
      'x': 300,
      'y': 200,
      'rx': 100,
      'ry': 50,
      'fill': 'green',
      'stroke': 'purple',
    });

    Node line = new Line({
      'x1': 100,
      'y1': 100,
      'x2': 150,
      'y2': 150,
      'stroke': 'powderblue',
      'stroke-width': 4
    });

    Group g = new Group({
      'draggable': true,
    });
    g.add(circle);
    g.add(rect);

//  canvas.add(circle);
    canvas.add(g);
//  canvas.add(rect);
    canvas.add(ellipse);
    canvas.add(line);
}
