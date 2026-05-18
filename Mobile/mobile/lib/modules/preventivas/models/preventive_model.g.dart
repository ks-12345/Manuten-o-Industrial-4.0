// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preventive_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPreventiveModelCollection on Isar {
  IsarCollection<PreventiveModel> get preventiveModels => this.collection();
}

const PreventiveModelSchema = CollectionSchema(
  name: r'PreventiveModel',
  id: -2187084715262878723,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'frequency': PropertySchema(
      id: 1,
      name: r'frequency',
      type: IsarType.string,
    ),
    r'machineId': PropertySchema(
      id: 2,
      name: r'machineId',
      type: IsarType.long,
    ),
    r'nextPreventive': PropertySchema(
      id: 3,
      name: r'nextPreventive',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _preventiveModelEstimateSize,
  serialize: _preventiveModelSerialize,
  deserialize: _preventiveModelDeserialize,
  deserializeProp: _preventiveModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _preventiveModelGetId,
  getLinks: _preventiveModelGetLinks,
  attach: _preventiveModelAttach,
  version: '3.1.0+1',
);

int _preventiveModelEstimateSize(
  PreventiveModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.frequency.length * 3;
  return bytesCount;
}

void _preventiveModelSerialize(
  PreventiveModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.frequency);
  writer.writeLong(offsets[2], object.machineId);
  writer.writeDateTime(offsets[3], object.nextPreventive);
  writer.writeDateTime(offsets[4], object.updatedAt);
}

PreventiveModel _preventiveModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PreventiveModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.frequency = reader.readString(offsets[1]);
  object.id = id;
  object.machineId = reader.readLong(offsets[2]);
  object.nextPreventive = reader.readDateTimeOrNull(offsets[3]);
  object.updatedAt = reader.readDateTime(offsets[4]);
  return object;
}

P _preventiveModelDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _preventiveModelGetId(PreventiveModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _preventiveModelGetLinks(PreventiveModel object) {
  return [];
}

void _preventiveModelAttach(
    IsarCollection<dynamic> col, Id id, PreventiveModel object) {
  object.id = id;
}

extension PreventiveModelQueryWhereSort
    on QueryBuilder<PreventiveModel, PreventiveModel, QWhere> {
  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PreventiveModelQueryWhere
    on QueryBuilder<PreventiveModel, PreventiveModel, QWhereClause> {
  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PreventiveModelQueryFilter
    on QueryBuilder<PreventiveModel, PreventiveModel, QFilterCondition> {
  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'frequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'frequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      frequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'frequency',
        value: '',
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      machineIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'machineId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      machineIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'machineId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      machineIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'machineId',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      machineIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'machineId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextPreventive',
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextPreventive',
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextPreventive',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextPreventive',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextPreventive',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      nextPreventiveBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextPreventive',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PreventiveModelQueryObject
    on QueryBuilder<PreventiveModel, PreventiveModel, QFilterCondition> {}

extension PreventiveModelQueryLinks
    on QueryBuilder<PreventiveModel, PreventiveModel, QFilterCondition> {}

extension PreventiveModelQuerySortBy
    on QueryBuilder<PreventiveModel, PreventiveModel, QSortBy> {
  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByMachineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByNextPreventive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPreventive', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByNextPreventiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPreventive', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PreventiveModelQuerySortThenBy
    on QueryBuilder<PreventiveModel, PreventiveModel, QSortThenBy> {
  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByMachineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByNextPreventive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPreventive', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByNextPreventiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextPreventive', Sort.desc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PreventiveModelQueryWhereDistinct
    on QueryBuilder<PreventiveModel, PreventiveModel, QDistinct> {
  QueryBuilder<PreventiveModel, PreventiveModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QDistinct> distinctByFrequency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QDistinct>
      distinctByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineId');
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QDistinct>
      distinctByNextPreventive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextPreventive');
    });
  }

  QueryBuilder<PreventiveModel, PreventiveModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension PreventiveModelQueryProperty
    on QueryBuilder<PreventiveModel, PreventiveModel, QQueryProperty> {
  QueryBuilder<PreventiveModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PreventiveModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PreventiveModel, String, QQueryOperations> frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<PreventiveModel, int, QQueryOperations> machineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineId');
    });
  }

  QueryBuilder<PreventiveModel, DateTime?, QQueryOperations>
      nextPreventiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextPreventive');
    });
  }

  QueryBuilder<PreventiveModel, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
