library smartcanvas;

// external dependencies
import 'dart:html' as DOM;
@MirrorsUsed(symbols: const ['Layer', 'Group', 'Circle', 'Ellipse', 'Line', 'Rect'])
import 'dart:mirrors';

import 'impl/svg/svg.dart';
import 'impl/canvas/canvas.dart';

part 'nodebase.dart';
part 'node.dart';
part 'container.dart';
part 'stage.dart';
part 'group.dart';
part 'layer.dart';
part 'reflectionLayer.dart';

part 'utils/position.dart';
part 'utils/constants.dart';

part 'shape/circle.dart';
part 'shape/ellipse.dart';
part 'shape/rect.dart';
part 'shape/line.dart';

//part 'impl/stage_impl.dart';
part 'impl/node_impl.dart';
part 'impl/layer_impl.dart';
part 'impl/reflection_node.dart';