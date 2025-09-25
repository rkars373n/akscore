// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMatchCollection on Isar {
  IsarCollection<Match> get matchs => this.collection();
}

const MatchSchema = CollectionSchema(
  name: r'Match',
  id: -4384922031457139852,
  properties: {
    r'events': PropertySchema(
      id: 0,
      name: r'events',
      type: IsarType.objectList,
      target: r'MatchEvent',
    ),
    r'goalsAway': PropertySchema(
      id: 1,
      name: r'goalsAway',
      type: IsarType.long,
    ),
    r'goalsHome': PropertySchema(
      id: 2,
      name: r'goalsHome',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'isLive': PropertySchema(
      id: 4,
      name: r'isLive',
      type: IsarType.bool,
    ),
    r'league': PropertySchema(
      id: 5,
      name: r'league',
      type: IsarType.string,
    ),
    r'leagueLogo': PropertySchema(
      id: 6,
      name: r'leagueLogo',
      type: IsarType.string,
    ),
    r'matchTime': PropertySchema(
      id: 7,
      name: r'matchTime',
      type: IsarType.dateTime,
    ),
    r'minute': PropertySchema(
      id: 8,
      name: r'minute',
      type: IsarType.long,
    ),
    r'referee': PropertySchema(
      id: 9,
      name: r'referee',
      type: IsarType.string,
    ),
    r'statistics': PropertySchema(
      id: 10,
      name: r'statistics',
      type: IsarType.object,
      target: r'MatchStatistics',
    ),
    r'status': PropertySchema(
      id: 11,
      name: r'status',
      type: IsarType.string,
    ),
    r'venue': PropertySchema(
      id: 12,
      name: r'venue',
      type: IsarType.string,
    )
  },
  estimateSize: _matchEstimateSize,
  serialize: _matchSerialize,
  deserialize: _matchDeserialize,
  deserializeProp: _matchDeserializeProp,
  idName: r'dbId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'homeTeam': LinkSchema(
      id: 4678994681383155813,
      name: r'homeTeam',
      target: r'Team',
      single: true,
    ),
    r'awayTeam': LinkSchema(
      id: -1283818091899375020,
      name: r'awayTeam',
      target: r'Team',
      single: true,
    )
  },
  embeddedSchemas: {
    r'MatchEvent': MatchEventSchema,
    r'MatchStatistics': MatchStatisticsSchema
  },
  getId: _matchGetId,
  getLinks: _matchGetLinks,
  attach: _matchAttach,
  version: '3.1.0+1',
);

int _matchEstimateSize(
  Match object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.events.length * 3;
  {
    final offsets = allOffsets[MatchEvent]!;
    for (var i = 0; i < object.events.length; i++) {
      final value = object.events[i];
      bytesCount += MatchEventSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.league.length * 3;
  bytesCount += 3 + object.leagueLogo.length * 3;
  bytesCount += 3 + object.referee.length * 3;
  bytesCount += 3 +
      MatchStatisticsSchema.estimateSize(
          object.statistics, allOffsets[MatchStatistics]!, allOffsets);
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.venue.length * 3;
  return bytesCount;
}

void _matchSerialize(
  Match object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<MatchEvent>(
    offsets[0],
    allOffsets,
    MatchEventSchema.serialize,
    object.events,
  );
  writer.writeLong(offsets[1], object.goalsAway);
  writer.writeLong(offsets[2], object.goalsHome);
  writer.writeString(offsets[3], object.id);
  writer.writeBool(offsets[4], object.isLive);
  writer.writeString(offsets[5], object.league);
  writer.writeString(offsets[6], object.leagueLogo);
  writer.writeDateTime(offsets[7], object.matchTime);
  writer.writeLong(offsets[8], object.minute);
  writer.writeString(offsets[9], object.referee);
  writer.writeObject<MatchStatistics>(
    offsets[10],
    allOffsets,
    MatchStatisticsSchema.serialize,
    object.statistics,
  );
  writer.writeString(offsets[11], object.status);
  writer.writeString(offsets[12], object.venue);
}

Match _matchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Match();
  object.dbId = id;
  object.goalsAway = reader.readLong(offsets[1]);
  object.goalsHome = reader.readLong(offsets[2]);
  object.id = reader.readString(offsets[3]);
  object.isLive = reader.readBool(offsets[4]);
  object.league = reader.readString(offsets[5]);
  object.leagueLogo = reader.readString(offsets[6]);
  object.matchTime = reader.readDateTime(offsets[7]);
  object.minute = reader.readLongOrNull(offsets[8]);
  object.referee = reader.readString(offsets[9]);
  object.status = reader.readString(offsets[11]);
  object.venue = reader.readString(offsets[12]);
  return object;
}

P _matchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<MatchEvent>(
            offset,
            MatchEventSchema.deserialize,
            allOffsets,
            MatchEvent(),
          ) ??
          []) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readObjectOrNull<MatchStatistics>(
            offset,
            MatchStatisticsSchema.deserialize,
            allOffsets,
          ) ??
          MatchStatistics()) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _matchGetId(Match object) {
  return object.dbId;
}

