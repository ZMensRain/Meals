// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWeekCollection on Isar {
  IsarCollection<Week> get weeks => this.collection();
}

const WeekSchema = CollectionSchema(
  name: r'Week',
  id: 5019936486844116432,
  properties: {
    r'friday': PropertySchema(
      id: 0,
      name: r'friday',
      type: IsarType.longList,
    ),
    r'monday': PropertySchema(
      id: 1,
      name: r'monday',
      type: IsarType.longList,
    ),
    r'saturday': PropertySchema(
      id: 2,
      name: r'saturday',
      type: IsarType.longList,
    ),
    r'sunday': PropertySchema(
      id: 3,
      name: r'sunday',
      type: IsarType.longList,
    ),
    r'thursday': PropertySchema(
      id: 4,
      name: r'thursday',
      type: IsarType.longList,
    ),
    r'tuesday': PropertySchema(
      id: 5,
      name: r'tuesday',
      type: IsarType.longList,
    ),
    r'wednesday': PropertySchema(
      id: 6,
      name: r'wednesday',
      type: IsarType.longList,
    )
  },
  estimateSize: _weekEstimateSize,
  serialize: _weekSerialize,
  deserialize: _weekDeserialize,
  deserializeProp: _weekDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _weekGetId,
  getLinks: _weekGetLinks,
  attach: _weekAttach,
  version: '3.1.0+1',
);

int _weekEstimateSize(
  Week object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.friday.length * 8;
  bytesCount += 3 + object.monday.length * 8;
  bytesCount += 3 + object.saturday.length * 8;
  bytesCount += 3 + object.sunday.length * 8;
  bytesCount += 3 + object.thursday.length * 8;
  bytesCount += 3 + object.tuesday.length * 8;
  bytesCount += 3 + object.wednesday.length * 8;
  return bytesCount;
}

void _weekSerialize(
  Week object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.friday);
  writer.writeLongList(offsets[1], object.monday);
  writer.writeLongList(offsets[2], object.saturday);
  writer.writeLongList(offsets[3], object.sunday);
  writer.writeLongList(offsets[4], object.thursday);
  writer.writeLongList(offsets[5], object.tuesday);
  writer.writeLongList(offsets[6], object.wednesday);
}

Week _weekDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Week(
    friday: reader.readLongList(offsets[0]) ?? const [],
    monday: reader.readLongList(offsets[1]) ?? const [],
    saturday: reader.readLongList(offsets[2]) ?? const [],
    sunday: reader.readLongList(offsets[3]) ?? const [],
    thursday: reader.readLongList(offsets[4]) ?? const [],
    tuesday: reader.readLongList(offsets[5]) ?? const [],
    wednesday: reader.readLongList(offsets[6]) ?? const [],
  );
  return object;
}

P _weekDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset) ?? const []) as P;
    case 1:
      return (reader.readLongList(offset) ?? const []) as P;
    case 2:
      return (reader.readLongList(offset) ?? const []) as P;
    case 3:
      return (reader.readLongList(offset) ?? const []) as P;
    case 4:
      return (reader.readLongList(offset) ?? const []) as P;
    case 5:
      return (reader.readLongList(offset) ?? const []) as P;
    case 6:
      return (reader.readLongList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _weekGetId(Week object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _weekGetLinks(Week object) {
  return [];
}

void _weekAttach(IsarCollection<dynamic> col, Id id, Week object) {}

extension WeekQueryWhereSort on QueryBuilder<Week, Week, QWhere> {
  QueryBuilder<Week, Week, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WeekQueryWhere on QueryBuilder<Week, Week, QWhereClause> {
  QueryBuilder<Week, Week, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Week, Week, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Week, Week, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Week, Week, QAfterWhereClause> idBetween(
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

extension WeekQueryFilter on QueryBuilder<Week, Week, QFilterCondition> {
  QueryBuilder<Week, Week, QAfterFilterCondition> fridayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'friday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'friday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'friday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'friday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> fridayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'friday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Week, Week, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Week, Week, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'monday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'monday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'monday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'monday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> mondayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'monday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'saturday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'saturday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'saturday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'saturday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> saturdayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'saturday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sunday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sunday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sunday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sunday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> sundayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sunday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thursday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thursday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thursday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thursday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> thursdayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'thursday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tuesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tuesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tuesday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> tuesdayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tuesday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wednesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wednesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wednesday',
        value: value,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wednesday',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Week, Week, QAfterFilterCondition> wednesdayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'wednesday',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WeekQueryObject on QueryBuilder<Week, Week, QFilterCondition> {}

extension WeekQueryLinks on QueryBuilder<Week, Week, QFilterCondition> {}

extension WeekQuerySortBy on QueryBuilder<Week, Week, QSortBy> {}

extension WeekQuerySortThenBy on QueryBuilder<Week, Week, QSortThenBy> {
  QueryBuilder<Week, Week, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Week, Week, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension WeekQueryWhereDistinct on QueryBuilder<Week, Week, QDistinct> {
  QueryBuilder<Week, Week, QDistinct> distinctByFriday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'friday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctByMonday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'monday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctBySaturday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'saturday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctBySunday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sunday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctByThursday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thursday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctByTuesday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tuesday');
    });
  }

  QueryBuilder<Week, Week, QDistinct> distinctByWednesday() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wednesday');
    });
  }
}

extension WeekQueryProperty on QueryBuilder<Week, Week, QQueryProperty> {
  QueryBuilder<Week, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> fridayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'friday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> mondayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'monday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> saturdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'saturday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> sundayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sunday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> thursdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thursday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> tuesdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuesday');
    });
  }

  QueryBuilder<Week, List<int>, QQueryOperations> wednesdayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wednesday');
    });
  }
}
