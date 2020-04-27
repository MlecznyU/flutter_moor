import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/model_tags.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'tags_dao.g.dart';

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> watchTags() => select(tags).watch();
  Future insertTag(Insertable<Tag> task)=> into(tags).insert(task);
}
