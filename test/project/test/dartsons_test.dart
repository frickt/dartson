import 'package:dartson/dartson.dart';
import 'package:test/test.dart';
import '../lib/mymodels.dart';

void main() {

  test('serialize: model class test', () {
    var dson = new Dartson.JSON();
    Model model = new Model();
    model.name = "test";
    model.renamed = "renamed";
    ModelChild modelChild = new ModelChild();
    modelChild.name = "child";
    modelChild.timeline = 4;
    model.children.add(modelChild);
    expect(dson.encode(model), '{"name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}]}');
  });

  test('deserialize: model class test', () {
    var dson = new Dartson.JSON();
    Model model = dson.decode('{"name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}]}',new Model());
    expect(model.name ,"test");
    expect(model.renamed, "renamed");
    ModelChild modelChild = model.children.first;
    expect(modelChild.name , "child");
    expect(modelChild.timeline , 4);
  });

  test('serialize: subclass of Model class test', () {
    var dson = new Dartson.JSON();
    SubModel model = new SubModel();
    model.age = 32;
    model.name = "test";
    model.renamed = "renamed";
    ModelChild modelChild = new ModelChild();
    modelChild.name = "child";
    modelChild.timeline = 4;
    model.children.add(modelChild);
    expect(dson.encode(model), '{"name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}],"age":32}');
  });

  test('deserialize: subclass json string to superclass class', () {
    var dson = new Dartson.JSON();
    Model model = dson.decode('{"name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}],"age":32}',new Model());
    expect(model.name ,"test");
    expect(model.renamed, "renamed");
    ModelChild modelChild = model.children.first;
    expect(modelChild.name , "child");
    expect(modelChild.timeline , 4);
  });

  test('deserialize: subclass json string to subclass class', () {
    var dson = new Dartson.JSON();
    SubModel model = dson.decode('{"name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}],"age":32}',new SubModel());
    expect(model.age , 32);
    expect(model.name ,"test");
    expect(model.renamed, "renamed");
    ModelChild modelChild = model.children.first;
    expect(modelChild.name , "child");
    expect(modelChild.timeline , 4);
  });

  test('deserialize: subclass json from modelFactory', () {
    var dson = new Dartson.JSON();
    var jsonString = '{"@class":"SubModel","name":"test","wrong":null,"other":"renamed","children":[{"name":"child","timeline":4}],"age":32}';
    SubModel model = dson.decodeFromEntityMapper(jsonString, new ModelFactory(), "@class");
    expect(model.name ,"test");
    expect(model.renamed, "renamed");
    ModelChild modelChild = model.children.first;
    expect(modelChild.name , "child");
    expect(modelChild.timeline , 4);
  });

}