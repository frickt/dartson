library dartson_test.mymodels;

import 'package:dartson/dartson.dart';
import 'package:dartson/entity_mapper.dart';
import 'package:dartson/type_transformer.dart';

@Entity()
class Model {
  String name;
  bool wrong;

  @Property(ignore: true)
  int ignored;

  @Property(name: "other")
  String renamed;

  List<ModelChild> children = new List();

  DateTime created;
}

@Entity()
class ModelChild {
  String name;
  int timeline;
}

@Entity()
class SubModel extends Model{

  @Property(name:"age")
  int age;
}

class ModelTransformer<Model> extends TypeTransformer{

  dynamic encode(Object value) {
    var dson = new Dartson.JSON();
    return dson.encode(value);
  }

  Model decode(dynamic value) {
    var dson = new Dartson.JSON();
    dson.addTransformer(new ModelTransformer(), Model);
    if (value is Map) {
      switch (value["@class"]) {
        case 'SubModel':
          return dson.map(value, new SubModel());
        case 'Model':
          return dson.map(value, new Model());
        default:
          throw new Exception("Unable to map SubClass: " + value["@class"]);
      }
    }
    throw new Exception("Unable to map SubClass: value is not of Type Map");
  }
}