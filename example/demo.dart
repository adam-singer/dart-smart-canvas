import 'dart:html' as dom hide Text;
import '../lib/smartcanvas.dart';

void main() {
  dom.Element container = dom.document.querySelector('#smartCanvas');
  Stage stage = new Stage(container, 'svg', {
      'width': 600,
      'height': 600
    });

    Circle circle = new Circle({
      'x': 50,
      'y': 50,
      'r': 40,
      'stroke': 'green',
      'fill': 'yellow',
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
    });

    Ellipse ellipse = new Ellipse({
      'x': 300,
      'y': 200,
      'rx': 100,
      'ry': 50,
      'fill': 'green',
      'stroke': 'purple',
      'listening': true,
      'draggable': true
    });
//    ellipse.on(mousedown, (e){ ellipse.moveToTop(); });

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
//    g.on('mousedown', (e) {
//      print('group mousedown');}
//    );
//    circle.on('click', (e) {
//      print ("circle clicked");
//    });
//    g.on(mousemove, (e) => print('....'));
//    g.on(click, (e) => print('group clicked'));
//    g.on(dblclick, (e) => print('group double clicked'));

//  canvas.add(circle);
    stage.add(g);
//    int i = 0;
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
//    g.on(dblclick, (e) => print('group double clicked'));

//  canvas.add(rect);
//    stage.add(ellipse);
    stage.add(line);

//    Circle c2 = new Circle({
//      'x': 100,
//      'y': 100,
//      'r': 50,
//      'fill': 'red',
//      'listening': true,
//      'draggable': true
//    });
//
//    Layer layer2 = new Layer(svg, {
//      'id': 'two'
//    });
//
//    c2.on(mousedown, (e) => print('c2 clicked'));
//    layer2.add(c2);
//    stage.add(layer2);

    stage.add(ellipse);
//
//    var txt = new Text({
//      'text': 'A',
//      'x': 100,
//      'y': 100,
//      'fill': 'red',
//      'font-size': 32
//    });
//
//    stage.add(txt);

//    Polygon p = new Polygon({
//      'points': "220,10 300,210 170,250 123,234",
//      'fill': 'lime',
//      'draggable': true
//    });
//    layer2.add(p);

//    Path path = new Path({
//      'd': "M150 0 L75 200 L225 200 Z",
//      'draggable': true
//    });
//    stage.add(path);
//
//    p.x = p.x + 200;
//    p.y = p.y + 100;

//    g.x = 100;

//    var c = c2.clone({'fill': 'red'});
//    canvas2.add(c);
//    Layer layer = new Layer({
//      'id': 'addOnLayer',
//    });
//    layer.add(c2);
//    canvas.add(layer);
//    canvas.defaultLayer.moveUp();
////    c2.moveTo(canvas.defaultLayer);
//    layer.draggalbe = true;
}
