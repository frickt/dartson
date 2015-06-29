library dartson_test.mymodels;

import 'package:dartson/dartson.dart';
import 'package:dartson/entity_mapper.dart';

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

class ModelFactory extends EntityMapperFactory{
  Object getInstance(String modelName){
    switch (modelName) {
      case 'SubModel':
        return new SubModel();
      case 'Model':
        return new Model();
      default:
        throw new Exception("Unable to find Subclass: " + modelName);
    }
  }
}
