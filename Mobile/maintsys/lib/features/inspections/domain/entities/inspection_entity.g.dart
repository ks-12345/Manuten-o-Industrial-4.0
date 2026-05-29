// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInspectionEntityCollection on Isar {
  IsarCollection<InspectionEntity> get inspectionEntitys => this.collection();
}

const InspectionEntitySchema = CollectionSchema(
  name: r'InspectionEntity',
  id: 5349385958489862170,
  properties: {
    r'checklistResponsesJson': PropertySchema(
      id: 0,
      name: r'checklistResponsesJson',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'diagnosis': PropertySchema(
      id: 2,
      name: r'diagnosis',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 3, name: r'notes', type: IsarType.string),
    r'occurrenceLocalId': PropertySchema(
      id: 4,
      name: r'occurrenceLocalId',
      type: IsarType.long,
    ),
    r'occurrenceRemoteId': PropertySchema(
      id: 5,
      name: r'occurrenceRemoteId',
      type: IsarType.string,
    ),
    r'otherProblemDescription': PropertySchema(
      id: 6,
      name: r'otherProblemDescription',
      type: IsarType.string,
    ),
    r'remoteId': PropertySchema(
      id: 7,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 8,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _InspectionEntitysyncStatusEnumValueMap,
    ),
    r'technicianId': PropertySchema(
      id: 9,
      name: r'technicianId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _inspectionEntityEstimateSize,
  serialize: _inspectionEntitySerialize,
  deserialize: _inspectionEntityDeserialize,
  deserializeProp: _inspectionEntityDeserializeProp,
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
  getId: _inspectionEntityGetId,
  getLinks: _inspectionEntityGetLinks,
  attach: _inspectionEntityAttach,
  version: '3.1.0+1',
);

int _inspectionEntityEstimateSize(
  InspectionEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.checklistResponsesJson.length * 3;
  bytesCount += 3 + object.diagnosis.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  {
    final value = object.occurrenceRemoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.otherProblemDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.technicianId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _inspectionEntitySerialize(
  InspectionEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.checklistResponsesJson);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.diagnosis);
  writer.writeString(offsets[3], object.notes);
  writer.writeLong(offsets[4], object.occurrenceLocalId);
  writer.writeString(offsets[5], object.occurrenceRemoteId);
  writer.writeString(offsets[6], object.otherProblemDescription);
  writer.writeString(offsets[7], object.remoteId);
  writer.writeByte(offsets[8], object.syncStatus.index);
  writer.writeString(offsets[9], object.technicianId);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

InspectionEntity _inspectionEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InspectionEntity(
    checklistResponsesJson: reader.readStringOrNull(offsets[0]) ?? '{}',
    diagnosis: reader.readStringOrNull(offsets[2]) ?? '',
    localId: id,
    notes: reader.readStringOrNull(offsets[3]) ?? '',
    occurrenceLocalId: reader.readLong(offsets[4]),
    occurrenceRemoteId: reader.readStringOrNull(offsets[5]),
    otherProblemDescription: reader.readStringOrNull(offsets[6]),
    remoteId: reader.readStringOrNull(offsets[7]),
    syncStatus:
        _InspectionEntitysyncStatusValueEnumMap[reader.readByteOrNull(
          offsets[8],
        )] ??
        SyncStatus.pending,
    technicianId: reader.readStringOrNull(offsets[9]),
  );
  object.createdAt = reader.readDateTime(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[10]);
  return object;
}

P _inspectionEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '{}') as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_InspectionEntitysyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.pending)
          as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _InspectionEntitysyncStatusEnumValueMap = {
  'pending': 0,
  'syncing': 1,
  'synced': 2,
  'error': 3,
};
const _InspectionEntitysyncStatusValueEnumMap = {
  0: SyncStatus.pending,
  1: SyncStatus.syncing,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _inspectionEntityGetId(InspectionEntity object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _inspectionEntityGetLinks(InspectionEntity object) {
  return [];
}

void _inspectionEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  InspectionEntity object,
) {
  object.localId = id;
}

extension InspectionEntityByIndex on IsarCollection<InspectionEntity> {
  Future<InspectionEntity?> getByRemoteId(String? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  InspectionEntity? getByRemoteIdSync(String? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<InspectionEntity?>> getAllByRemoteId(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<InspectionEntity?> getAllByRemoteIdSync(List<String?> remoteIdValues) {
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

  Future<Id> putByRemoteId(InspectionEntity object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(InspectionEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<InspectionEntity> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(
    List<InspectionEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension InspectionEntityQueryWhereSort
    on QueryBuilder<InspectionEntity, InspectionEntity, QWhere> {
  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhere>
  anyOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'occurrenceLocalId'),
      );
    });
  }
}

extension InspectionEntityQueryWhere
    on QueryBuilder<InspectionEntity, InspectionEntity, QWhereClause> {
  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
  localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: localId, upper: localId),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
  localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
  localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterWhereClause>
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

extension InspectionEntityQueryFilter
    on QueryBuilder<InspectionEntity, InspectionEntity, QFilterCondition> {
  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'checklistResponsesJson',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'checklistResponsesJson',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'checklistResponsesJson',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'checklistResponsesJson', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  checklistResponsesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'checklistResponsesJson',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'diagnosis',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'diagnosis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'diagnosis',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'diagnosis', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  diagnosisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'diagnosis', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: value),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  occurrenceLocalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceLocalId', value: value),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'occurrenceRemoteId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'occurrenceRemoteId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'occurrenceRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  occurrenceRemoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'occurrenceRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'otherProblemDescription'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'otherProblemDescription'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'otherProblemDescription',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'otherProblemDescription',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'otherProblemDescription',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'otherProblemDescription',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  otherProblemDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'otherProblemDescription',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  technicianIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  technicianIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  technicianIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  technicianIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterFilterCondition>
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

extension InspectionEntityQueryObject
    on QueryBuilder<InspectionEntity, InspectionEntity, QFilterCondition> {}

extension InspectionEntityQueryLinks
    on QueryBuilder<InspectionEntity, InspectionEntity, QFilterCondition> {}

extension InspectionEntityQuerySortBy
    on QueryBuilder<InspectionEntity, InspectionEntity, QSortBy> {
  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByChecklistResponsesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistResponsesJson', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByChecklistResponsesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistResponsesJson', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosis', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosis', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOccurrenceRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOccurrenceRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOtherProblemDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherProblemDescription', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByOtherProblemDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherProblemDescription', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension InspectionEntityQuerySortThenBy
    on QueryBuilder<InspectionEntity, InspectionEntity, QSortThenBy> {
  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByChecklistResponsesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistResponsesJson', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByChecklistResponsesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistResponsesJson', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByDiagnosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosis', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByDiagnosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'diagnosis', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOccurrenceLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceLocalId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOccurrenceRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOccurrenceRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'occurrenceRemoteId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOtherProblemDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherProblemDescription', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByOtherProblemDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'otherProblemDescription', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension InspectionEntityQueryWhereDistinct
    on QueryBuilder<InspectionEntity, InspectionEntity, QDistinct> {
  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByChecklistResponsesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'checklistResponsesJson',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByDiagnosis({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'diagnosis', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByOccurrenceLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'occurrenceLocalId');
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByOccurrenceRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'occurrenceRemoteId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByOtherProblemDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'otherProblemDescription',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByTechnicianId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'technicianId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InspectionEntity, InspectionEntity, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension InspectionEntityQueryProperty
    on QueryBuilder<InspectionEntity, InspectionEntity, QQueryProperty> {
  QueryBuilder<InspectionEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<InspectionEntity, String, QQueryOperations>
  checklistResponsesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistResponsesJson');
    });
  }

  QueryBuilder<InspectionEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<InspectionEntity, String, QQueryOperations> diagnosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'diagnosis');
    });
  }

  QueryBuilder<InspectionEntity, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<InspectionEntity, int, QQueryOperations>
  occurrenceLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceLocalId');
    });
  }

  QueryBuilder<InspectionEntity, String?, QQueryOperations>
  occurrenceRemoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'occurrenceRemoteId');
    });
  }

  QueryBuilder<InspectionEntity, String?, QQueryOperations>
  otherProblemDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'otherProblemDescription');
    });
  }

  QueryBuilder<InspectionEntity, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<InspectionEntity, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<InspectionEntity, String?, QQueryOperations>
  technicianIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'technicianId');
    });
  }

  QueryBuilder<InspectionEntity, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
