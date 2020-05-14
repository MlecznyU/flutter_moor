import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/tag/model_tags.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'tags_dao.g.dart';

@UseDao(tables: [Tags])
class TagDao extends DatabaseAccessor<AppDatabase> with _$TagDaoMixin {
  final AppDatabase db;

  TagDao(this.db) : super(db);

  Stream<List<Tag>> watchTags() => select(tags).watch();

  Future insertTag(Insertable<Tag> tag) => into(tags).insert(tag);
}
