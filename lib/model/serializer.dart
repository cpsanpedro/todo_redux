import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:todo_redux/model/model.dart';

import '../view_model/view_model.dart';

part 'serializer.g.dart';

@SerializersFor([ToDoItem, AppState, ToDoViewModel])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
