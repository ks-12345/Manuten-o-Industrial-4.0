// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preventive_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPreventiveEntityCollection on Isar {
  IsarCollection<PreventiveEntity> get preventiveEntitys => this.collection();
}

const PreventiveEntitySchema = CollectionSchema(
  name: r'PreventiveEntity',
  id: 8125639772153348811,
  properties: {
    r'checklistTemplateRemoteId': PropertySchema(
      id: 0,
      name: r'checklistTemplateRemoteId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'lastDone': PropertySchema(
      id: 2,
      name: r'lastDone',
      type: IsarType.dateTime,
    ),
    r'machineCode': PropertySchema(
      id: 3,
      name: r'machineCode',
      type: IsarType.string,
    ),
    r'machineLocalId': PropertySchema(
      id: 4,
      name: r'machineLocalId',
      type: IsarType.long,
    ),
    r'machineRemoteId': PropertySchema(
      id: 5,
      name: r'machineRemoteId',
      type: IsarType.string,
    ),
    r'nextDue': PropertySchema(
      id: 6,
      name: r'nextDue',
      type: IsarType.dateTime,
    ),
    r'periodicityDays': PropertySchema(
      id: 7,
      name: r'periodicityDays',
      type: IsarType.long,
    ),
    r'remoteId': PropertySchema(
      id: 8,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 9,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _PreventiveEntitysyncStatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
  },
  estimateSize: _preventiveEntityEstimateSize,
  serialize: _preventiveEntitySerialize,
  deserialize: _preventiveEntityDeserialize,
  deserializeProp: _preventiveEntityDeserializeProp,
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
  getId: _preventiveEntityGetId,
  getLinks: _preventiveEntityGetLinks,
  attach: _preventiveEntityAttach,
  version: '3.1.0+1',
);

int _preventiveEntityEstimateSize(
  PreventiveEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.checklistTemplateRemoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.machineCode.length * 3;
  {
    final value = object.machineRemoteId;
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
  return bytesCount;
}

void _preventiveEntitySerialize(
  PreventiveEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.checklistTemplateRemoteId);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.lastDone);
  writer.writeString(offsets[3], object.machineCode);
  writer.writeLong(offsets[4], object.machineLocalId);
  writer.writeString(offsets[5], object.machineRemoteId);
  writer.writeDateTime(offsets[6], object.nextDue);
  writer.writeLong(offsets[7], object.periodicityDays);
  writer.writeString(offsets[8], object.remoteId);
  writer.writeByte(offsets[9], object.syncStatus.index);
  writer.writeDateTime(offsets[10], object.updatedAt);
}

PreventiveEntity _preventiveEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PreventiveEntity(
    checklistTemplateRemoteId: reader.readStringOrNull(offsets[0]),
    lastDone: reader.readDateTimeOrNull(offsets[2]),
    localId: id,
    machineCode: reader.readString(offsets[3]),
    machineLocalId: reader.readLong(offsets[4]),
    machineRemoteId: reader.readStringOrNull(offsets[5]),
    nextDue: reader.readDateTime(offsets[6]),
    periodicityDays: reader.readLongOrNull(offsets[7]) ?? 30,
    remoteId: reader.readStringOrNull(offsets[8]),
    syncStatus:
        _PreventiveEntitysyncStatusValueEnumMap[reader.readByteOrNull(
          offsets[9],
        )] ??
        SyncStatus.pending,
  );
  object.createdAt = reader.readDateTime(offsets[1]);
  object.updatedAt = reader.readDateTime(offsets[10]);
  return object;
}

P _preventiveEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset) ?? 30) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (_PreventiveEntitysyncStatusValueEnumMap[reader.readByteOrNull(
                offset,
              )] ??
              SyncStatus.pending)
          as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PreventiveEntitysyncStatusEnumValueMap = {
  'pending': 0,
  'syncing': 1,
  'synced': 2,
  'error': 3,
};
const _PreventiveEntitysyncStatusValueEnumMap = {
  0: SyncStatus.pending,
  1: SyncStatus.syncing,
  2: SyncStatus.synced,
  3: SyncStatus.error,
};

Id _preventiveEntityGetId(PreventiveEntity object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _preventiveEntityGetLinks(PreventiveEntity object) {
  return [];
}

void _preventiveEntityAttach(
  IsarCollection<dynamic> col,
  Id id,
  PreventiveEntity object,
) {
  object.localId = id;
}

extension PreventiveEntityByIndex on IsarCollection<PreventiveEntity> {
  Future<PreventiveEntity?> getByRemoteId(String? remoteId) {
    return getByIndex(r'remoteId', [remoteId]);
  }

  PreventiveEntity? getByRemoteIdSync(String? remoteId) {
    return getByIndexSync(r'remoteId', [remoteId]);
  }

  Future<bool> deleteByRemoteId(String? remoteId) {
    return deleteByIndex(r'remoteId', [remoteId]);
  }

  bool deleteByRemoteIdSync(String? remoteId) {
    return deleteByIndexSync(r'remoteId', [remoteId]);
  }

  Future<List<PreventiveEntity?>> getAllByRemoteId(
    List<String?> remoteIdValues,
  ) {
    final values = remoteIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteId', values);
  }

  List<PreventiveEntity?> getAllByRemoteIdSync(List<String?> remoteIdValues) {
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

  Future<Id> putByRemoteId(PreventiveEntity object) {
    return putByIndex(r'remoteId', object);
  }

  Id putByRemoteIdSync(PreventiveEntity object, {bool saveLinks = true}) {
    return putByIndexSync(r'remoteId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteId(List<PreventiveEntity> objects) {
    return putAllByIndex(r'remoteId', objects);
  }

  List<Id> putAllByRemoteIdSync(
    List<PreventiveEntity> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'remoteId', objects, saveLinks: saveLinks);
  }
}

extension PreventiveEntityQueryWhereSort
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QWhere> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhere>
  anyMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'machineLocalId'),
      );
    });
  }
}

