// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_database.dart';

// ignore_for_file: type=lint
class $AuthTableTable extends AuthTable
    with TableInfo<$AuthTableTable, AuthTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 1,
  );
  static const VerificationMeta _onboardingUserInfoCompleteMeta =
      const VerificationMeta('onboardingUserInfoComplete');
  @override
  late final GeneratedColumn<bool> onboardingUserInfoComplete =
      GeneratedColumn<bool>(
        'onboarding_user_info_complete',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_user_info_complete" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingUserInfoComplete,
    onboardingComplete,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_user_info_complete')) {
      context.handle(
        _onboardingUserInfoCompleteMeta,
        onboardingUserInfoComplete.isAcceptableOrUnknown(
          data['onboarding_user_info_complete']!,
          _onboardingUserInfoCompleteMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AuthTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      onboardingUserInfoComplete:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}onboarding_user_info_complete'],
          )!,
      onboardingComplete:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}onboarding_complete'],
          )!,
    );
  }

  @override
  $AuthTableTable createAlias(String alias) {
    return $AuthTableTable(attachedDatabase, alias);
  }
}

class AuthTableData extends DataClass implements Insertable<AuthTableData> {
  final int id;
  final bool onboardingUserInfoComplete;
  final bool onboardingComplete;
  const AuthTableData({
    required this.id,
    required this.onboardingUserInfoComplete,
    required this.onboardingComplete,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_user_info_complete'] = Variable<bool>(
      onboardingUserInfoComplete,
    );
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    return map;
  }

  AuthTableCompanion toCompanion(bool nullToAbsent) {
    return AuthTableCompanion(
      id: Value(id),
      onboardingUserInfoComplete: Value(onboardingUserInfoComplete),
      onboardingComplete: Value(onboardingComplete),
    );
  }

