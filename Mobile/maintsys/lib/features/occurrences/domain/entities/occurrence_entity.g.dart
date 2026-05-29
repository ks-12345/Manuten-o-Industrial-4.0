// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occurrence_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOccurrenceEntityCollection on Isar {
  IsarCollection<OccurrenceEntity> get occurrenceEntitys => this.collection();
}

const OccurrenceEntitySchema = CollectionSchema(
  name: r'OccurrenceEntity',
  id: -4388792299719132191,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'machineCode': PropertySchema(
      id: 2,
      name: r'machineCode',
      type: IsarType.string,
    ),
    r'machineLocalId': PropertySchema(
      id: 3,
      name: r'machineLocalId',
      type: IsarType.long,
    ),
    r'machineRemoteId': PropertySchema(
      id: 4,
      name: r'machineRemoteId',
      type: IsarType.string,
    ),
    r'photos': PropertySchema(
      id: 5,
      name: r'photos',
      type: IsarType.stringList,
    ),
    r'priority': PropertySchema(
      id: 6,
      name: r'priority',
      type: IsarType.byte,
      enumMap: _OccurrenceEntitypriorityEnumValueMap,
    ),
    r'remoteId': PropertySchema(
      id: 7,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'reporterId': PropertySchema(
      id: 8,
      name: r'reporterId',
      type: IsarType.string,
    ),
    r'sectorName': PropertySchema(
      id: 9,
      name: r'sectorName',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 10,
      name: r'status',
      type: IsarType.byte,
      enumMap: _OccurrenceEntitystatusEnumValueMap,
    ),
    r'syncStatus': PropertySchema(
      id: 11,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _OccurrenceEntitysyncStatusEnumValueMap,
    ),
    r'technicianId': PropertySchema(
      id: 12,
      name: r'technicianId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _occurrenceEntityEstimateSize,
  serialize: _occurrenceEntitySerialize,
  deserialize: _occurrenceEntityDeserialize,
  deserializeProp: _occurrenceEntityDeserializeProp,
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
    r'machineLocalId': IndexSchema(
      id: 270042070815626671,
      name: r'machineLocalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'machineLocalId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _occurrenceEntityGetId,
  getLinks: _occurrenceEntityGetLinks,
  attach: _occurrenceEntityAttach,
  version: '3.1.0+1',
);

int _occurrenceEntityEstimateSize(
  OccurrenceEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.machineCode.length * 3;
  {
    final value = object.machineRemoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
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
  {
    final value = object.reporterId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.sectorName.length * 3;
  {
    final value = object.technicianId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _occurrenceEntitySerialize(
  OccurrenceEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.description);
  writer.writeString(offsets[2], object.machineCode);
  writer.writeLong(offsets[3], object.machineLocalId);
  writer.writeString(offsets[4], object.machineRemoteId);
  writer.writeStringList(offsets[5], object.photos);
  writer.writeByte(offsets[6], object.priority.index);
  writer.writeString(offsets[7], object.remoteId);
  writer.writeString(offsets[8], object.reporterId);
  writer.writeString(offsets[9], object.sectorName);
  writer.writeByte(offsets[10], object.status.index);
  writer.writeByte(offsets[11], object.syncStatus.index);
  writer.writeString(offsets[12], object.technicianId);
  writer.writeDateTime(offsets[13], object.updatedAt);
}

OccurrenceEntity _occurrenceEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OccurrenceEntity(
    description: reader.readString(offsets[1]),
    localId: id,
    machineCode: reader.readString(offsets[2]),
    machineLocalId: reader.readLong(offsets[3]),
    machineRemoteId: reader.readStringOrNull(offsets[4]),
    photos: reader.readStringList(offsets[5]) ?? const <String>[],
    priority:
        _OccurrenceEntitypriorityValueEnumMap[reader.readByteOrNull(
          offsets[6],
        )] ??
        OccurrencePriority.medium,
    remoteId: reader.readStringOrNull(offsets[7]),
    reporterId: reader.readStringOrNull(offsets[8]),
    sectorName: reader.readString(offsets[9]),
    status:
        _OccurrenceEntitystatusValueEnumMap[reader.readByteOrNull(
          offsets[10],
        )] ??
        OccurrenceWorkflowStatus.open,
    syncStatus:
        _OccurrenceEntitysyncStatusValueEnumMap[reader.readByteOrNull(
          offsets[11],
        )] ??
        SyncStatus.pending,
    technicianId: reader.readStringOrNull(offsets[12]),
  );
  object.createdAt = reader.readDateTime(offsets[0]);
  object.updatedAt = reader.readDateTime(offsets[13]);
  return object;
}

P _occurrenceEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? const <String>[]) as P;
    case 6:
      return (_OccurrenceEntitypriorityValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              OccurrencePriority.medium)
          as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (_OccurrenceEntitystatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              OccurrenceWorkflowStatus.open)
          as P;
    case 11:
      return (_OccurrenceEntitysyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.pending)
          as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _OccurrenceEntitypriorityEnumValueMap = {
  'low': 0,
  'medium': 1,
  'high': 2,
  'critical': 3,
};
const _OccurrenceEntitypriorityValueEnumMap = {
  0: OccurrencePriority.low,
  1: OccurrencePriority.medium,
  2: OccurrencePriority.high,
  3: OccurrencePriority.critical,
};
const _OccurrenceEntitystatusEnumValueMap = {
  'open': 0,
  'underAnalysis': 1,
  'inMaintenance': 2,
  'finished': 3,
  'canceled': 4,
};
const _OccurrenceEntitystatusValueEnumMap = {
  0: OccurrenceWorkflowStatus.open,
  1: OccurrenceWorkflowStatus.underAnalysis,
  2: OccurrenceWorkflowStatus.inMaintenance,
  3: OccurrenceWorkflowStatus.finished,
  4: OccurrenceWorkflowStatus.canceled,
};
const _OccurrenceEntitysyncStatusEnumValueMap = {
  'pending': 0,
  'syncing': 1,
  'synced': 2,
  'error': 3,
};
const _OccurrenceEntitysyncStatusValueEnumMap = {
  0: SyncStatus.pending,
  1: SyncStatus.syncing,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _occurrenceEntityGetId(OccurrenceEntity object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _occurrenceEntityGetLinks(OccurrenceEntity object) {
  return [];
}

void _occurrenceEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  OccurrenceEntity object,
) {
  object.localId = id;
}

extension OccurrenceEntityByIndex on IsarCollection<OccurrenceEntity> {
  Future<OccurrenceEntity?> getByRemoteId(String? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  OccurrenceEntity? getByRemoteIdSync(String? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<OccurrenceEntity?>> getAllByRemoteId(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<OccurrenceEntity?> getAllByRemoteIdSync(List<String?> remoteIdValues) {
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

  Future<Id> putByRemoteId(OccurrenceEntity object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(OccurrenceEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<OccurrenceEntity> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(
    List<OccurrenceEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension OccurrenceEntityQueryWhereSort
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QWhere> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhere>
  anyMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'machineLocalId'),
      );
    });
  }
}

extension OccurrenceEntityQueryWhere
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QWhereClause> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: localId, upper: localId),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  machineLocalIdEqualTo(int machineLocalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'machineLocalId',
          value: [machineLocalId],
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  machineLocalIdNotEqualTo(int machineLocalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'machineLocalId',
                lower: [],
                upper: [machineLocalId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'machineLocalId',
                lower: [machineLocalId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'machineLocalId',
                lower: [machineLocalId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'machineLocalId',
                lower: [],
                upper: [machineLocalId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  machineLocalIdGreaterThan(int machineLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'machineLocalId',
          lower: [machineLocalId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  machineLocalIdLessThan(int machineLocalId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'machineLocalId',
          lower: [],
          upper: [machineLocalId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterWhereClause>
  machineLocalIdBetween(
    int lowerMachineLocalId,
    int upperMachineLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'machineLocalId',
          lower: [lowerMachineLocalId],
          includeLower: includeLower,
          upper: [upperMachineLocalId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension OccurrenceEntityQueryFilter
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QFilterCondition> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'machineCode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'machineCode',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'machineCode',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineCode', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'machineCode', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineLocalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineLocalId', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineLocalIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'machineLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineLocalIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'machineLocalId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineLocalIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'machineLocalId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'machineRemoteId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'machineRemoteId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'machineRemoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'machineRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'machineRemoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  machineRemoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'machineRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'photos', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'photos', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', length, true, length, true);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, true, 0, true);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, false, 999999, true);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', 0, true, length, include);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  photosLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'photos', length, include, 999999, true);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  priorityEqualTo(OccurrencePriority value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'priority', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  priorityGreaterThan(OccurrencePriority value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'priority',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  priorityLessThan(OccurrencePriority value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'priority',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  priorityBetween(
    OccurrencePriority lower,
    OccurrencePriority upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'priority',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'reporterId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'reporterId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'reporterId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'reporterId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'reporterId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'reporterId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  reporterIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'reporterId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'sectorName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'sectorName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'sectorName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'sectorName', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  sectorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'sectorName', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  statusEqualTo(OccurrenceWorkflowStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  statusGreaterThan(OccurrenceWorkflowStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  statusLessThan(OccurrenceWorkflowStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  statusBetween(
    OccurrenceWorkflowStatus lower,
    OccurrenceWorkflowStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  technicianIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  technicianIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'technicianId'),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  technicianIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  technicianIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'technicianId', value: ''),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterFilterCondition>
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

extension OccurrenceEntityQueryObject
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QFilterCondition> {}

extension OccurrenceEntityQueryLinks
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QFilterCondition> {}

extension OccurrenceEntityQuerySortBy
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QSortBy> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByMachineRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByReporterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reporterId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByReporterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reporterId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortBySectorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorName', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortBySectorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorName', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OccurrenceEntityQuerySortThenBy
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QSortThenBy> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByMachineRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByReporterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reporterId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByReporterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reporterId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenBySectorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorName', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenBySectorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectorName', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OccurrenceEntityQueryWhereDistinct
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct> {
  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByMachineCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineLocalId');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByMachineRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'machineRemoteId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByPhotos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photos');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByReporterId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reporterId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctBySectorName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sectorName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByTechnicianId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'technicianId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceEntity, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension OccurrenceEntityQueryProperty
    on QueryBuilder<OccurrenceEntity, OccurrenceEntity, QQueryProperty> {
  QueryBuilder<OccurrenceEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<OccurrenceEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OccurrenceEntity, String, QQueryOperations>
  descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<OccurrenceEntity, String, QQueryOperations>
  machineCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineCode');
    });
  }

  QueryBuilder<OccurrenceEntity, int, QQueryOperations>
  machineLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineLocalId');
    });
  }

  QueryBuilder<OccurrenceEntity, String?, QQueryOperations>
  machineRemoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineRemoteId');
    });
  }

  QueryBuilder<OccurrenceEntity, List<String>, QQueryOperations>
  photosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photos');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrencePriority, QQueryOperations>
  priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<OccurrenceEntity, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<OccurrenceEntity, String?, QQueryOperations>
  reporterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reporterId');
    });
  }

  QueryBuilder<OccurrenceEntity, String, QQueryOperations>
  sectorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sectorName');
    });
  }

  QueryBuilder<OccurrenceEntity, OccurrenceWorkflowStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<OccurrenceEntity, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<OccurrenceEntity, String?, QQueryOperations>
  technicianIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'technicianId');
    });
  }

  QueryBuilder<OccurrenceEntity, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
