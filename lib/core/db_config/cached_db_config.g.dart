// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'cached_db_config.dart';
//
// // ignore_for_file: type=lint
// class $MediaListTableTable extends MediaListTable
//     with TableInfo<$MediaListTableTable, mediaListTable> {
//   @override
//   final GeneratedDatabase attachedDatabase;
//   final String? _alias;
//   $MediaListTableTable(this.attachedDatabase, [this._alias]);
//   static const VerificationMeta _idMeta = const VerificationMeta('id');
//   @override
//   late final GeneratedColumn<int> id = GeneratedColumn<int>(
//       'id', aliasedName, false,
//       hasAutoIncrement: true,
//       type: DriftSqlType.int,
//       requiredDuringInsert: false,
//       defaultConstraints:
//           GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
//   static const VerificationMeta _dataMeta = const VerificationMeta('data');
//   @override
//   late final GeneratedColumn<String> data = GeneratedColumn<String>(
//       'data', aliasedName, false,
//       type: DriftSqlType.string, requiredDuringInsert: true);
//   @override
//   List<GeneratedColumn> get $columns => [id, data];
//   @override
//   String get aliasedName => _alias ?? actualTableName;
//   @override
//   String get actualTableName => $name;
//   static const String $name = 'media_list_table';
//   @override
//   VerificationContext validateIntegrity(Insertable<mediaListTable> instance,
//       {bool isInserting = false}) {
//     final context = VerificationContext();
//     final data = instance.toColumns(true);
//     if (data.containsKey('id')) {
//       context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
//     }
//     if (data.containsKey('data')) {
//       context.handle(
//           _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
//     } else if (isInserting) {
//       context.missing(_dataMeta);
//     }
//     return context;
//   }
//
//   @override
//   Set<GeneratedColumn> get $primaryKey => {id};
//   @override
//   mediaListTable map(Map<String, dynamic> data, {String? tablePrefix}) {
//     final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
//     return mediaListTable(
//       id: attachedDatabase.typeMapping
//           .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
//       data: attachedDatabase.typeMapping
//           .read(DriftSqlType.string, data['${effectivePrefix}data'])!,
//     );
//   }
//
//   @override
//   $MediaListTableTable createAlias(String alias) {
//     return $MediaListTableTable(attachedDatabase, alias);
//   }
// }
//
// class mediaListTable extends DataClass implements Insertable<mediaListTable> {
//   final int id;
//   final String data;
//   const mediaListTable({required this.id, required this.data});
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     map['id'] = Variable<int>(id);
//     map['data'] = Variable<String>(data);
//     return map;
//   }
//
//   MediaListTableCompanion toCompanion(bool nullToAbsent) {
//     return MediaListTableCompanion(
//       id: Value(id),
//       data: Value(data),
//     );
//   }
//
//   factory mediaListTable.fromJson(Map<String, dynamic> json,
//       {ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return mediaListTable(
//       id: serializer.fromJson<int>(json['id']),
//       data: serializer.fromJson<String>(json['data']),
//     );
//   }
//   @override
//   Map<String, dynamic> toJson({ValueSerializer? serializer}) {
//     serializer ??= driftRuntimeOptions.defaultSerializer;
//     return <String, dynamic>{
//       'id': serializer.toJson<int>(id),
//       'data': serializer.toJson<String>(data),
//     };
//   }
//
//   mediaListTable copyWith({int? id, String? data}) => mediaListTable(
//         id: id ?? this.id,
//         data: data ?? this.data,
//       );
//   mediaListTable copyWithCompanion(MediaListTableCompanion data) {
//     return mediaListTable(
//       id: data.id.present ? data.id.value : this.id,
//       data: data.data.present ? data.data.value : this.data,
//     );
//   }
//
//   @override
//   String toString() {
//     return (StringBuffer('mediaListTable(')
//           ..write('id: $id, ')
//           ..write('data: $data')
//           ..write(')'))
//         .toString();
//   }
//
//   @override
//   int get hashCode => Object.hash(id, data);
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is mediaListTable &&
//           other.id == this.id &&
//           other.data == this.data);
// }
//
// class MediaListTableCompanion extends UpdateCompanion<mediaListTable> {
//   final Value<int> id;
//   final Value<String> data;
//   const MediaListTableCompanion({
//     this.id = const Value.absent(),
//     this.data = const Value.absent(),
//   });
//   MediaListTableCompanion.insert({
//     this.id = const Value.absent(),
//     required String data,
//   }) : data = Value(data);
//   static Insertable<mediaListTable> custom({
//     Expression<int>? id,
//     Expression<String>? data,
//   }) {
//     return RawValuesInsertable({
//       if (id != null) 'id': id,
//       if (data != null) 'data': data,
//     });
//   }
//
//   MediaListTableCompanion copyWith({Value<int>? id, Value<String>? data}) {
//     return MediaListTableCompanion(
//       id: id ?? this.id,
//       data: data ?? this.data,
//     );
//   }
//
//   @override
//   Map<String, Expression> toColumns(bool nullToAbsent) {
//     final map = <String, Expression>{};
//     if (id.present) {
//       map['id'] = Variable<int>(id.value);
//     }
//     if (data.present) {
//       map['data'] = Variable<String>(data.value);
//     }
//     return map;
//   }
//
//   @override
//   String toString() {
//     return (StringBuffer('MediaListTableCompanion(')
//           ..write('id: $id, ')
//           ..write('data: $data')
//           ..write(')'))
//         .toString();
//   }
// }
//
// abstract class _$Database extends GeneratedDatabase {
//   _$Database(QueryExecutor e) : super(e);
//   $DatabaseManager get managers => $DatabaseManager(this);
//   late final $MediaListTableTable mediaListTable = $MediaListTableTable(this);
//   @override
//   Iterable<TableInfo<Table, Object?>> get allTables =>
//       allSchemaEntities.whereType<TableInfo<Table, Object?>>();
//   @override
//   List<DatabaseSchemaEntity> get allSchemaEntities => [mediaListTable];
// }
//
// typedef $$MediaListTableTableCreateCompanionBuilder = MediaListTableCompanion
//     Function({
//   Value<int> id,
//   required String data,
// });
// typedef $$MediaListTableTableUpdateCompanionBuilder = MediaListTableCompanion
//     Function({
//   Value<int> id,
//   Value<String> data,
// });
//
// class $$MediaListTableTableFilterComposer
//     extends Composer<_$Database, $MediaListTableTable> {
//   $$MediaListTableTableFilterComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnFilters<int> get id => $composableBuilder(
//       column: $table.id, builder: (column) => ColumnFilters(column));
//
//   ColumnFilters<String> get data => $composableBuilder(
//       column: $table.data, builder: (column) => ColumnFilters(column));
// }
//
// class $$MediaListTableTableOrderingComposer
//     extends Composer<_$Database, $MediaListTableTable> {
//   $$MediaListTableTableOrderingComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   ColumnOrderings<int> get id => $composableBuilder(
//       column: $table.id, builder: (column) => ColumnOrderings(column));
//
//   ColumnOrderings<String> get data => $composableBuilder(
//       column: $table.data, builder: (column) => ColumnOrderings(column));
// }
//
// class $$MediaListTableTableAnnotationComposer
//     extends Composer<_$Database, $MediaListTableTable> {
//   $$MediaListTableTableAnnotationComposer({
//     required super.$db,
//     required super.$table,
//     super.joinBuilder,
//     super.$addJoinBuilderToRootComposer,
//     super.$removeJoinBuilderFromRootComposer,
//   });
//   GeneratedColumn<int> get id =>
//       $composableBuilder(column: $table.id, builder: (column) => column);
//
//   GeneratedColumn<String> get data =>
//       $composableBuilder(column: $table.data, builder: (column) => column);
// }
//
// class $$MediaListTableTableTableManager extends RootTableManager<
//     _$Database,
//     $MediaListTableTable,
//     mediaListTable,
//     $$MediaListTableTableFilterComposer,
//     $$MediaListTableTableOrderingComposer,
//     $$MediaListTableTableAnnotationComposer,
//     $$MediaListTableTableCreateCompanionBuilder,
//     $$MediaListTableTableUpdateCompanionBuilder,
//     (
//       mediaListTable,
//       BaseReferences<_$Database, $MediaListTableTable, mediaListTable>
//     ),
//     mediaListTable,
//     PrefetchHooks Function()> {
//   $$MediaListTableTableTableManager(_$Database db, $MediaListTableTable table)
//       : super(TableManagerState(
//           db: db,
//           table: table,
//           createFilteringComposer: () =>
//               $$MediaListTableTableFilterComposer($db: db, $table: table),
//           createOrderingComposer: () =>
//               $$MediaListTableTableOrderingComposer($db: db, $table: table),
//           createComputedFieldComposer: () =>
//               $$MediaListTableTableAnnotationComposer($db: db, $table: table),
//           updateCompanionCallback: ({
//             Value<int> id = const Value.absent(),
//             Value<String> data = const Value.absent(),
//           }) =>
//               MediaListTableCompanion(
//             id: id,
//             data: data,
//           ),
//           createCompanionCallback: ({
//             Value<int> id = const Value.absent(),
//             required String data,
//           }) =>
//               MediaListTableCompanion.insert(
//             id: id,
//             data: data,
//           ),
//           withReferenceMapper: (p0) => p0
//               .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
//               .toList(),
//           prefetchHooksCallback: null,
//         ));
// }
//
// typedef $$MediaListTableTableProcessedTableManager = ProcessedTableManager<
//     _$Database,
//     $MediaListTableTable,
//     mediaListTable,
//     $$MediaListTableTableFilterComposer,
//     $$MediaListTableTableOrderingComposer,
//     $$MediaListTableTableAnnotationComposer,
//     $$MediaListTableTableCreateCompanionBuilder,
//     $$MediaListTableTableUpdateCompanionBuilder,
//     (
//       mediaListTable,
//       BaseReferences<_$Database, $MediaListTableTable, mediaListTable>
//     ),
//     mediaListTable,
//     PrefetchHooks Function()>;
//
// class $DatabaseManager {
//   final _$Database _db;
//   $DatabaseManager(this._db);
//   $$MediaListTableTableTableManager get mediaListTable =>
//       $$MediaListTableTableTableManager(_db, _db.mediaListTable);
// }