  factory AuthTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthTableData(
      id: serializer.fromJson<int>(json['id']),
      onboardingUserInfoComplete: serializer.fromJson<bool>(
        json['onboardingUserInfoComplete'],
      ),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingUserInfoComplete': serializer.toJson<bool>(
        onboardingUserInfoComplete,
      ),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
    };
  }

  AuthTableData copyWith({
    int? id,
    bool? onboardingUserInfoComplete,
    bool? onboardingComplete,
  }) => AuthTableData(
    id: id ?? this.id,
    onboardingUserInfoComplete:
        onboardingUserInfoComplete ?? this.onboardingUserInfoComplete,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
  );
  AuthTableData copyWithCompanion(AuthTableCompanion data) {
    return AuthTableData(
      id: data.id.present ? data.id.value : this.id,
      onboardingUserInfoComplete:
          data.onboardingUserInfoComplete.present
              ? data.onboardingUserInfoComplete.value
              : this.onboardingUserInfoComplete,
      onboardingComplete:
          data.onboardingComplete.present
              ? data.onboardingComplete.value
              : this.onboardingComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthTableData(')
          ..write('id: $id, ')
          ..write('onboardingUserInfoComplete: $onboardingUserInfoComplete, ')
          ..write('onboardingComplete: $onboardingComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, onboardingUserInfoComplete, onboardingComplete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthTableData &&
          other.id == this.id &&
          other.onboardingUserInfoComplete == this.onboardingUserInfoComplete &&
          other.onboardingComplete == this.onboardingComplete);
}

class AuthTableCompanion extends UpdateCompanion<AuthTableData> {
  final Value<int> id;
  final Value<bool> onboardingUserInfoComplete;
  final Value<bool> onboardingComplete;
  final Value<int> rowid;
  const AuthTableCompanion({
    this.id = const Value.absent(),
    this.onboardingUserInfoComplete = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthTableCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingUserInfoComplete = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AuthTableData> custom({
    Expression<int>? id,
    Expression<bool>? onboardingUserInfoComplete,
    Expression<bool>? onboardingComplete,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingUserInfoComplete != null)
        'onboarding_user_info_complete': onboardingUserInfoComplete,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthTableCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingUserInfoComplete,
    Value<bool>? onboardingComplete,
    Value<int>? rowid,
  }) {
    return AuthTableCompanion(
      id: id ?? this.id,
      onboardingUserInfoComplete:
          onboardingUserInfoComplete ?? this.onboardingUserInfoComplete,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingUserInfoComplete.present) {
      map['onboarding_user_info_complete'] = Variable<bool>(
        onboardingUserInfoComplete.value,
      );
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthTableCompanion(')
          ..write('id: $id, ')
          ..write('onboardingUserInfoComplete: $onboardingUserInfoComplete, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AuthDatabase extends GeneratedDatabase {
  _$AuthDatabase(QueryExecutor e) : super(e);
  $AuthDatabaseManager get managers => $AuthDatabaseManager(this);
  late final $AuthTableTable authTable = $AuthTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [authTable];
}

typedef $$AuthTableTableCreateCompanionBuilder =
    AuthTableCompanion Function({
      Value<int> id,
      Value<bool> onboardingUserInfoComplete,
      Value<bool> onboardingComplete,
      Value<int> rowid,
    });
typedef $$AuthTableTableUpdateCompanionBuilder =
    AuthTableCompanion Function({
      Value<int> id,
      Value<bool> onboardingUserInfoComplete,
      Value<bool> onboardingComplete,
      Value<int> rowid,
    });

class $$AuthTableTableFilterComposer
    extends Composer<_$AuthDatabase, $AuthTableTable> {
  $$AuthTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingUserInfoComplete => $composableBuilder(
    column: $table.onboardingUserInfoComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuthTableTableOrderingComposer
    extends Composer<_$AuthDatabase, $AuthTableTable> {
  $$AuthTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingUserInfoComplete => $composableBuilder(
    column: $table.onboardingUserInfoComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthTableTableAnnotationComposer
    extends Composer<_$AuthDatabase, $AuthTableTable> {
  $$AuthTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingUserInfoComplete => $composableBuilder(
    column: $table.onboardingUserInfoComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );
}

class $$AuthTableTableTableManager
    extends
        RootTableManager<
          _$AuthDatabase,
          $AuthTableTable,
          AuthTableData,
          $$AuthTableTableFilterComposer,
          $$AuthTableTableOrderingComposer,
          $$AuthTableTableAnnotationComposer,
          $$AuthTableTableCreateCompanionBuilder,
          $$AuthTableTableUpdateCompanionBuilder,
          (
            AuthTableData,
            BaseReferences<_$AuthDatabase, $AuthTableTable, AuthTableData>,
          ),
          AuthTableData,
          PrefetchHooks Function()
        > {
  $$AuthTableTableTableManager(_$AuthDatabase db, $AuthTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AuthTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AuthTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AuthTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingUserInfoComplete = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuthTableCompanion(
                id: id,
                onboardingUserInfoComplete: onboardingUserInfoComplete,
                onboardingComplete: onboardingComplete,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingUserInfoComplete = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuthTableCompanion.insert(
                id: id,
                onboardingUserInfoComplete: onboardingUserInfoComplete,
                onboardingComplete: onboardingComplete,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuthTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AuthDatabase,
      $AuthTableTable,
      AuthTableData,
      $$AuthTableTableFilterComposer,
      $$AuthTableTableOrderingComposer,
      $$AuthTableTableAnnotationComposer,
      $$AuthTableTableCreateCompanionBuilder,
      $$AuthTableTableUpdateCompanionBuilder,
      (
        AuthTableData,
        BaseReferences<_$AuthDatabase, $AuthTableTable, AuthTableData>,
      ),
      AuthTableData,
      PrefetchHooks Function()
    >;

class $AuthDatabaseManager {
  final _$AuthDatabase _db;
  $AuthDatabaseManager(this._db);
  $$AuthTableTableTableManager get authTable =>
      $$AuthTableTableTableManager(_db, _db.authTable);
}