List<IsarLinkBase<dynamic>> _matchGetLinks(Match object) {
  return [object.homeTeam, object.awayTeam];
}

void _matchAttach(IsarCollection<dynamic> col, Id id, Match object) {
  object.dbId = id;
  object.homeTeam.attach(col, col.isar.collection<Team>(), r'homeTeam', id);
  object.awayTeam.attach(col, col.isar.collection<Team>(), r'awayTeam', id);
}

extension MatchByIndex on IsarCollection<Match> {
  Future<Match?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  Match? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<Match?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<Match?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(Match object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(Match object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<Match> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<Match> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension MatchQueryWhereSort on QueryBuilder<Match, Match, QWhere> {
  QueryBuilder<Match, Match, QAfterWhere> anyDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MatchQueryWhere on QueryBuilder<Match, Match, QWhereClause> {
  QueryBuilder<Match, Match, QAfterWhereClause> dbIdEqualTo(Id dbId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: dbId,
        upper: dbId,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> dbIdNotEqualTo(Id dbId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: dbId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: dbId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: dbId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: dbId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> dbIdGreaterThan(Id dbId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: dbId, includeLower: include),
      );
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> dbIdLessThan(Id dbId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: dbId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> dbIdBetween(
    Id lowerDbId,
    Id upperDbId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerDbId,
        includeLower: includeLower,
        upper: upperDbId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterWhereClause> idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MatchQueryFilter on QueryBuilder<Match, Match, QFilterCondition> {
  QueryBuilder<Match, Match, QAfterFilterCondition> dbIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dbId',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> dbIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dbId',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> dbIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dbId',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> dbIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dbId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> eventsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'events',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsAwayEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsAwayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsAwayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsAwayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsHomeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsHomeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsHomeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> goalsHomeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> isLiveEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isLive',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'league',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'league',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'league',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'league',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'league',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leagueLogo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'leagueLogo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'leagueLogo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leagueLogo',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> leagueLogoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'leagueLogo',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> matchTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> matchTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> matchTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchTime',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> matchTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minute',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minute',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> minuteBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'referee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'referee',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'referee',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'referee',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> refereeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'referee',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'venue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'venue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'venue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'venue',
        value: '',
      ));
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> venueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'venue',
        value: '',
      ));
    });
  }
}

extension MatchQueryObject on QueryBuilder<Match, Match, QFilterCondition> {
  QueryBuilder<Match, Match, QAfterFilterCondition> eventsElement(
      FilterQuery<MatchEvent> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'events');
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> statistics(
      FilterQuery<MatchStatistics> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'statistics');
    });
  }
}

extension MatchQueryLinks on QueryBuilder<Match, Match, QFilterCondition> {
  QueryBuilder<Match, Match, QAfterFilterCondition> homeTeam(
      FilterQuery<Team> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'homeTeam');
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> homeTeamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'homeTeam', 0, true, 0, true);
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> awayTeam(
      FilterQuery<Team> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'awayTeam');
    });
  }

  QueryBuilder<Match, Match, QAfterFilterCondition> awayTeamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'awayTeam', 0, true, 0, true);
    });
  }
}

