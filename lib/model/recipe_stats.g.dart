// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_stats.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecipeStatsCollection on Isar {
  IsarCollection<RecipeStats> get recipeStats => this.collection();
}

const RecipeStatsSchema = CollectionSchema(
  name: r'RecipeStats',
  id: 1315502612839844196,
  properties: {
    r'maxCalories': PropertySchema(
      id: 0,
      name: r'maxCalories',
      type: IsarType.double,
    ),
    r'maxMinutes': PropertySchema(
      id: 1,
      name: r'maxMinutes',
      type: IsarType.long,
    ),
    r'minCalories': PropertySchema(
      id: 2,
      name: r'minCalories',
      type: IsarType.double,
    ),
    r'minMinutes': PropertySchema(
      id: 3,
      name: r'minMinutes',
      type: IsarType.long,
    ),
    r'tags': PropertySchema(
      id: 4,
      name: r'tags',
      type: IsarType.stringList,
    )
  },
  estimateSize: _recipeStatsEstimateSize,
  serialize: _recipeStatsSerialize,
  deserialize: _recipeStatsDeserialize,
  deserializeProp: _recipeStatsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recipeStatsGetId,
  getLinks: _recipeStatsGetLinks,
  attach: _recipeStatsAttach,
  version: '3.1.0+1',
);

int _recipeStatsEstimateSize(
  RecipeStats object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _recipeStatsSerialize(
  RecipeStats object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.maxCalories);
  writer.writeLong(offsets[1], object.maxMinutes);
  writer.writeDouble(offsets[2], object.minCalories);
  writer.writeLong(offsets[3], object.minMinutes);
  writer.writeStringList(offsets[4], object.tags);
}

RecipeStats _recipeStatsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecipeStats(
    maxCalories: reader.readDouble(offsets[0]),
    maxMinutes: reader.readLong(offsets[1]),
    minCalories: reader.readDouble(offsets[2]),
    minMinutes: reader.readLong(offsets[3]),
    tags: reader.readStringList(offsets[4]) ?? [],
  );
  return object;
}

P _recipeStatsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recipeStatsGetId(RecipeStats object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recipeStatsGetLinks(RecipeStats object) {
  return [];
}

void _recipeStatsAttach(
    IsarCollection<dynamic> col, Id id, RecipeStats object) {}

extension RecipeStatsQueryWhereSort
    on QueryBuilder<RecipeStats, RecipeStats, QWhere> {
  QueryBuilder<RecipeStats, RecipeStats, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecipeStatsQueryWhere
    on QueryBuilder<RecipeStats, RecipeStats, QWhereClause> {
  QueryBuilder<RecipeStats, RecipeStats, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RecipeStats, RecipeStats, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterWhereClause> idBetween(
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

extension RecipeStatsQueryFilter
    on QueryBuilder<RecipeStats, RecipeStats, QFilterCondition> {
  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      maxMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minCaloriesEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minCaloriesGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minCaloriesLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minCalories',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minCaloriesBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      minMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RecipeStatsQueryObject
    on QueryBuilder<RecipeStats, RecipeStats, QFilterCondition> {}

extension RecipeStatsQueryLinks
    on QueryBuilder<RecipeStats, RecipeStats, QFilterCondition> {}

extension RecipeStatsQuerySortBy
    on QueryBuilder<RecipeStats, RecipeStats, QSortBy> {
  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMaxCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxCalories', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMaxCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxCalories', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMaxMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMinutes', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMaxMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMinutes', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMinCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minCalories', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMinCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minCalories', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMinMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMinutes', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> sortByMinMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMinutes', Sort.desc);
    });
  }
}

extension RecipeStatsQuerySortThenBy
    on QueryBuilder<RecipeStats, RecipeStats, QSortThenBy> {
  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMaxCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxCalories', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMaxCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxCalories', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMaxMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMinutes', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMaxMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMinutes', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMinCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minCalories', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMinCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minCalories', Sort.desc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMinMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMinutes', Sort.asc);
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QAfterSortBy> thenByMinMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minMinutes', Sort.desc);
    });
  }
}

extension RecipeStatsQueryWhereDistinct
    on QueryBuilder<RecipeStats, RecipeStats, QDistinct> {
  QueryBuilder<RecipeStats, RecipeStats, QDistinct> distinctByMaxCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxCalories');
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QDistinct> distinctByMaxMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxMinutes');
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QDistinct> distinctByMinCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minCalories');
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QDistinct> distinctByMinMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minMinutes');
    });
  }

  QueryBuilder<RecipeStats, RecipeStats, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }
}

extension RecipeStatsQueryProperty
    on QueryBuilder<RecipeStats, RecipeStats, QQueryProperty> {
  QueryBuilder<RecipeStats, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecipeStats, double, QQueryOperations> maxCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxCalories');
    });
  }

  QueryBuilder<RecipeStats, int, QQueryOperations> maxMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxMinutes');
    });
  }

  QueryBuilder<RecipeStats, double, QQueryOperations> minCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minCalories');
    });
  }

  QueryBuilder<RecipeStats, int, QQueryOperations> minMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minMinutes');
    });
  }

  QueryBuilder<RecipeStats, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }
}
