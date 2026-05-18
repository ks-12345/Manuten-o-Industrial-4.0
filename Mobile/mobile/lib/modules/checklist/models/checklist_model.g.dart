// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChecklistModelCollection on Isar {
  IsarCollection<ChecklistModel> get checklistModels => this.collection();
}

const ChecklistModelSchema = CollectionSchema(
  name: r'ChecklistModel',
  id: -3739082163393886584,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'finishedAt': PropertySchema(
      id: 1,
      name: r'finishedAt',
      type: IsarType.dateTime,
    ),
    r'isFinished': PropertySchema(
      id: 2,
      name: r'isFinished',
      type: IsarType.bool,
    ),
    r'machineId': PropertySchema(
      id: 3,
      name: r'machineId',
      type: IsarType.long,
    ),
    r'technicianId': PropertySchema(
      id: 4,
      name: r'technicianId',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 5,
      name: r'title',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 6,
      name: r'type',
      type: IsarType.string,
      enumMap: _ChecklistModeltypeEnumValueMap,
    )
  },
  estimateSize: _checklistModelEstimateSize,
  serialize: _checklistModelSerialize,
  deserialize: _checklistModelDeserialize,
  deserializeProp: _checklistModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _checklistModelGetId,
  getLinks: _checklistModelGetLinks,
  attach: _checklistModelAttach,
  version: '3.1.0+1',
);

int _checklistModelEstimateSize(
  ChecklistModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _checklistModelSerialize(
  ChecklistModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.finishedAt);
  writer.writeBool(offsets[2], object.isFinished);
  writer.writeLong(offsets[3], object.machineId);
  writer.writeLong(offsets[4], object.technicianId);
  writer.writeString(offsets[5], object.title);
  writer.writeString(offsets[6], object.type.name);
}

ChecklistModel _checklistModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChecklistModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.finishedAt = reader.readDateTimeOrNull(offsets[1]);
  object.id = id;
  object.isFinished = reader.readBool(offsets[2]);
  object.machineId = reader.readLong(offsets[3]);
  object.technicianId = reader.readLong(offsets[4]);
  object.title = reader.readString(offsets[5]);
  object.type =
      _ChecklistModeltypeValueEnumMap[reader.readStringOrNull(offsets[6])] ??
          ChecklistType.preventive;
  return object;
}

P _checklistModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (_ChecklistModeltypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ChecklistType.preventive) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChecklistModeltypeEnumValueMap = {
  r'preventive': r'preventive',
  r'corrective': r'corrective',
  r'inspection': r'inspection',
  r'daily': r'daily',
};
const _ChecklistModeltypeValueEnumMap = {
  r'preventive': ChecklistType.preventive,
  r'corrective': ChecklistType.corrective,
  r'inspection': ChecklistType.inspection,
  r'daily': ChecklistType.daily,
};