extension MatchQuerySortBy on QueryBuilder<Match, Match, QSortBy> {
  QueryBuilder<Match, Match, QAfterSortBy> sortByGoalsAway() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAway', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByGoalsAwayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAway', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByGoalsHome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsHome', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByGoalsHomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsHome', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByLeague() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'league', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByLeagueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'league', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByLeagueLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueLogo', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByLeagueLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueLogo', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByMatchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByMatchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByReferee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referee', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByRefereeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referee', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByVenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'venue', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> sortByVenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'venue', Sort.desc);
    });
  }
}

extension MatchQuerySortThenBy on QueryBuilder<Match, Match, QSortThenBy> {
  QueryBuilder<Match, Match, QAfterSortBy> thenByDbId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbId', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByDbIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dbId', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByGoalsAway() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAway', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByGoalsAwayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsAway', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByGoalsHome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsHome', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByGoalsHomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsHome', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByIsLiveDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isLive', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByLeague() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'league', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByLeagueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'league', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByLeagueLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueLogo', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByLeagueLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leagueLogo', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByMatchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByMatchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByMinuteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'minute', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByReferee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referee', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByRefereeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'referee', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByVenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'venue', Sort.asc);
    });
  }

  QueryBuilder<Match, Match, QAfterSortBy> thenByVenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'venue', Sort.desc);
    });
  }
}

extension MatchQueryWhereDistinct on QueryBuilder<Match, Match, QDistinct> {
  QueryBuilder<Match, Match, QDistinct> distinctByGoalsAway() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsAway');
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByGoalsHome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsHome');
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByIsLive() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isLive');
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByLeague(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'league', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByLeagueLogo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leagueLogo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByMatchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchTime');
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByMinute() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'minute');
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByReferee(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'referee', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Match, Match, QDistinct> distinctByVenue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'venue', caseSensitive: caseSensitive);
    });
  }
}

extension MatchQueryProperty on QueryBuilder<Match, Match, QQueryProperty> {
  QueryBuilder<Match, int, QQueryOperations> dbIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dbId');
    });
  }

  QueryBuilder<Match, List<MatchEvent>, QQueryOperations> eventsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'events');
    });
  }

  QueryBuilder<Match, int, QQueryOperations> goalsAwayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsAway');
    });
  }

  QueryBuilder<Match, int, QQueryOperations> goalsHomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsHome');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Match, bool, QQueryOperations> isLiveProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isLive');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> leagueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'league');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> leagueLogoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leagueLogo');
    });
  }

  QueryBuilder<Match, DateTime, QQueryOperations> matchTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchTime');
    });
  }

  QueryBuilder<Match, int?, QQueryOperations> minuteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'minute');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> refereeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'referee');
    });
  }

  QueryBuilder<Match, MatchStatistics, QQueryOperations> statisticsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statistics');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Match, String, QQueryOperations> venueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'venue');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MatchStatisticsSchema = Schema(
  name: r'MatchStatistics',
  id: 217079359408199617,
  properties: {
    r'foulsAway': PropertySchema(
      id: 0,
      name: r'foulsAway',
      type: IsarType.long,
    ),
    r'foulsHome': PropertySchema(
      id: 1,
      name: r'foulsHome',
      type: IsarType.long,
    ),
    r'passesAway': PropertySchema(
      id: 2,
      name: r'passesAway',
      type: IsarType.long,
    ),
    r'passesHome': PropertySchema(
      id: 3,
      name: r'passesHome',
      type: IsarType.long,
    ),
    r'possessionAway': PropertySchema(
      id: 4,
      name: r'possessionAway',
      type: IsarType.long,
    ),
    r'possessionHome': PropertySchema(
      id: 5,
      name: r'possessionHome',
      type: IsarType.long,
    ),
    r'redCardsAway': PropertySchema(
      id: 6,
      name: r'redCardsAway',
      type: IsarType.long,
    ),
    r'redCardsHome': PropertySchema(
      id: 7,
      name: r'redCardsHome',
      type: IsarType.long,
    ),
    r'shotsAway': PropertySchema(
      id: 8,
      name: r'shotsAway',
      type: IsarType.long,
    ),
    r'shotsHome': PropertySchema(
      id: 9,
      name: r'shotsHome',
      type: IsarType.long,
    ),
    r'shotsOnTargetAway': PropertySchema(
      id: 10,
      name: r'shotsOnTargetAway',
      type: IsarType.long,
    ),
    r'shotsOnTargetHome': PropertySchema(
      id: 11,
      name: r'shotsOnTargetHome',
      type: IsarType.long,
    ),
    r'yellowCardsAway': PropertySchema(
      id: 12,
      name: r'yellowCardsAway',
      type: IsarType.long,
    ),
    r'yellowCardsHome': PropertySchema(
      id: 13,
      name: r'yellowCardsHome',
      type: IsarType.long,
    )
  },
  estimateSize: _matchStatisticsEstimateSize,
  serialize: _matchStatisticsSerialize,
  deserialize: _matchStatisticsDeserialize,
  deserializeProp: _matchStatisticsDeserializeProp,
);

