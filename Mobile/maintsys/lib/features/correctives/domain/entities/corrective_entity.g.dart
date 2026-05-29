// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corrective_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCorrectiveEntityCollection on Isar {
  IsarCollection<CorrectiveEntity> get correctiveEntitys => this.collection();
}

const CorrectiveEntitySchema = CollectionSchema(
  name: r'CorrectiveEntity',
  id: 5498469238619735891,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'finalNotes': PropertySchema(
      id: 1,
      name: r'finalNotes',
      type: IsarType.string,
    ),
    r'finishedAt': PropertySchema(
      id: 2,
      name: r'finishedAt',
      type: IsarType.dateTime,
    ),
    r'occurrenceLocalId': PropertySchema(
      id: 3,
      name: r'occurrenceLocalId',
      type: IsarType.long,
    ),
    r'occurrenceRemoteId': PropertySchema(
      id: 4,
      name: r'occurrenceRemoteId',
      type: IsarType.string,
    ),
    r'partsReplacedJson': PropertySchema(
      id: 5,
      name: r'partsReplacedJson',
      type: IsarType.string,
    ),
    r'photos': PropertySchema(
      id: 6,
      name: r'photos',
      type: IsarType.stringList,
    ),
    r'remoteId': PropertySchema(
      id: 7,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'repairTimeMinutes': PropertySchema(
      id: 8,
      name: r'repairTimeMinutes',
      type: IsarType.long,
    ),
    r'solution': PropertySchema(
      id: 9,
      name: r'solution',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 10,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _CorrectiveEntitysyncStatusEnumValueMap,
    ),
    r'technicianId': PropertySchema(
      id: 11,
      name: r'technicianId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 12,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _correctiveEntityEstimateSize,
  serialize: _correctiveEntitySerialize,
  deserialize: _correctiveEntityDeserialize,
  deserializeProp: _correctiveEntityDeserializeProp,
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
    r'occurrenceLocalId': IndexSchema(
      id: 8759299772336575288,
      name: r'occurrenceLocalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'occurrenceLocalId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _correctiveEntityGetId,
  getLinks: _correctiveEntityGetLinks,
  attach: _correctiveEntityAttach,
  version: '3.1.0+1',
);

int _correctiveEntityEstimateSize(
  CorrectiveEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.finalNotes.length * 3;
  {
    final value = object.occurrenceRemoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.partsReplacedJson.length * 3;
  bytesCount += 3 + object.photos.length * 3;
  {
    for (var i = 0; i < object.photos.length; i++) {
      final value = object.photos[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.solution.length * 3;
  {
    final value = object.technicianId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _correctiveEntitySerialize(
  CorrectiveEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.finalNotes);
  writer.writeDateTime(offsets[2], object.finishedAt);
  writer.writeLong(offsets[3], object.occurrenceLocalId);
  writer.writeString(offsets[4], object.occurrenceRemoteId);
  writer.writeString(offsets[5], object.partsReplacedJson);
  writer.writeStringList(offsets[6], object.photos);
  writer.writeString(offsets[7], object.remoteId);
  writer.writeLong(offsets[8], object.repairTimeMinutes);
  writer.writeString(offsets[9], object.solution);
  writer.writeByte(offsets[10], object.syncStatus.index);
  writer.writeString(offsets[11], object.technicianId);
  writer.writeDateTime(offsets[12], object.updatedAt);
}

CorrectiveEntity _correctiveEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CorrectiveEntity(
    finalNotes: reader.readStringOrNull(offsets[1]) ?? '',
    finishedAt: reader.readDateTimeOrNull(offsets[2]),
    localId: id,
    occurrenceLocalId: reader.readLong(offsets[3]),
    occurrenceRemoteId: reader.readStringOrNull(offsets[4]),
    partsReplacedJson: reader.readStringOrNull(offsets[5]) ?? '[]',
    photos: reader.readStringList(offsets[6]) ?? const <String>[],
    remoteId: reader.readStringOrNull(offsets[7]),
    repairTimeMinutes: reader.readLongOrNull(offsets[8]) ?? 0,
    solution: reader.readStringOrNull(offsets[9]) ?? '',
    syncStatus:
        _CorrectiveEntitysyncStatusValueEnumMap[reader.readByteOrNull(
          offsets[10],
        )] ??
        SyncStatus.pending,
    technicianId: reader.readStringOrNull(offsets[11]),
  );
  object.createdAt = reader.readDateTime(offsets[0]);
  object.updatedAt = reader.readDateTime(offsets[12]);
  return object;
}

P _correctiveEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '[]') as P;
    case 6:
      return (reader.readStringList(offset) ?? const <String>[]) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (_CorrectiveEntitysyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.pending)
          as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CorrectiveEntitysyncStatusEnumValueMap = {
  'pending': 0,
  'syncing': 1,
  'synced': 2,
  'error': 3,
};
const _CorrectiveEntitysyncStatusValueEnumMap = {
  0: SyncStatus.pending,
  1: SyncStatus.syncing,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _correctiveEntityGetId(CorrectiveEntity object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _correctiveEntityGetLinks(CorrectiveEntity object) {
  return [];
}

void _correctiveEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  CorrectiveEntity object,
) {
  object.localId = id;
}

extension CorrectiveEntityByIndex on IsarCollection<CorrectiveEntity> {
  Future<CorrectiveEntity?> getByRemoteId(String? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  CorrectiveEntity? getByRemoteIdSync(String? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<CorrectiveEntity?>> getAllByRemoteId(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<CorrectiveEntity?> getAllByRemoteIdSync(List<String?> remoteIdValues) {
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

  Future<Id> putByRemoteId(CorrectiveEntity object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(CorrectiveEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<CorrectiveEntity> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(
    List<CorrectiveEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension CorrectiveEntityQueryWhereSort
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QWhere> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhere>
  anyOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'occurrenceLocalId'),
      );
    });
  }
}

extension CorrectiveEntityQueryWhere
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QWhereClause> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: localId, upper: localId),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  occurrenceLocalIdEqualTo(int occurrenceLocalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'occurrenceLocalId',
          value: [occurrenceLocalId],
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  occurrenceLocalIdNotEqualTo(int occurrenceLocalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceLocalId',
                lower: [],
                upper: [occurrenceLocalId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceLocalId',
                lower: [occurrenceLocalId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceLocalId',
                lower: [occurrenceLocalId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'occurrenceLocalId',
                lower: [],
                upper: [occurrenceLocalId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  occurrenceLocalIdGreaterThan(int occurrenceLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'occurrenceLocalId',
          lower: [occurrenceLocalId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  occurrenceLocalIdLessThan(int occurrenceLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'occurrenceLocalId',
          lower: [],
          upper: [occurrenceLocalId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterWhereClause>
  occurrenceLocalIdBetween(
    int lowerOccurrenceLocalId,
    int upperOccurrenceLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'occurrenceLocalId',
          lower: [lowerOccurrenceLocalId],
          includeLower: includeLower,
          upper: [upperOccurrenceLocalId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CorrectiveEntityQueryFilter
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QFilterCondition> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'finalNotes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'finalNotes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'finalNotes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'finalNotes', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finalNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'finalNotes', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'finishedAt'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'finishedAt'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'finishedAt', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'finishedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'finishedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  finishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'finishedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceLocalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceLocalId', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceLocalIdGreaterThan(int value, {bool include = false}) {
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceLocalIdLessThan(int value, {bool include = false}) {
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceLocalIdBetween(
    int lower,
    int upper, {
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'occurrenceRemoteId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'occurrenceRemoteId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'occurrenceRemoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'occurrenceRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'occurrenceRemoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'occurrenceRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'partsReplacedJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'partsReplacedJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'partsReplacedJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'partsReplacedJson', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  partsReplacedJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'partsReplacedJson', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'photos',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'photos',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'photos',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'photos', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'photos', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', length, true, length, true);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, true, 0, true);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, false, 999999, true);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, true, length, include);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', length, include, 999999, true);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  photosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'photos',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  repairTimeMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'repairTimeMinutes', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  repairTimeMinutesGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'repairTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  repairTimeMinutesLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'repairTimeMinutes',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  repairTimeMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'repairTimeMinutes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'solution',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'solution',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'solution',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'solution', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  solutionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'solution', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'technicianId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'technicianId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'technicianId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  technicianIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterFilterCondition>
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

extension CorrectiveEntityQueryObject
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QFilterCondition> {}

extension CorrectiveEntityQueryLinks
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QFilterCondition> {}

extension CorrectiveEntityQuerySortBy
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QSortBy> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByFinalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalNotes', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByFinalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalNotes', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByOccurrenceRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByOccurrenceRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByPartsReplacedJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partsReplacedJson', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByPartsReplacedJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partsReplacedJson', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByRepairTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repairTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByRepairTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repairTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortBySolution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solution', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortBySolutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solution', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CorrectiveEntityQuerySortThenBy
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QSortThenBy> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByFinalNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalNotes', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByFinalNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalNotes', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByOccurrenceRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByOccurrenceRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByPartsReplacedJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partsReplacedJson', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByPartsReplacedJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partsReplacedJson', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByRepairTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repairTimeMinutes', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByRepairTimeMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repairTimeMinutes', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenBySolution() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solution', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenBySolutionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'solution', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension CorrectiveEntityQueryWhereDistinct
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct> {
  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByFinalNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finalNotes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedAt');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occurrenceLocalId');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByOccurrenceRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'occurrenceRemoteId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByPartsReplacedJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'partsReplacedJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photos');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByRepairTimeMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repairTimeMinutes');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctBySolution({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'solution', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByTechnicianId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'technicianId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorrectiveEntity, CorrectiveEntity, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension CorrectiveEntityQueryProperty
    on QueryBuilder<CorrectiveEntity, CorrectiveEntity, QQueryProperty> {
  QueryBuilder<CorrectiveEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<CorrectiveEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CorrectiveEntity, String, QQueryOperations>
  finalNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finalNotes');
    });
  }

  QueryBuilder<CorrectiveEntity, DateTime?, QQueryOperations>
  finishedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedAt');
    });
  }

  QueryBuilder<CorrectiveEntity, int, QQueryOperations>
  occurrenceLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceLocalId');
    });
  }

  QueryBuilder<CorrectiveEntity, String?, QQueryOperations>
  occurrenceRemoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceRemoteId');
    });
  }

  QueryBuilder<CorrectiveEntity, String, QQueryOperations>
  partsReplacedJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partsReplacedJson');
    });
  }

  QueryBuilder<CorrectiveEntity, List<String>, QQueryOperations>
  photosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photos');
    });
  }

  QueryBuilder<CorrectiveEntity, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<CorrectiveEntity, int, QQueryOperations>
  repairTimeMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repairTimeMinutes');
    });
  }

  QueryBuilder<CorrectiveEntity, String, QQueryOperations> solutionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'solution');
    });
  }

  QueryBuilder<CorrectiveEntity, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<CorrectiveEntity, String?, QQueryOperations>
  technicianIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'technicianId');
    });
  }

  QueryBuilder<CorrectiveEntity, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