Id _checklistModelGetId(ChecklistModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _checklistModelGetLinks(ChecklistModel object) {
  return [];
}

void _checklistModelAttach(
    IsarCollection<dynamic> col, Id id, ChecklistModel object) {
  object.id = id;
}

extension ChecklistModelQueryWhereSort
    on QueryBuilder<ChecklistModel, ChecklistModel, QWhere> {
  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChecklistModelQueryWhere
    on QueryBuilder<ChecklistModel, ChecklistModel, QWhereClause> {
  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterWhereClause> idBetween(
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

extension ChecklistModelQueryFilter
    on QueryBuilder<ChecklistModel, ChecklistModel, QFilterCondition> {
  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finishedAt',
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      finishedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      isFinishedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      machineIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'machineId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
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

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      technicianIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'technicianId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      technicianIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'technicianId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      technicianIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'technicianId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      technicianIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'technicianId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeEqualTo(
    ChecklistType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeGreaterThan(
    ChecklistType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeLessThan(
    ChecklistType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeBetween(
    ChecklistType lower,
    ChecklistType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ChecklistModelQueryObject
    on QueryBuilder<ChecklistModel, ChecklistModel, QFilterCondition> {}

extension ChecklistModelQueryLinks
    on QueryBuilder<ChecklistModel, ChecklistModel, QFilterCondition> {}

extension ChecklistModelQuerySortBy
    on QueryBuilder<ChecklistModel, ChecklistModel, QSortBy> {
  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByMachineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      sortByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChecklistModelQuerySortThenBy
    on QueryBuilder<ChecklistModel, ChecklistModel, QSortThenBy> {
  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByFinishedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByMachineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'machineId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy>
      thenByTechnicianIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'technicianId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChecklistModelQueryWhereDistinct
    on QueryBuilder<ChecklistModel, ChecklistModel, QDistinct> {
  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct>
      distinctByFinishedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedAt');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct>
      distinctByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFinished');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct>
      distinctByMachineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'machineId');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct>
      distinctByTechnicianId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'technicianId');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistModel, ChecklistModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ChecklistModelQueryProperty
    on QueryBuilder<ChecklistModel, ChecklistModel, QQueryProperty> {
  QueryBuilder<ChecklistModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChecklistModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ChecklistModel, DateTime?, QQueryOperations>
      finishedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedAt');
    });
  }

  QueryBuilder<ChecklistModel, bool, QQueryOperations> isFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFinished');
    });
  }

  QueryBuilder<ChecklistModel, int, QQueryOperations> machineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'machineId');
    });
  }

  QueryBuilder<ChecklistModel, int, QQueryOperations> technicianIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'technicianId');
    });
  }

  QueryBuilder<ChecklistModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ChecklistModel, ChecklistType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChecklistQuestionModelCollection on Isar {
  IsarCollection<ChecklistQuestionModel> get checklistQuestionModels =>
      this.collection();
}

const ChecklistQuestionModelSchema = CollectionSchema(
  name: r'ChecklistQuestionModel',
  id: 4259592293195723521,
  properties: {
    r'checklistId': PropertySchema(
      id: 0,
      name: r'checklistId',
      type: IsarType.long,
    ),
    r'isRequired': PropertySchema(
      id: 1,
      name: r'isRequired',
      type: IsarType.bool,
    ),
    r'order': PropertySchema(
      id: 2,
      name: r'order',
      type: IsarType.long,
    ),
    r'question': PropertySchema(
      id: 3,
      name: r'question',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
      enumMap: _ChecklistQuestionModeltypeEnumValueMap,
    )
  },
  estimateSize: _checklistQuestionModelEstimateSize,
  serialize: _checklistQuestionModelSerialize,
  deserialize: _checklistQuestionModelDeserialize,
  deserializeProp: _checklistQuestionModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _checklistQuestionModelGetId,
  getLinks: _checklistQuestionModelGetLinks,
  attach: _checklistQuestionModelAttach,
  version: '3.1.0+1',
);

int _checklistQuestionModelEstimateSize(
  ChecklistQuestionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.question.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _checklistQuestionModelSerialize(
  ChecklistQuestionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.checklistId);
  writer.writeBool(offsets[1], object.isRequired);
  writer.writeLong(offsets[2], object.order);
  writer.writeString(offsets[3], object.question);
  writer.writeString(offsets[4], object.type.name);
}

ChecklistQuestionModel _checklistQuestionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChecklistQuestionModel();
  object.checklistId = reader.readLong(offsets[0]);
  object.id = id;
  object.isRequired = reader.readBool(offsets[1]);
  object.order = reader.readLong(offsets[2]);
  object.question = reader.readString(offsets[3]);
  object.type = _ChecklistQuestionModeltypeValueEnumMap[
          reader.readStringOrNull(offsets[4])] ??
      QuestionType.yesNo;
  return object;
}

P _checklistQuestionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_ChecklistQuestionModeltypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          QuestionType.yesNo) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ChecklistQuestionModeltypeEnumValueMap = {
  r'yesNo': r'yesNo',
  r'okProblem': r'okProblem',
  r'text': r'text',
  r'observation': r'observation',
  r'photo': r'photo',
};
const _ChecklistQuestionModeltypeValueEnumMap = {
  r'yesNo': QuestionType.yesNo,
  r'okProblem': QuestionType.okProblem,
  r'text': QuestionType.text,
  r'observation': QuestionType.observation,
  r'photo': QuestionType.photo,
};