int _matchStatisticsEstimateSize(
  MatchStatistics object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _matchStatisticsSerialize(
  MatchStatistics object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.foulsAway);
  writer.writeLong(offsets[1], object.foulsHome);
  writer.writeLong(offsets[2], object.passesAway);
  writer.writeLong(offsets[3], object.passesHome);
  writer.writeLong(offsets[4], object.possessionAway);
  writer.writeLong(offsets[5], object.possessionHome);
  writer.writeLong(offsets[6], object.redCardsAway);
  writer.writeLong(offsets[7], object.redCardsHome);
  writer.writeLong(offsets[8], object.shotsAway);
  writer.writeLong(offsets[9], object.shotsHome);
  writer.writeLong(offsets[10], object.shotsOnTargetAway);
  writer.writeLong(offsets[11], object.shotsOnTargetHome);
  writer.writeLong(offsets[12], object.yellowCardsAway);
  writer.writeLong(offsets[13], object.yellowCardsHome);
}

MatchStatistics _matchStatisticsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MatchStatistics();
  object.foulsAway = reader.readLongOrNull(offsets[0]);
  object.foulsHome = reader.readLongOrNull(offsets[1]);
  object.passesAway = reader.readLongOrNull(offsets[2]);
  object.passesHome = reader.readLongOrNull(offsets[3]);
  object.possessionAway = reader.readLongOrNull(offsets[4]);
  object.possessionHome = reader.readLongOrNull(offsets[5]);
  object.redCardsAway = reader.readLongOrNull(offsets[6]);
  object.redCardsHome = reader.readLongOrNull(offsets[7]);
  object.shotsAway = reader.readLongOrNull(offsets[8]);
  object.shotsHome = reader.readLongOrNull(offsets[9]);
  object.shotsOnTargetAway = reader.readLongOrNull(offsets[10]);
  object.shotsOnTargetHome = reader.readLongOrNull(offsets[11]);
  object.yellowCardsAway = reader.readLongOrNull(offsets[12]);
  object.yellowCardsHome = reader.readLongOrNull(offsets[13]);
  return object;
}