extension PreventiveEntityQueryWhere
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QWhereClause> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
  localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: localId, upper: localId),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
  localIdGreaterThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
  localIdLessThan(Id localId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [null]),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
  remoteIdEqualTo(String? remoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'remoteId', value: [remoteId]),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterWhereClause>
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

extension PreventiveEntityQueryFilter
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QFilterCondition> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'checklistTemplateRemoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'checklistTemplateRemoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'checklistTemplateRemoteId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'checklistTemplateRemoteId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'checklistTemplateRemoteId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'checklistTemplateRemoteId',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  checklistTemplateRemoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'checklistTemplateRemoteId',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'lastDone'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'lastDone'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastDone', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastDone',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  lastDoneBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastDone',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'localId', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineCode', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'machineCode', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineLocalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineLocalId', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineRemoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'machineRemoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineRemoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'machineRemoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineRemoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'machineRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  machineRemoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'machineRemoteId', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  nextDueEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nextDue', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  nextDueGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nextDue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  nextDueLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nextDue',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  nextDueBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nextDue',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  periodicityDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'periodicityDays', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  periodicityDaysGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'periodicityDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  periodicityDaysLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'periodicityDays',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  periodicityDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'periodicityDays',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'remoteId'),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'remoteId', value: ''),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  syncStatusEqualTo(SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'syncStatus', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
  updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'updatedAt', value: value),
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterFilterCondition>
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

extension PreventiveEntityQueryObject
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QFilterCondition> {}

extension PreventiveEntityQueryLinks
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QFilterCondition> {}

extension PreventiveEntityQuerySortBy
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QSortBy> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByChecklistTemplateRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistTemplateRemoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByChecklistTemplateRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistTemplateRemoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByLastDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDone', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByLastDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDone', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByMachineRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByNextDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByNextDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByPeriodicityDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'periodicityDays', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByPeriodicityDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'periodicityDays', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PreventiveEntityQuerySortThenBy
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QSortThenBy> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByChecklistTemplateRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistTemplateRemoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByChecklistTemplateRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistTemplateRemoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByLastDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDone', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByLastDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastDone', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineCode', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineLocalId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByMachineRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineRemoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByNextDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByNextDueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextDue', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByPeriodicityDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'periodicityDays', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByPeriodicityDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'periodicityDays', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QAfterSortBy>
  thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PreventiveEntityQueryWhereDistinct
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct> {
  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByChecklistTemplateRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'checklistTemplateRemoteId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByLastDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastDone');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByMachineCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByMachineLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineLocalId');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByMachineRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'machineRemoteId',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByNextDue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextDue');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByPeriodicityDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'periodicityDays');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByRemoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<PreventiveEntity, PreventiveEntity, QDistinct>
  distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension PreventiveEntityQueryProperty
    on QueryBuilder<PreventiveEntity, PreventiveEntity, QQueryProperty> {
  QueryBuilder<PreventiveEntity, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<PreventiveEntity, String?, QQueryOperations>
  checklistTemplateRemoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistTemplateRemoteId');
    });
  }

  QueryBuilder<PreventiveEntity, DateTime, QQueryOperations>
  createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PreventiveEntity, DateTime?, QQueryOperations>
  lastDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastDone');
    });
  }

  QueryBuilder<PreventiveEntity, String, QQueryOperations>
  machineCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineCode');
    });
  }

  QueryBuilder<PreventiveEntity, int, QQueryOperations>
  machineLocalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineLocalId');
    });
  }

  QueryBuilder<PreventiveEntity, String?, QQueryOperations>
  machineRemoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineRemoteId');
    });
  }

  QueryBuilder<PreventiveEntity, DateTime, QQueryOperations> nextDueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextDue');
    });
  }

  QueryBuilder<PreventiveEntity, int, QQueryOperations>
  periodicityDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'periodicityDays');
    });
  }

  QueryBuilder<PreventiveEntity, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<PreventiveEntity, SyncStatus, QQueryOperations>
  syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<PreventiveEntity, DateTime, QQueryOperations>
  updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