Id _checklistQuestionModelGetId(ChecklistQuestionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _checklistQuestionModelGetLinks(
    ChecklistQuestionModel object) {
  return [];
}

void _checklistQuestionModelAttach(
    IsarCollection<dynamic> col, Id id, ChecklistQuestionModel object) {
  object.id = id;
}

extension ChecklistQuestionModelQueryWhereSort
    on QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QWhere> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChecklistQuestionModelQueryWhere on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QWhereClause> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterWhereClause> idBetween(
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

extension ChecklistQuestionModelQueryFilter on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QFilterCondition> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> checklistIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> checklistIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> checklistIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> checklistIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'checklistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> isRequiredEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRequired',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'question',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
          QAfterFilterCondition>
      questionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'question',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
          QAfterFilterCondition>
      questionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'question',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> questionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'question',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeEqualTo(
    QuestionType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeGreaterThan(
    QuestionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeLessThan(
    QuestionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeBetween(
    QuestionType lower,
    QuestionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
          QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
          QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension ChecklistQuestionModelQueryObject on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QFilterCondition> {}

extension ChecklistQuestionModelQueryLinks on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QFilterCondition> {}

extension ChecklistQuestionModelQuerySortBy
    on QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QSortBy> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChecklistQuestionModelQuerySortThenBy on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QSortThenBy> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByIsRequiredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRequired', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'question', Sort.desc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension ChecklistQuestionModelQueryWhereDistinct
    on QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct> {
  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct>
      distinctByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checklistId');
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct>
      distinctByIsRequired() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRequired');
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct>
      distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct>
      distinctByQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'question', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistQuestionModel, ChecklistQuestionModel, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension ChecklistQuestionModelQueryProperty on QueryBuilder<
    ChecklistQuestionModel, ChecklistQuestionModel, QQueryProperty> {
  QueryBuilder<ChecklistQuestionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChecklistQuestionModel, int, QQueryOperations>
      checklistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistId');
    });
  }

  QueryBuilder<ChecklistQuestionModel, bool, QQueryOperations>
      isRequiredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRequired');
    });
  }

  QueryBuilder<ChecklistQuestionModel, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<ChecklistQuestionModel, String, QQueryOperations>
      questionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'question');
    });
  }

  QueryBuilder<ChecklistQuestionModel, QuestionType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChecklistAnswerModelCollection on Isar {
  IsarCollection<ChecklistAnswerModel> get checklistAnswerModels =>
      this.collection();
}

const ChecklistAnswerModelSchema = CollectionSchema(
  name: r'ChecklistAnswerModel',
  id: -5808253836251148798,
  properties: {
    r'answeredAt': PropertySchema(
      id: 0,
      name: r'answeredAt',
      type: IsarType.dateTime,
    ),
    r'boolAnswer': PropertySchema(
      id: 1,
      name: r'boolAnswer',
      type: IsarType.bool,
    ),
    r'checklistId': PropertySchema(
      id: 2,
      name: r'checklistId',
      type: IsarType.long,
    ),
    r'photoPath': PropertySchema(
      id: 3,
      name: r'photoPath',
      type: IsarType.string,
    ),
    r'questionId': PropertySchema(
      id: 4,
      name: r'questionId',
      type: IsarType.long,
    ),
    r'textAnswer': PropertySchema(
      id: 5,
      name: r'textAnswer',
      type: IsarType.string,
    )
  },
  estimateSize: _checklistAnswerModelEstimateSize,
  serialize: _checklistAnswerModelSerialize,
  deserialize: _checklistAnswerModelDeserialize,
  deserializeProp: _checklistAnswerModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _checklistAnswerModelGetId,
  getLinks: _checklistAnswerModelGetLinks,
  attach: _checklistAnswerModelAttach,
  version: '3.1.0+1',
);

int _checklistAnswerModelEstimateSize(
  ChecklistAnswerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.photoPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.textAnswer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _checklistAnswerModelSerialize(
  ChecklistAnswerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.answeredAt);
  writer.writeBool(offsets[1], object.boolAnswer);
  writer.writeLong(offsets[2], object.checklistId);
  writer.writeString(offsets[3], object.photoPath);
  writer.writeLong(offsets[4], object.questionId);
  writer.writeString(offsets[5], object.textAnswer);
}

ChecklistAnswerModel _checklistAnswerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChecklistAnswerModel();
  object.answeredAt = reader.readDateTime(offsets[0]);
  object.boolAnswer = reader.readBoolOrNull(offsets[1]);
  object.checklistId = reader.readLong(offsets[2]);
  object.id = id;
  object.photoPath = reader.readStringOrNull(offsets[3]);
  object.questionId = reader.readLong(offsets[4]);
  object.textAnswer = reader.readStringOrNull(offsets[5]);
  return object;
}

