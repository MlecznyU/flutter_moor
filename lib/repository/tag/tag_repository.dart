import 'dart:async';

import 'package:fluttermoor/data/moor_database.dart';
import 'package:fluttermoor/data/tag/tags_dao.dart';
import 'package:moor_flutter/moor_flutter.dart';

class TagRepository {
  final TagDao _tagDao;

  TagRepository(this._tagDao);

  Stream<List<Tag>> observeAllTags() => _tagDao.watchTags();

  Future<void> addNewTag(Insertable<Tag> tag) => _tagDao.insertTag(tag);
}