P _matchStatisticsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MatchStatisticsQueryFilter
    on QueryBuilder<MatchStatistics, MatchStatistics, QFilterCondition> {
  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foulsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foulsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foulsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foulsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foulsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foulsAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'foulsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'foulsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'foulsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'foulsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'foulsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      foulsHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'foulsHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passesAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passesAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passesAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passesAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passesAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passesAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passesHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passesHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passesHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passesHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passesHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      passesHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passesHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'possessionAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'possessionAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'possessionAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'possessionAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'possessionAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'possessionAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'possessionHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'possessionHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'possessionHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'possessionHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'possessionHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      possessionHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'possessionHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'redCardsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'redCardsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'redCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'redCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'redCardsAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'redCardsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'redCardsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'redCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'redCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      redCardsHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'redCardsHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shotsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shotsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shotsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shotsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shotsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shotsAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shotsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shotsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shotsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shotsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shotsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shotsHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shotsOnTargetAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shotsOnTargetAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shotsOnTargetAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shotsOnTargetAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shotsOnTargetAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shotsOnTargetAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shotsOnTargetHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shotsOnTargetHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shotsOnTargetHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shotsOnTargetHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shotsOnTargetHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      shotsOnTargetHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shotsOnTargetHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'yellowCardsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'yellowCardsAway',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yellowCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yellowCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yellowCardsAway',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsAwayBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yellowCardsAway',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'yellowCardsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'yellowCardsHome',
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yellowCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yellowCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yellowCardsHome',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchStatistics, MatchStatistics, QAfterFilterCondition>
      yellowCardsHomeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yellowCardsHome',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MatchStatisticsQueryObject
    on QueryBuilder<MatchStatistics, MatchStatistics, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MatchEventSchema = Schema(
  name: r'MatchEvent',
  id: -7086091129978520178,
  properties: {
    r'assist': PropertySchema(
      id: 0,
      name: r'assist',
      type: IsarType.string,
    ),
    r'minute': PropertySchema(
      id: 1,
      name: r'minute',
      type: IsarType.long,
    ),
    r'player': PropertySchema(
      id: 2,
      name: r'player',
      type: IsarType.string,
    ),
    r'teamName': PropertySchema(
      id: 3,
      name: r'teamName',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 4,
      name: r'type',
      type: IsarType.string,
      enumMap: _MatchEventtypeEnumValueMap,
    )
  },
  estimateSize: _matchEventEstimateSize,
  serialize: _matchEventSerialize,
  deserialize: _matchEventDeserialize,
  deserializeProp: _matchEventDeserializeProp,
);

int _matchEventEstimateSize(
  MatchEvent object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.assist;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.player;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.teamName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _matchEventSerialize(
  MatchEvent object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.assist);
  writer.writeLong(offsets[1], object.minute);
  writer.writeString(offsets[2], object.player);
  writer.writeString(offsets[3], object.teamName);
  writer.writeString(offsets[4], object.type?.name);
}

MatchEvent _matchEventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MatchEvent();
  object.assist = reader.readStringOrNull(offsets[0]);
  object.minute = reader.readLongOrNull(offsets[1]);
  object.player = reader.readStringOrNull(offsets[2]);
  object.teamName = reader.readStringOrNull(offsets[3]);
  object.type =
      _MatchEventtypeValueEnumMap[reader.readStringOrNull(offsets[4])];
  return object;
}

P _matchEventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (_MatchEventtypeValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MatchEventtypeEnumValueMap = {
  r'goal': r'goal',
  r'yellowCard': r'yellowCard',
  r'redCard': r'redCard',
  r'substitution': r'substitution',
};
const _MatchEventtypeValueEnumMap = {
  r'goal': MatchEventType.goal,
  r'yellowCard': MatchEventType.yellowCard,
  r'redCard': MatchEventType.redCard,
  r'substitution': MatchEventType.substitution,
};

extension MatchEventQueryFilter
    on QueryBuilder<MatchEvent, MatchEvent, QFilterCondition> {
  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assist',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      assistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assist',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assist',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assist',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> assistIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assist',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      assistIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assist',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> minuteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'minute',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      minuteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'minute',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> minuteEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> minuteGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> minuteLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> minuteBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'player',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      playerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'player',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'player',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'player',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'player',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> playerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'player',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      playerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'player',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamName',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      teamNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamName',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      teamNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      teamNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'teamName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> teamNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'teamName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      teamNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamName',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition>
      teamNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'teamName',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeEqualTo(
    MatchEventType? value, {
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeGreaterThan(
    MatchEventType? value, {
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeLessThan(
    MatchEventType? value, {
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeBetween(
    MatchEventType? lower,
    MatchEventType? upper, {
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeStartsWith(
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<MatchEvent, MatchEvent, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension MatchEventQueryObject
    on QueryBuilder<MatchEvent, MatchEvent, QFilterCondition> {}
