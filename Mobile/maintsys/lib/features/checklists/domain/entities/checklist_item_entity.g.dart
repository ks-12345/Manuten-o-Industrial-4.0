// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_item_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChecklistItemEntityCollection on Isar {
  IsarCollection<ChecklistItemEntity> get checklistItemEntitys =>
      this.collection();
}

const ChecklistItemEntitySchema = CollectionSchema(
  name: r'ChecklistItemEntity',
  id: -1126511544517556342,
  properties: {
    r'answer': PropertySchema(id: 0, name: r'answer', type: IsarType.string),
    r'answerType': PropertySchema(
      id: 1,
      name: r'answerType',
      type: IsarType.byte,
      enumMap: _ChecklistItemEntityanswerTypeEnumValueMap,
    ),
    r'checklistLocalId': PropertySchema(
      id: 2,
      name: r'checklistLocalId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isRequired': PropertySchema(
      id: 4,
      name: r'isRequired',
      type: IsarType.bool,
    ),
    r'observation': PropertySchema(
      id: 5,
      name: r'observation',
      type: IsarType.string,
    ),
    r'occurrenceLocalId': PropertySchema(
      id: 6,
      name: r'occurrenceLocalId',
      type: IsarType.long,
    ),
    r'photoPath': PropertySchema(
      id: 7,
      name: r'photoPath',
      type: IsarType.string,
    ),
    r'question': PropertySchema(
      id: 8,
      name: r'question',
      type: IsarType.string,
    ),
    r'remoteId': PropertySchema(
      id: 9,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 10,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _ChecklistItemEntitysyncStatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 11,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _checklistItemEntityEstimateSize,
  serialize: _checklistItemEntitySerialize,
  deserialize: _checklistItemEntityDeserialize,
  deserializeProp: _checklistItemEntityDeserializeProp,
  idName: r'localId',
  indexes: {
    r'remoteId': IndexSchema(
      id: 6301175856541681032,
      name: r'remoteId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'remoteId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
    r'checklistLocalId': IndexSchema(
      id: -6466217690303692992,
      name: r'checklistLocalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'checklistLocalId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _checklistItemEntityGetId,
  getLinks: _checklistItemEntityGetLinks,
  attach: _checklistItemEntityAttach,
  version: '3.1.0+1',
);

int _checklistItemEntityEstimateSize(
  ChecklistItemEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.answer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.observation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.photoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.question.length * 3;
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _checklistItemEntitySerialize(
  ChecklistItemEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.answer);
  writer.writeByte(offsets[1], object.answerType.index);
  writer.writeLong(offsets[2], object.checklistLocalId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeBool(offsets[4], object.isRequired);
  writer.writeString(offsets[5], object.observation);
  writer.writeLong(offsets[6], object.occurrenceLocalId);
  writer.writeString(offsets[7], object.photoPath);
  writer.writeString(offsets[8], object.question);
  writer.writeString(offsets[9], object.remoteId);
  writer.writeByte(offsets[10], object.syncStatus.index);
  writer.writeDateTime(offsets[11], object.updatedAt);
}

ChecklistItemEntity _checklistItemEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChecklistItemEntity(
    answer: reader.readStringOrNull(offsets[0]),
    answerType:
        _ChecklistItemEntityanswerTypeValueEnumMap[reader.readByteOrNull(
          offsets[1],
        )] ??
        ChecklistAnswerType.okProblem,
    checklistLocalId: reader.readLong(offsets[2]),
    isRequired: reader.readBoolOrNull(offsets[4]) ?? true,
    localId: id,
    observation: reader.readStringOrNull(offsets[5]),
    occurrenceLocalId: reader.readLongOrNull(offsets[6]),
    photoPath: reader.readStringOrNull(offsets[7]),
    question: reader.readString(offsets[8]),
    remoteId: reader.readStringOrNull(offsets[9]),
    syncStatus:
        _ChecklistItemEntitysyncStatusValueEnumMap[reader.readByteOrNull(
          offsets[10],
        )] ??
        SyncStatus.pending,
  );
  object.createdAt = reader.readDateTime(offsets[3]);
  object.updatedAt = reader.readDateTime(offsets[11]);
  return object;
}

P _checklistItemEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (_ChecklistItemEntityanswerTypeValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              ChecklistAnswerType.okProblem)
          as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (_ChecklistItemEntitysyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.pending)
          as P;
    case 11:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChecklistItemEntityanswerTypeEnumValueMap = {
  'yesNo': 0,
  'okProblem': 1,
  'text': 2,
  'observation': 3,
  'photo': 4,
};
const _ChecklistItemEntityanswerTypeValueEnumMap = {
  0: ChecklistAnswerType.yesNo,
  1: ChecklistAnswerType.okProblem,
  2: ChecklistAnswerType.text,
  3: ChecklistAnswerType.observation,
  4: ChecklistAnswerType.photo,
};
const _ChecklistItemEntitysyncStatusEnumValueMap = {
  'pending': 0,
  'syncing': 1,
  'synced': 2,
  'error': 3,
};
const _ChecklistItemEntitysyncStatusValueEnumMap = {
  0: SyncStatus.pending,
  1: SyncStatus.syncing,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _checklistItemEntityGetId(ChecklistItemEntity object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _checklistItemEntityGetLinks(
  ChecklistItemEntity object,
) {
  return [];
}

void _checklistItemEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  ChecklistItemEntity object,
) {
  object.localId = id;
}

extension ChecklistItemEntityByIndex on IsarCollection<ChecklistItemEntity> {
  Future<ChecklistItemEntity?> getByRemoteId(String? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  ChecklistItemEntity? getByRemoteIdSync(String? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<ChecklistItemEntity?>> getAllByRemoteId(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<ChecklistItemEntity?> getAllByRemoteIdSync(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteId', values);
  }

  Future<int> deleteAllByRemoteId(List<String?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteId', values);
  }

  int deleteAllByRemoteIdSync(List<String?> remoteIdValues) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteId', values);
  }

  Future<Id> putByRemoteId(ChecklistItemEntity object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(ChecklistItemEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<ChecklistItemEntity> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(
    List<ChecklistItemEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension ChecklistItemEntityQueryWhereSort
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QWhere> {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhere>
  anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhere>
  anyChecklistLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'checklistLocalId'),
      );
    });
  }
}

extension ChecklistItemEntityQueryWhere
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QWhereClause> {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: localId, upper: localId),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  localIdNotEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  localIdBetween(
    Id lowerLocalId,
    Id upperLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerLocalId,
          includeLower: includeLower,
          upper: upperLocalId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'remoteId',
          lower: [null],
          includeLower: false,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  remoteIdNotEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [remoteId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'remoteId',
                lower: [],
                upper: [remoteId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  checklistLocalIdEqualTo(int checklistLocalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'checklistLocalId',
          value: [checklistLocalId],
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  checklistLocalIdNotEqualTo(int checklistLocalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checklistLocalId',
                lower: [],
                upper: [checklistLocalId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checklistLocalId',
                lower: [checklistLocalId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checklistLocalId',
                lower: [checklistLocalId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'checklistLocalId',
                lower: [],
                upper: [checklistLocalId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  checklistLocalIdGreaterThan(int checklistLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checklistLocalId',
          lower: [checklistLocalId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  checklistLocalIdLessThan(int checklistLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checklistLocalId',
          lower: [],
          upper: [checklistLocalId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterWhereClause>
  checklistLocalIdBetween(
    int lowerChecklistLocalId,
    int upperChecklistLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'checklistLocalId',
          lower: [lowerChecklistLocalId],
          includeLower: includeLower,
          upper: [upperChecklistLocalId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ChecklistItemEntityQueryFilter
    on
        QueryBuilder<
          ChecklistItemEntity,
          ChecklistItemEntity,
          QFilterCondition
        > {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'answer'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'answer'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'answer',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'answer',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'answer',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'answer', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'answer', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerTypeEqualTo(ChecklistAnswerType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'answerType', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerTypeGreaterThan(ChecklistAnswerType value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'answerType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerTypeLessThan(ChecklistAnswerType value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'answerType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  answerTypeBetween(
    ChecklistAnswerType lower,
    ChecklistAnswerType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'answerType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  checklistLocalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'checklistLocalId', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  checklistLocalIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'checklistLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  checklistLocalIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'checklistLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  checklistLocalIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'checklistLocalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  isRequiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isRequired', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  localIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'localId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  localIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'localId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  localIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'localId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'observation'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'observation'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'observation',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'observation',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'observation',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'observation', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  observationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'observation', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'occurrenceLocalId'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'occurrenceLocalId'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceLocalId', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'occurrenceLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'occurrenceLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  occurrenceLocalIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'occurrenceLocalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'photoPath'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'photoPath'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'photoPath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'photoPath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'photoPath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'photoPath', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  photoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'photoPath', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'question',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'question',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'question',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'question', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'question', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'remoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'remoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'remoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  syncStatusGreaterThan(SyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  syncStatusLessThan(SyncStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'syncStatus',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'syncStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  updatedAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  updatedAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'updatedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterFilterCondition>
  updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'updatedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ChecklistItemEntityQueryObject
    on
        QueryBuilder<
          ChecklistItemEntity,
          ChecklistItemEntity,
          QFilterCondition
        > {}

extension ChecklistItemEntityQueryLinks
    on
        QueryBuilder<
          ChecklistItemEntity,
          ChecklistItemEntity,
          QFilterCondition
        > {}

extension ChecklistItemEntityQuerySortBy
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QSortBy> {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByAnswerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerType', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByAnswerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerType', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByChecklistLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistLocalId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByChecklistLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistLocalId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByObservation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observation', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByObservationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observation', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ChecklistItemEntityQuerySortThenBy
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QSortThenBy> {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answer', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByAnswerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerType', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByAnswerTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answerType', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByChecklistLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistLocalId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByChecklistLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistLocalId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByObservation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observation', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByObservationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'observation', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension ChecklistItemEntityQueryWhereDistinct
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct> {
  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByAnswer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByAnswerType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answerType');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByChecklistLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checklistLocalId');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRequired');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByObservation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'observation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occurrenceLocalId');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByPhotoPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension ChecklistItemEntityQueryProperty
    on QueryBuilder<ChecklistItemEntity, ChecklistItemEntity, QQueryProperty> {
  QueryBuilder<ChecklistItemEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<ChecklistItemEntity, String?, QQueryOperations>
  answerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answer');
    });
  }

  QueryBuilder<ChecklistItemEntity, ChecklistAnswerType, QQueryOperations>
  answerTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answerType');
    });
  }

  QueryBuilder<ChecklistItemEntity, int, QQueryOperations>
  checklistLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistLocalId');
    });
  }

  QueryBuilder<ChecklistItemEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ChecklistItemEntity, bool, QQueryOperations>
  isRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRequired');
    });
  }

  QueryBuilder<ChecklistItemEntity, String?, QQueryOperations>
  observationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'observation');
    });
  }

  QueryBuilder<ChecklistItemEntity, int?, QQueryOperations>
  occurrenceLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceLocalId');
    });
  }

  QueryBuilder<ChecklistItemEntity, String?, QQueryOperations>
  photoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPath');
    });
  }

  QueryBuilder<ChecklistItemEntity, String, QQueryOperations>
  questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<ChecklistItemEntity, String?, QQueryOperations>
  remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<ChecklistItemEntity, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<ChecklistItemEntity, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