P _checklistAnswerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _checklistAnswerModelGetId(ChecklistAnswerModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _checklistAnswerModelGetLinks(
    ChecklistAnswerModel object) {
  return [];
}

void _checklistAnswerModelAttach(
    IsarCollection<dynamic> col, Id id, ChecklistAnswerModel object) {
  object.id = id;
}

extension ChecklistAnswerModelQueryWhereSort
    on QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QWhere> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChecklistAnswerModelQueryWhere
    on QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QWhereClause> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhereClause>
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

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterWhereClause>
      idBetween(
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

extension ChecklistAnswerModelQueryFilter on QueryBuilder<ChecklistAnswerModel,
    ChecklistAnswerModel, QFilterCondition> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> answeredAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> answeredAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> answeredAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'answeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> answeredAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'answeredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> boolAnswerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boolAnswer',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> boolAnswerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boolAnswer',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> boolAnswerEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boolAnswer',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> checklistIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> checklistIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> checklistIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'checklistId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> checklistIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'checklistId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'photoPath',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'photoPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
          QAfterFilterCondition>
      photoPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'photoPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
          QAfterFilterCondition>
      photoPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'photoPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> photoPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'photoPath',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> questionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> questionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> questionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> questionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textAnswer',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textAnswer',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textAnswer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
          QAfterFilterCondition>
      textAnswerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
          QAfterFilterCondition>
      textAnswerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textAnswer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel,
      QAfterFilterCondition> textAnswerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textAnswer',
        value: '',
      ));
    });
  }
}

extension ChecklistAnswerModelQueryObject on QueryBuilder<ChecklistAnswerModel,
    ChecklistAnswerModel, QFilterCondition> {}

extension ChecklistAnswerModelQueryLinks on QueryBuilder<ChecklistAnswerModel,
    ChecklistAnswerModel, QFilterCondition> {}

extension ChecklistAnswerModelQuerySortBy
    on QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QSortBy> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByBoolAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolAnswer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByBoolAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolAnswer', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByTextAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAnswer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      sortByTextAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAnswer', Sort.desc);
    });
  }
}

extension ChecklistAnswerModelQuerySortThenBy
    on QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QSortThenBy> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByAnsweredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'answeredAt', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByBoolAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolAnswer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByBoolAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolAnswer', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByChecklistIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'checklistId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByPhotoPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByPhotoPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'photoPath', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByQuestionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionId', Sort.desc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByTextAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAnswer', Sort.asc);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QAfterSortBy>
      thenByTextAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textAnswer', Sort.desc);
    });
  }
}

extension ChecklistAnswerModelQueryWhereDistinct
    on QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct> {
  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByAnsweredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'answeredAt');
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByBoolAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boolAnswer');
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByChecklistId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'checklistId');
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByPhotoPath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'photoPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByQuestionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionId');
    });
  }

  QueryBuilder<ChecklistAnswerModel, ChecklistAnswerModel, QDistinct>
      distinctByTextAnswer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textAnswer', caseSensitive: caseSensitive);
    });
  }
}

extension ChecklistAnswerModelQueryProperty on QueryBuilder<
    ChecklistAnswerModel, ChecklistAnswerModel, QQueryProperty> {
  QueryBuilder<ChecklistAnswerModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChecklistAnswerModel, DateTime, QQueryOperations>
      answeredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answeredAt');
    });
  }

  QueryBuilder<ChecklistAnswerModel, bool?, QQueryOperations>
      boolAnswerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boolAnswer');
    });
  }

  QueryBuilder<ChecklistAnswerModel, int, QQueryOperations>
      checklistIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'checklistId');
    });
  }

  QueryBuilder<ChecklistAnswerModel, String?, QQueryOperations>
      photoPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'photoPath');
    });
  }

  QueryBuilder<ChecklistAnswerModel, int, QQueryOperations>
      questionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionId');
    });
  }

  QueryBuilder<ChecklistAnswerModel, String?, QQueryOperations>
      textAnswerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textAnswer');
    });
  }
}
