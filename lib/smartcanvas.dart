library smartcanvas;

// external dependencies
import 'dart:html' as DOM;
//import 'dart:svg' as SVG;
//import 'package:html5_dnd/html5_dnd.dart';

import 'impl/svg/svg.dart';

part 'nodebase.dart';
part 'node.dart';
part 'container.dart';
part 'canvas.dart';
part 'group.dart';

part 'utils/position.dart';

part 'shape/circle.dart';
part 'shape/ellipse.dart';
part 'shape/rect.dart';
part 'shape/line.dart';

part 'impl/canvas_impl.dart';
part 'impl/node_impl.dart';

//part 'impl/svg/svg_canvas.dart';
//part 'impl/svg/svg_node.dart';
//part 'impl/svg/svg_group.dart';

//part 'impl/svg/shapes/svg_circle.dart';
//part 'impl/svg/shapes/svg_rect.dart';
//part 'impl/svg/shapes/svg_ellipse.dart';
//part 'impl/svg/shapes/svg_line.dart';

const String mousemove = 'mousemove';
const String mousedown = 'mousedown';
const String mouseup = 'mouseup';
const String mouseetner = 'mouseenter';
const String mouseleave = 'mouseleave';
const String mouseover = 'mouseover';
const String mouseout = 'mouseout';
const String click = 'click';
const String dblclick = 'dblclick';
const String dragstart = 'dragstart';
const String dragmove = 'dragmove';
const String dragend = 'dragend';