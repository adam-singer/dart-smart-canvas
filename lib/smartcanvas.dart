library smartcanvas;

import 'dart:html' as DOM;
import 'dart:svg' as SVG;

part 'node.dart';
part 'collection.dart';
part 'canvas.dart';

part 'utils/nodebase.dart';
part 'utils/position.dart';

part 'shape/circle.dart';
part 'shape/ellipse.dart';
part 'shape/group.dart';
part 'shape/rect.dart';
part 'shape/line.dart';

part 'impl/i_canvas_impl.dart';
part 'impl/i_node_impl.dart';
part 'impl/i_group_impl.dart';
part 'impl/i_draggable.dart';

part 'impl/svg/svg_canvas.dart';
part 'impl/svg/svg_node.dart';
part 'impl/svg/svg_draggable_node.dart';

part 'impl/svg/shapes/circle.dart';
part 'impl/svg/shapes/rect.dart';
part 'impl/svg/shapes/ellipse.dart';
part 'impl/svg/shapes/line.dart';
part 'impl/svg/shapes/group.dart';