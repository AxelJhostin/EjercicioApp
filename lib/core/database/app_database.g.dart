// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppMetadataTable extends AppMetadata
    with TableInfo<$AppMetadataTable, AppMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [name, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  AppMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetadataData(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetadataTable createAlias(String alias) {
    return $AppMetadataTable(attachedDatabase, alias);
  }
}

class AppMetadataData extends DataClass implements Insertable<AppMetadataData> {
  final String name;
  final String value;
  const AppMetadataData({required this.name, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetadataCompanion toCompanion(bool nullToAbsent) {
    return AppMetadataCompanion(name: Value(name), value: Value(value));
  }

  factory AppMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetadataData(
      name: serializer.fromJson<String>(json['name']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetadataData copyWith({String? name, String? value}) =>
      AppMetadataData(name: name ?? this.name, value: value ?? this.value);
  AppMetadataData copyWithCompanion(AppMetadataCompanion data) {
    return AppMetadataData(
      name: data.name.present ? data.name.value : this.name,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataData(')
          ..write('name: $name, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetadataData &&
          other.name == this.name &&
          other.value == this.value);
}

class AppMetadataCompanion extends UpdateCompanion<AppMetadataData> {
  final Value<String> name;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetadataCompanion({
    this.name = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetadataCompanion.insert({
    required String name,
    required String value,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       value = Value(value);
  static Insertable<AppMetadataData> custom({
    Expression<String>? name,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetadataCompanion copyWith({
    Value<String>? name,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetadataCompanion(
      name: name ?? this.name,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataCompanion(')
          ..write('name: $name, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('id = 1'),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _initialWeightKgMeta = const VerificationMeta(
    'initialWeightKg',
  );
  @override
  late final GeneratedColumn<double> initialWeightKg = GeneratedColumn<double>(
    'initial_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preferredDurationMinutesMeta =
      const VerificationMeta('preferredDurationMinutes');
  @override
  late final GeneratedColumn<int> preferredDurationMinutes =
      GeneratedColumn<int>(
        'preferred_duration_minutes',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtUtcMeta = const VerificationMeta(
    'updatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtUtc = GeneratedColumn<DateTime>(
    'updated_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    age,
    heightCm,
    initialWeightKg,
    goal,
    level,
    preferredDurationMinutes,
    onboardingCompleted,
    createdAtUtc,
    updatedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('initial_weight_kg')) {
      context.handle(
        _initialWeightKgMeta,
        initialWeightKg.isAcceptableOrUnknown(
          data['initial_weight_kg']!,
          _initialWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('preferred_duration_minutes')) {
      context.handle(
        _preferredDurationMinutesMeta,
        preferredDurationMinutes.isAcceptableOrUnknown(
          data['preferred_duration_minutes']!,
          _preferredDurationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_preferredDurationMinutesMeta);
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_onboardingCompletedMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
        _updatedAtUtcMeta,
        updatedAtUtc.isAcceptableOrUnknown(
          data['updated_at_utc']!,
          _updatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      initialWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_weight_kg'],
      ),
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      preferredDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preferred_duration_minutes'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      updatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_utc'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final int id;
  final String? displayName;
  final int? age;
  final double? heightCm;
  final double? initialWeightKg;
  final String goal;
  final String level;
  final int preferredDurationMinutes;
  final bool onboardingCompleted;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
  const UserProfileRow({
    required this.id,
    this.displayName,
    this.age,
    this.heightCm,
    this.initialWeightKg,
    required this.goal,
    required this.level,
    required this.preferredDurationMinutes,
    required this.onboardingCompleted,
    required this.createdAtUtc,
    required this.updatedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || initialWeightKg != null) {
      map['initial_weight_kg'] = Variable<double>(initialWeightKg);
    }
    map['goal'] = Variable<String>(goal);
    map['level'] = Variable<String>(level);
    map['preferred_duration_minutes'] = Variable<int>(preferredDurationMinutes);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      initialWeightKg: initialWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(initialWeightKg),
      goal: Value(goal),
      level: Value(level),
      preferredDurationMinutes: Value(preferredDurationMinutes),
      onboardingCompleted: Value(onboardingCompleted),
      createdAtUtc: Value(createdAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
    );
  }

  factory UserProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      age: serializer.fromJson<int?>(json['age']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      initialWeightKg: serializer.fromJson<double?>(json['initialWeightKg']),
      goal: serializer.fromJson<String>(json['goal']),
      level: serializer.fromJson<String>(json['level']),
      preferredDurationMinutes: serializer.fromJson<int>(
        json['preferredDurationMinutes'],
      ),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      updatedAtUtc: serializer.fromJson<DateTime>(json['updatedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'age': serializer.toJson<int?>(age),
      'heightCm': serializer.toJson<double?>(heightCm),
      'initialWeightKg': serializer.toJson<double?>(initialWeightKg),
      'goal': serializer.toJson<String>(goal),
      'level': serializer.toJson<String>(level),
      'preferredDurationMinutes': serializer.toJson<int>(
        preferredDurationMinutes,
      ),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'updatedAtUtc': serializer.toJson<DateTime>(updatedAtUtc),
    };
  }

  UserProfileRow copyWith({
    int? id,
    Value<String?> displayName = const Value.absent(),
    Value<int?> age = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> initialWeightKg = const Value.absent(),
    String? goal,
    String? level,
    int? preferredDurationMinutes,
    bool? onboardingCompleted,
    DateTime? createdAtUtc,
    DateTime? updatedAtUtc,
  }) => UserProfileRow(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    age: age.present ? age.value : this.age,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    initialWeightKg: initialWeightKg.present
        ? initialWeightKg.value
        : this.initialWeightKg,
    goal: goal ?? this.goal,
    level: level ?? this.level,
    preferredDurationMinutes:
        preferredDurationMinutes ?? this.preferredDurationMinutes,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
  );
  UserProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      age: data.age.present ? data.age.value : this.age,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      initialWeightKg: data.initialWeightKg.present
          ? data.initialWeightKg.value
          : this.initialWeightKg,
      goal: data.goal.present ? data.goal.value : this.goal,
      level: data.level.present ? data.level.value : this.level,
      preferredDurationMinutes: data.preferredDurationMinutes.present
          ? data.preferredDurationMinutes.value
          : this.preferredDurationMinutes,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('initialWeightKg: $initialWeightKg, ')
          ..write('goal: $goal, ')
          ..write('level: $level, ')
          ..write('preferredDurationMinutes: $preferredDurationMinutes, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    age,
    heightCm,
    initialWeightKg,
    goal,
    level,
    preferredDurationMinutes,
    onboardingCompleted,
    createdAtUtc,
    updatedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.age == this.age &&
          other.heightCm == this.heightCm &&
          other.initialWeightKg == this.initialWeightKg &&
          other.goal == this.goal &&
          other.level == this.level &&
          other.preferredDurationMinutes == this.preferredDurationMinutes &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.createdAtUtc == this.createdAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<int> id;
  final Value<String?> displayName;
  final Value<int?> age;
  final Value<double?> heightCm;
  final Value<double?> initialWeightKg;
  final Value<String> goal;
  final Value<String> level;
  final Value<int> preferredDurationMinutes;
  final Value<bool> onboardingCompleted;
  final Value<DateTime> createdAtUtc;
  final Value<DateTime> updatedAtUtc;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.initialWeightKg = const Value.absent(),
    this.goal = const Value.absent(),
    this.level = const Value.absent(),
    this.preferredDurationMinutes = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.age = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.initialWeightKg = const Value.absent(),
    required String goal,
    required String level,
    required int preferredDurationMinutes,
    required bool onboardingCompleted,
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
  }) : goal = Value(goal),
       level = Value(level),
       preferredDurationMinutes = Value(preferredDurationMinutes),
       onboardingCompleted = Value(onboardingCompleted),
       createdAtUtc = Value(createdAtUtc),
       updatedAtUtc = Value(updatedAtUtc);
  static Insertable<UserProfileRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<int>? age,
    Expression<double>? heightCm,
    Expression<double>? initialWeightKg,
    Expression<String>? goal,
    Expression<String>? level,
    Expression<int>? preferredDurationMinutes,
    Expression<bool>? onboardingCompleted,
    Expression<DateTime>? createdAtUtc,
    Expression<DateTime>? updatedAtUtc,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (age != null) 'age': age,
      if (heightCm != null) 'height_cm': heightCm,
      if (initialWeightKg != null) 'initial_weight_kg': initialWeightKg,
      if (goal != null) 'goal': goal,
      if (level != null) 'level': level,
      if (preferredDurationMinutes != null)
        'preferred_duration_minutes': preferredDurationMinutes,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String?>? displayName,
    Value<int?>? age,
    Value<double?>? heightCm,
    Value<double?>? initialWeightKg,
    Value<String>? goal,
    Value<String>? level,
    Value<int>? preferredDurationMinutes,
    Value<bool>? onboardingCompleted,
    Value<DateTime>? createdAtUtc,
    Value<DateTime>? updatedAtUtc,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      initialWeightKg: initialWeightKg ?? this.initialWeightKg,
      goal: goal ?? this.goal,
      level: level ?? this.level,
      preferredDurationMinutes:
          preferredDurationMinutes ?? this.preferredDurationMinutes,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (initialWeightKg.present) {
      map['initial_weight_kg'] = Variable<double>(initialWeightKg.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (preferredDurationMinutes.present) {
      map['preferred_duration_minutes'] = Variable<int>(
        preferredDurationMinutes.value,
      );
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('age: $age, ')
          ..write('heightCm: $heightCm, ')
          ..write('initialWeightKg: $initialWeightKg, ')
          ..write('goal: $goal, ')
          ..write('level: $level, ')
          ..write('preferredDurationMinutes: $preferredDurationMinutes, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreferencesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weightUnitMeta = const VerificationMeta(
    'weightUnit',
  );
  @override
  late final GeneratedColumn<String> weightUnit = GeneratedColumn<String>(
    'weight_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthUnitMeta = const VerificationMeta(
    'lengthUnit',
  );
  @override
  late final GeneratedColumn<String> lengthUnit = GeneratedColumn<String>(
    'length_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cm'),
  );
  @override
  List<GeneratedColumn> get $columns => [profileId, weightUnit, lengthUnit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferencesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    }
    if (data.containsKey('weight_unit')) {
      context.handle(
        _weightUnitMeta,
        weightUnit.isAcceptableOrUnknown(data['weight_unit']!, _weightUnitMeta),
      );
    } else if (isInserting) {
      context.missing(_weightUnitMeta);
    }
    if (data.containsKey('length_unit')) {
      context.handle(
        _lengthUnitMeta,
        lengthUnit.isAcceptableOrUnknown(data['length_unit']!, _lengthUnitMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  UserPreferencesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferencesRow(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      weightUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weight_unit'],
      )!,
      lengthUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}length_unit'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreferencesRow extends DataClass
    implements Insertable<UserPreferencesRow> {
  final int profileId;
  final String weightUnit;
  final String lengthUnit;
  const UserPreferencesRow({
    required this.profileId,
    required this.weightUnit,
    required this.lengthUnit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['weight_unit'] = Variable<String>(weightUnit);
    map['length_unit'] = Variable<String>(lengthUnit);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      profileId: Value(profileId),
      weightUnit: Value(weightUnit),
      lengthUnit: Value(lengthUnit),
    );
  }

  factory UserPreferencesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferencesRow(
      profileId: serializer.fromJson<int>(json['profileId']),
      weightUnit: serializer.fromJson<String>(json['weightUnit']),
      lengthUnit: serializer.fromJson<String>(json['lengthUnit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'weightUnit': serializer.toJson<String>(weightUnit),
      'lengthUnit': serializer.toJson<String>(lengthUnit),
    };
  }

  UserPreferencesRow copyWith({
    int? profileId,
    String? weightUnit,
    String? lengthUnit,
  }) => UserPreferencesRow(
    profileId: profileId ?? this.profileId,
    weightUnit: weightUnit ?? this.weightUnit,
    lengthUnit: lengthUnit ?? this.lengthUnit,
  );
  UserPreferencesRow copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreferencesRow(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      weightUnit: data.weightUnit.present
          ? data.weightUnit.value
          : this.weightUnit,
      lengthUnit: data.lengthUnit.present
          ? data.lengthUnit.value
          : this.lengthUnit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesRow(')
          ..write('profileId: $profileId, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('lengthUnit: $lengthUnit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, weightUnit, lengthUnit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferencesRow &&
          other.profileId == this.profileId &&
          other.weightUnit == this.weightUnit &&
          other.lengthUnit == this.lengthUnit);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreferencesRow> {
  final Value<int> profileId;
  final Value<String> weightUnit;
  final Value<String> lengthUnit;
  const UserPreferencesCompanion({
    this.profileId = const Value.absent(),
    this.weightUnit = const Value.absent(),
    this.lengthUnit = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    this.profileId = const Value.absent(),
    required String weightUnit,
    this.lengthUnit = const Value.absent(),
  }) : weightUnit = Value(weightUnit);
  static Insertable<UserPreferencesRow> custom({
    Expression<int>? profileId,
    Expression<String>? weightUnit,
    Expression<String>? lengthUnit,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (weightUnit != null) 'weight_unit': weightUnit,
      if (lengthUnit != null) 'length_unit': lengthUnit,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<int>? profileId,
    Value<String>? weightUnit,
    Value<String>? lengthUnit,
  }) {
    return UserPreferencesCompanion(
      profileId: profileId ?? this.profileId,
      weightUnit: weightUnit ?? this.weightUnit,
      lengthUnit: lengthUnit ?? this.lengthUnit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (weightUnit.present) {
      map['weight_unit'] = Variable<String>(weightUnit.value);
    }
    if (lengthUnit.present) {
      map['length_unit'] = Variable<String>(lengthUnit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('profileId: $profileId, ')
          ..write('weightUnit: $weightUnit, ')
          ..write('lengthUnit: $lengthUnit')
          ..write(')'))
        .toString();
  }
}

class $ProfileAvailableDaysTable extends ProfileAvailableDays
    with TableInfo<$ProfileAvailableDaysTable, ProfileAvailableDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileAvailableDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<int> profileId = GeneratedColumn<int>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _weekdayMeta = const VerificationMeta(
    'weekday',
  );
  @override
  late final GeneratedColumn<int> weekday = GeneratedColumn<int>(
    'weekday',
    aliasedName,
    false,
    check: () => const CustomExpression<bool>('weekday BETWEEN 1 AND 7'),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [profileId, weekday];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_available_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileAvailableDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('weekday')) {
      context.handle(
        _weekdayMeta,
        weekday.isAcceptableOrUnknown(data['weekday']!, _weekdayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, weekday};
  @override
  ProfileAvailableDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileAvailableDay(
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}profile_id'],
      )!,
      weekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekday'],
      )!,
    );
  }

  @override
  $ProfileAvailableDaysTable createAlias(String alias) {
    return $ProfileAvailableDaysTable(attachedDatabase, alias);
  }
}

class ProfileAvailableDay extends DataClass
    implements Insertable<ProfileAvailableDay> {
  final int profileId;
  final int weekday;
  const ProfileAvailableDay({required this.profileId, required this.weekday});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<int>(profileId);
    map['weekday'] = Variable<int>(weekday);
    return map;
  }

  ProfileAvailableDaysCompanion toCompanion(bool nullToAbsent) {
    return ProfileAvailableDaysCompanion(
      profileId: Value(profileId),
      weekday: Value(weekday),
    );
  }

  factory ProfileAvailableDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileAvailableDay(
      profileId: serializer.fromJson<int>(json['profileId']),
      weekday: serializer.fromJson<int>(json['weekday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<int>(profileId),
      'weekday': serializer.toJson<int>(weekday),
    };
  }

  ProfileAvailableDay copyWith({int? profileId, int? weekday}) =>
      ProfileAvailableDay(
        profileId: profileId ?? this.profileId,
        weekday: weekday ?? this.weekday,
      );
  ProfileAvailableDay copyWithCompanion(ProfileAvailableDaysCompanion data) {
    return ProfileAvailableDay(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      weekday: data.weekday.present ? data.weekday.value : this.weekday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAvailableDay(')
          ..write('profileId: $profileId, ')
          ..write('weekday: $weekday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, weekday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileAvailableDay &&
          other.profileId == this.profileId &&
          other.weekday == this.weekday);
}

class ProfileAvailableDaysCompanion
    extends UpdateCompanion<ProfileAvailableDay> {
  final Value<int> profileId;
  final Value<int> weekday;
  final Value<int> rowid;
  const ProfileAvailableDaysCompanion({
    this.profileId = const Value.absent(),
    this.weekday = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileAvailableDaysCompanion.insert({
    required int profileId,
    required int weekday,
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId),
       weekday = Value(weekday);
  static Insertable<ProfileAvailableDay> custom({
    Expression<int>? profileId,
    Expression<int>? weekday,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (weekday != null) 'weekday': weekday,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileAvailableDaysCompanion copyWith({
    Value<int>? profileId,
    Value<int>? weekday,
    Value<int>? rowid,
  }) {
    return ProfileAvailableDaysCompanion(
      profileId: profileId ?? this.profileId,
      weekday: weekday ?? this.weekday,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<int>(profileId.value);
    }
    if (weekday.present) {
      map['weekday'] = Variable<int>(weekday.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileAvailableDaysCompanion(')
          ..write('profileId: $profileId, ')
          ..write('weekday: $weekday, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prescriptionMeta = const VerificationMeta(
    'prescription',
  );
  @override
  late final GeneratedColumn<String> prescription = GeneratedColumn<String>(
    'prescription',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _easyVariantMeta = const VerificationMeta(
    'easyVariant',
  );
  @override
  late final GeneratedColumn<String> easyVariant = GeneratedColumn<String>(
    'easy_variant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hardVariantMeta = const VerificationMeta(
    'hardVariant',
  );
  @override
  late final GeneratedColumn<String> hardVariant = GeneratedColumn<String>(
    'hard_variant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _impactMeta = const VerificationMeta('impact');
  @override
  late final GeneratedColumn<String> impact = GeneratedColumn<String>(
    'impact',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<String> intensity = GeneratedColumn<String>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageFilenameMeta = const VerificationMeta(
    'imageFilename',
  );
  @override
  late final GeneratedColumn<String> imageFilename = GeneratedColumn<String>(
    'image_filename',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movementMeta = const VerificationMeta(
    'movement',
  );
  @override
  late final GeneratedColumn<String> movement = GeneratedColumn<String>(
    'movement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breathingMeta = const VerificationMeta(
    'breathing',
  );
  @override
  late final GeneratedColumn<String> breathing = GeneratedColumn<String>(
    'breathing',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _safetyMeta = const VerificationMeta('safety');
  @override
  late final GeneratedColumn<String> safety = GeneratedColumn<String>(
    'safety',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _catalogVersionMeta = const VerificationMeta(
    'catalogVersion',
  );
  @override
  late final GeneratedColumn<int> catalogVersion = GeneratedColumn<int>(
    'catalog_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    type,
    muscleGroup,
    difficulty,
    prescription,
    easyVariant,
    hardVariant,
    impact,
    intensity,
    imageFilename,
    movement,
    breathing,
    safety,
    catalogVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscleGroupMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('prescription')) {
      context.handle(
        _prescriptionMeta,
        prescription.isAcceptableOrUnknown(
          data['prescription']!,
          _prescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prescriptionMeta);
    }
    if (data.containsKey('easy_variant')) {
      context.handle(
        _easyVariantMeta,
        easyVariant.isAcceptableOrUnknown(
          data['easy_variant']!,
          _easyVariantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_easyVariantMeta);
    }
    if (data.containsKey('hard_variant')) {
      context.handle(
        _hardVariantMeta,
        hardVariant.isAcceptableOrUnknown(
          data['hard_variant']!,
          _hardVariantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hardVariantMeta);
    }
    if (data.containsKey('impact')) {
      context.handle(
        _impactMeta,
        impact.isAcceptableOrUnknown(data['impact']!, _impactMeta),
      );
    } else if (isInserting) {
      context.missing(_impactMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('image_filename')) {
      context.handle(
        _imageFilenameMeta,
        imageFilename.isAcceptableOrUnknown(
          data['image_filename']!,
          _imageFilenameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_imageFilenameMeta);
    }
    if (data.containsKey('movement')) {
      context.handle(
        _movementMeta,
        movement.isAcceptableOrUnknown(data['movement']!, _movementMeta),
      );
    } else if (isInserting) {
      context.missing(_movementMeta);
    }
    if (data.containsKey('breathing')) {
      context.handle(
        _breathingMeta,
        breathing.isAcceptableOrUnknown(data['breathing']!, _breathingMeta),
      );
    } else if (isInserting) {
      context.missing(_breathingMeta);
    }
    if (data.containsKey('safety')) {
      context.handle(
        _safetyMeta,
        safety.isAcceptableOrUnknown(data['safety']!, _safetyMeta),
      );
    } else if (isInserting) {
      context.missing(_safetyMeta);
    }
    if (data.containsKey('catalog_version')) {
      context.handle(
        _catalogVersionMeta,
        catalogVersion.isAcceptableOrUnknown(
          data['catalog_version']!,
          _catalogVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_catalogVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      prescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prescription'],
      )!,
      easyVariant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}easy_variant'],
      )!,
      hardVariant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hard_variant'],
      )!,
      impact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}impact'],
      )!,
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intensity'],
      )!,
      imageFilename: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_filename'],
      )!,
      movement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movement'],
      )!,
      breathing: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}breathing'],
      )!,
      safety: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}safety'],
      )!,
      catalogVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}catalog_version'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class ExerciseRow extends DataClass implements Insertable<ExerciseRow> {
  final String id;
  final String name;
  final String category;
  final String type;
  final String muscleGroup;
  final String difficulty;
  final String prescription;
  final String easyVariant;
  final String hardVariant;
  final String impact;
  final String intensity;
  final String imageFilename;
  final String movement;
  final String breathing;
  final String safety;
  final int catalogVersion;
  const ExerciseRow({
    required this.id,
    required this.name,
    required this.category,
    required this.type,
    required this.muscleGroup,
    required this.difficulty,
    required this.prescription,
    required this.easyVariant,
    required this.hardVariant,
    required this.impact,
    required this.intensity,
    required this.imageFilename,
    required this.movement,
    required this.breathing,
    required this.safety,
    required this.catalogVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['type'] = Variable<String>(type);
    map['muscle_group'] = Variable<String>(muscleGroup);
    map['difficulty'] = Variable<String>(difficulty);
    map['prescription'] = Variable<String>(prescription);
    map['easy_variant'] = Variable<String>(easyVariant);
    map['hard_variant'] = Variable<String>(hardVariant);
    map['impact'] = Variable<String>(impact);
    map['intensity'] = Variable<String>(intensity);
    map['image_filename'] = Variable<String>(imageFilename);
    map['movement'] = Variable<String>(movement);
    map['breathing'] = Variable<String>(breathing);
    map['safety'] = Variable<String>(safety);
    map['catalog_version'] = Variable<int>(catalogVersion);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      type: Value(type),
      muscleGroup: Value(muscleGroup),
      difficulty: Value(difficulty),
      prescription: Value(prescription),
      easyVariant: Value(easyVariant),
      hardVariant: Value(hardVariant),
      impact: Value(impact),
      intensity: Value(intensity),
      imageFilename: Value(imageFilename),
      movement: Value(movement),
      breathing: Value(breathing),
      safety: Value(safety),
      catalogVersion: Value(catalogVersion),
    );
  }

  factory ExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      type: serializer.fromJson<String>(json['type']),
      muscleGroup: serializer.fromJson<String>(json['muscleGroup']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      prescription: serializer.fromJson<String>(json['prescription']),
      easyVariant: serializer.fromJson<String>(json['easyVariant']),
      hardVariant: serializer.fromJson<String>(json['hardVariant']),
      impact: serializer.fromJson<String>(json['impact']),
      intensity: serializer.fromJson<String>(json['intensity']),
      imageFilename: serializer.fromJson<String>(json['imageFilename']),
      movement: serializer.fromJson<String>(json['movement']),
      breathing: serializer.fromJson<String>(json['breathing']),
      safety: serializer.fromJson<String>(json['safety']),
      catalogVersion: serializer.fromJson<int>(json['catalogVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'type': serializer.toJson<String>(type),
      'muscleGroup': serializer.toJson<String>(muscleGroup),
      'difficulty': serializer.toJson<String>(difficulty),
      'prescription': serializer.toJson<String>(prescription),
      'easyVariant': serializer.toJson<String>(easyVariant),
      'hardVariant': serializer.toJson<String>(hardVariant),
      'impact': serializer.toJson<String>(impact),
      'intensity': serializer.toJson<String>(intensity),
      'imageFilename': serializer.toJson<String>(imageFilename),
      'movement': serializer.toJson<String>(movement),
      'breathing': serializer.toJson<String>(breathing),
      'safety': serializer.toJson<String>(safety),
      'catalogVersion': serializer.toJson<int>(catalogVersion),
    };
  }

  ExerciseRow copyWith({
    String? id,
    String? name,
    String? category,
    String? type,
    String? muscleGroup,
    String? difficulty,
    String? prescription,
    String? easyVariant,
    String? hardVariant,
    String? impact,
    String? intensity,
    String? imageFilename,
    String? movement,
    String? breathing,
    String? safety,
    int? catalogVersion,
  }) => ExerciseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    type: type ?? this.type,
    muscleGroup: muscleGroup ?? this.muscleGroup,
    difficulty: difficulty ?? this.difficulty,
    prescription: prescription ?? this.prescription,
    easyVariant: easyVariant ?? this.easyVariant,
    hardVariant: hardVariant ?? this.hardVariant,
    impact: impact ?? this.impact,
    intensity: intensity ?? this.intensity,
    imageFilename: imageFilename ?? this.imageFilename,
    movement: movement ?? this.movement,
    breathing: breathing ?? this.breathing,
    safety: safety ?? this.safety,
    catalogVersion: catalogVersion ?? this.catalogVersion,
  );
  ExerciseRow copyWithCompanion(ExercisesCompanion data) {
    return ExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      type: data.type.present ? data.type.value : this.type,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      prescription: data.prescription.present
          ? data.prescription.value
          : this.prescription,
      easyVariant: data.easyVariant.present
          ? data.easyVariant.value
          : this.easyVariant,
      hardVariant: data.hardVariant.present
          ? data.hardVariant.value
          : this.hardVariant,
      impact: data.impact.present ? data.impact.value : this.impact,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      imageFilename: data.imageFilename.present
          ? data.imageFilename.value
          : this.imageFilename,
      movement: data.movement.present ? data.movement.value : this.movement,
      breathing: data.breathing.present ? data.breathing.value : this.breathing,
      safety: data.safety.present ? data.safety.value : this.safety,
      catalogVersion: data.catalogVersion.present
          ? data.catalogVersion.value
          : this.catalogVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('difficulty: $difficulty, ')
          ..write('prescription: $prescription, ')
          ..write('easyVariant: $easyVariant, ')
          ..write('hardVariant: $hardVariant, ')
          ..write('impact: $impact, ')
          ..write('intensity: $intensity, ')
          ..write('imageFilename: $imageFilename, ')
          ..write('movement: $movement, ')
          ..write('breathing: $breathing, ')
          ..write('safety: $safety, ')
          ..write('catalogVersion: $catalogVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    type,
    muscleGroup,
    difficulty,
    prescription,
    easyVariant,
    hardVariant,
    impact,
    intensity,
    imageFilename,
    movement,
    breathing,
    safety,
    catalogVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.type == this.type &&
          other.muscleGroup == this.muscleGroup &&
          other.difficulty == this.difficulty &&
          other.prescription == this.prescription &&
          other.easyVariant == this.easyVariant &&
          other.hardVariant == this.hardVariant &&
          other.impact == this.impact &&
          other.intensity == this.intensity &&
          other.imageFilename == this.imageFilename &&
          other.movement == this.movement &&
          other.breathing == this.breathing &&
          other.safety == this.safety &&
          other.catalogVersion == this.catalogVersion);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> type;
  final Value<String> muscleGroup;
  final Value<String> difficulty;
  final Value<String> prescription;
  final Value<String> easyVariant;
  final Value<String> hardVariant;
  final Value<String> impact;
  final Value<String> intensity;
  final Value<String> imageFilename;
  final Value<String> movement;
  final Value<String> breathing;
  final Value<String> safety;
  final Value<int> catalogVersion;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.type = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.prescription = const Value.absent(),
    this.easyVariant = const Value.absent(),
    this.hardVariant = const Value.absent(),
    this.impact = const Value.absent(),
    this.intensity = const Value.absent(),
    this.imageFilename = const Value.absent(),
    this.movement = const Value.absent(),
    this.breathing = const Value.absent(),
    this.safety = const Value.absent(),
    this.catalogVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    required String category,
    required String type,
    required String muscleGroup,
    required String difficulty,
    required String prescription,
    required String easyVariant,
    required String hardVariant,
    required String impact,
    required String intensity,
    required String imageFilename,
    required String movement,
    required String breathing,
    required String safety,
    required int catalogVersion,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category),
       type = Value(type),
       muscleGroup = Value(muscleGroup),
       difficulty = Value(difficulty),
       prescription = Value(prescription),
       easyVariant = Value(easyVariant),
       hardVariant = Value(hardVariant),
       impact = Value(impact),
       intensity = Value(intensity),
       imageFilename = Value(imageFilename),
       movement = Value(movement),
       breathing = Value(breathing),
       safety = Value(safety),
       catalogVersion = Value(catalogVersion);
  static Insertable<ExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? type,
    Expression<String>? muscleGroup,
    Expression<String>? difficulty,
    Expression<String>? prescription,
    Expression<String>? easyVariant,
    Expression<String>? hardVariant,
    Expression<String>? impact,
    Expression<String>? intensity,
    Expression<String>? imageFilename,
    Expression<String>? movement,
    Expression<String>? breathing,
    Expression<String>? safety,
    Expression<int>? catalogVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (type != null) 'type': type,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (difficulty != null) 'difficulty': difficulty,
      if (prescription != null) 'prescription': prescription,
      if (easyVariant != null) 'easy_variant': easyVariant,
      if (hardVariant != null) 'hard_variant': hardVariant,
      if (impact != null) 'impact': impact,
      if (intensity != null) 'intensity': intensity,
      if (imageFilename != null) 'image_filename': imageFilename,
      if (movement != null) 'movement': movement,
      if (breathing != null) 'breathing': breathing,
      if (safety != null) 'safety': safety,
      if (catalogVersion != null) 'catalog_version': catalogVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? type,
    Value<String>? muscleGroup,
    Value<String>? difficulty,
    Value<String>? prescription,
    Value<String>? easyVariant,
    Value<String>? hardVariant,
    Value<String>? impact,
    Value<String>? intensity,
    Value<String>? imageFilename,
    Value<String>? movement,
    Value<String>? breathing,
    Value<String>? safety,
    Value<int>? catalogVersion,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      type: type ?? this.type,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      difficulty: difficulty ?? this.difficulty,
      prescription: prescription ?? this.prescription,
      easyVariant: easyVariant ?? this.easyVariant,
      hardVariant: hardVariant ?? this.hardVariant,
      impact: impact ?? this.impact,
      intensity: intensity ?? this.intensity,
      imageFilename: imageFilename ?? this.imageFilename,
      movement: movement ?? this.movement,
      breathing: breathing ?? this.breathing,
      safety: safety ?? this.safety,
      catalogVersion: catalogVersion ?? this.catalogVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (prescription.present) {
      map['prescription'] = Variable<String>(prescription.value);
    }
    if (easyVariant.present) {
      map['easy_variant'] = Variable<String>(easyVariant.value);
    }
    if (hardVariant.present) {
      map['hard_variant'] = Variable<String>(hardVariant.value);
    }
    if (impact.present) {
      map['impact'] = Variable<String>(impact.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<String>(intensity.value);
    }
    if (imageFilename.present) {
      map['image_filename'] = Variable<String>(imageFilename.value);
    }
    if (movement.present) {
      map['movement'] = Variable<String>(movement.value);
    }
    if (breathing.present) {
      map['breathing'] = Variable<String>(breathing.value);
    }
    if (safety.present) {
      map['safety'] = Variable<String>(safety.value);
    }
    if (catalogVersion.present) {
      map['catalog_version'] = Variable<int>(catalogVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('difficulty: $difficulty, ')
          ..write('prescription: $prescription, ')
          ..write('easyVariant: $easyVariant, ')
          ..write('hardVariant: $hardVariant, ')
          ..write('impact: $impact, ')
          ..write('intensity: $intensity, ')
          ..write('imageFilename: $imageFilename, ')
          ..write('movement: $movement, ')
          ..write('breathing: $breathing, ')
          ..write('safety: $safety, ')
          ..write('catalogVersion: $catalogVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppMetadataTable appMetadata = $AppMetadataTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $ProfileAvailableDaysTable profileAvailableDays =
      $ProfileAvailableDaysTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    appMetadata,
    userProfiles,
    userPreferences,
    profileAvailableDays,
    exercises,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('user_preferences', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'user_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('profile_available_days', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$AppMetadataTableCreateCompanionBuilder =
    AppMetadataCompanion Function({
      required String name,
      required String value,
      Value<int> rowid,
    });
typedef $$AppMetadataTableUpdateCompanionBuilder =
    AppMetadataCompanion Function({
      Value<String> name,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetadataTable,
          AppMetadataData,
          $$AppMetadataTableFilterComposer,
          $$AppMetadataTableOrderingComposer,
          $$AppMetadataTableAnnotationComposer,
          $$AppMetadataTableCreateCompanionBuilder,
          $$AppMetadataTableUpdateCompanionBuilder,
          (
            AppMetadataData,
            BaseReferences<_$AppDatabase, $AppMetadataTable, AppMetadataData>,
          ),
          AppMetadataData,
          PrefetchHooks Function()
        > {
  $$AppMetadataTableTableManager(_$AppDatabase db, $AppMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppMetadataCompanion(name: name, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String name,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataCompanion.insert(
                name: name,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppMetadataTable, AppMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppMetadataTable,
                    AppMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetadataTable,
      AppMetadataData,
      $$AppMetadataTableFilterComposer,
      $$AppMetadataTableOrderingComposer,
      $$AppMetadataTableAnnotationComposer,
      $$AppMetadataTableCreateCompanionBuilder,
      $$AppMetadataTableUpdateCompanionBuilder,
      (
        AppMetadataData,
        BaseReferences<_$AppDatabase, $AppMetadataTable, AppMetadataData>,
      ),
      AppMetadataData,
      PrefetchHooks Function()
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String?> displayName,
      Value<int?> age,
      Value<double?> heightCm,
      Value<double?> initialWeightKg,
      required String goal,
      required String level,
      required int preferredDurationMinutes,
      required bool onboardingCompleted,
      required DateTime createdAtUtc,
      required DateTime updatedAtUtc,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String?> displayName,
      Value<int?> age,
      Value<double?> heightCm,
      Value<double?> initialWeightKg,
      Value<String> goal,
      Value<String> level,
      Value<int> preferredDurationMinutes,
      Value<bool> onboardingCompleted,
      Value<DateTime> createdAtUtc,
      Value<DateTime> updatedAtUtc,
    });

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserPreferencesTable, List<UserPreferencesRow>>
  _userPreferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPreferences,
    aliasName: 'user_profiles__id__user_preferences__profile_id',
  );

  $$UserPreferencesTableProcessedTableManager get userPreferencesRefs {
    final manager = $$UserPreferencesTableTableManager(
      $_db,
      $_db.userPreferences,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _userPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProfileAvailableDaysTable,
    List<ProfileAvailableDay>
  >
  _profileAvailableDaysRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.profileAvailableDays,
        aliasName: 'user_profiles__id__profile_available_days__profile_id',
      );

  $$ProfileAvailableDaysTableProcessedTableManager
  get profileAvailableDaysRefs {
    final manager = $$ProfileAvailableDaysTableTableManager(
      $_db,
      $_db.profileAvailableDays,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _profileAvailableDaysRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialWeightKg => $composableBuilder(
    column: $table.initialWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preferredDurationMinutes => $composableBuilder(
    column: $table.preferredDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userPreferencesRefs(
    Expression<bool> Function($$UserPreferencesTableFilterComposer f) f,
  ) {
    final $$UserPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> profileAvailableDaysRefs(
    Expression<bool> Function($$ProfileAvailableDaysTableFilterComposer f) f,
  ) {
    final $$ProfileAvailableDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profileAvailableDays,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfileAvailableDaysTableFilterComposer(
            $db: $db,
            $table: $db.profileAvailableDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialWeightKg => $composableBuilder(
    column: $table.initialWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preferredDurationMinutes => $composableBuilder(
    column: $table.preferredDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get initialWeightKg => $composableBuilder(
    column: $table.initialWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get preferredDurationMinutes => $composableBuilder(
    column: $table.preferredDurationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => column,
  );

  Expression<T> userPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserPreferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> profileAvailableDaysRefs<T extends Object>(
    Expression<T> Function($$ProfileAvailableDaysTableAnnotationComposer a) f,
  ) {
    final $$ProfileAvailableDaysTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.profileAvailableDays,
          getReferencedColumn: (t) => t.profileId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProfileAvailableDaysTableAnnotationComposer(
                $db: $db,
                $table: $db.profileAvailableDays,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfileRow,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (UserProfileRow, $$UserProfilesTableReferences),
          UserProfileRow,
          PrefetchHooks Function({
            bool userPreferencesRefs,
            bool profileAvailableDaysRefs,
          })
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> initialWeightKg = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<int> preferredDurationMinutes = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<DateTime> updatedAtUtc = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                displayName: displayName,
                age: age,
                heightCm: heightCm,
                initialWeightKg: initialWeightKg,
                goal: goal,
                level: level,
                preferredDurationMinutes: preferredDurationMinutes,
                onboardingCompleted: onboardingCompleted,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<int?> age = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> initialWeightKg = const Value.absent(),
                required String goal,
                required String level,
                required int preferredDurationMinutes,
                required bool onboardingCompleted,
                required DateTime createdAtUtc,
                required DateTime updatedAtUtc,
              }) => UserProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                age: age,
                heightCm: heightCm,
                initialWeightKg: initialWeightKg,
                goal: goal,
                level: level,
                preferredDurationMinutes: preferredDurationMinutes,
                onboardingCompleted: onboardingCompleted,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfileRow>(table),
                  $$UserProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userPreferencesRefs = false,
                profileAvailableDaysRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userPreferencesRefs) db.userPreferences,
                    if (profileAvailableDaysRefs) db.profileAvailableDays,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userPreferencesRefs)
                        await $_getPrefetchedData<
                          UserProfileRow,
                          $UserProfilesTable,
                          UserPreferencesRow
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._userPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).userPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (profileAvailableDaysRefs)
                        await $_getPrefetchedData<
                          UserProfileRow,
                          $UserProfilesTable,
                          ProfileAvailableDay
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._profileAvailableDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).profileAvailableDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfileRow,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (UserProfileRow, $$UserProfilesTableReferences),
      UserProfileRow,
      PrefetchHooks Function({
        bool userPreferencesRefs,
        bool profileAvailableDaysRefs,
      })
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> profileId,
      required String weightUnit,
      Value<String> lengthUnit,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> profileId,
      Value<String> weightUnit,
      Value<String> lengthUnit,
    });

final class $$UserPreferencesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferencesRow
        > {
  $$UserPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _profileIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('user_preferences__profile_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lengthUnit => $composableBuilder(
    column: $table.lengthUnit,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get profileId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lengthUnit => $composableBuilder(
    column: $table.lengthUnit,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get profileId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get weightUnit => $composableBuilder(
    column: $table.weightUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lengthUnit => $composableBuilder(
    column: $table.lengthUnit,
    builder: (column) => column,
  );

  $$UserProfilesTableAnnotationComposer get profileId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferencesRow,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (UserPreferencesRow, $$UserPreferencesTableReferences),
          UserPreferencesRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<String> weightUnit = const Value.absent(),
                Value<String> lengthUnit = const Value.absent(),
              }) => UserPreferencesCompanion(
                profileId: profileId,
                weightUnit: weightUnit,
                lengthUnit: lengthUnit,
              ),
          createCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                required String weightUnit,
                Value<String> lengthUnit = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                profileId: profileId,
                weightUnit: weightUnit,
                lengthUnit: lengthUnit,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTable, UserPreferencesRow>(table),
                  $$UserPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$UserPreferencesTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$UserPreferencesTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreferencesRow,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (UserPreferencesRow, $$UserPreferencesTableReferences),
      UserPreferencesRow,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$ProfileAvailableDaysTableCreateCompanionBuilder =
    ProfileAvailableDaysCompanion Function({
      required int profileId,
      required int weekday,
      Value<int> rowid,
    });
typedef $$ProfileAvailableDaysTableUpdateCompanionBuilder =
    ProfileAvailableDaysCompanion Function({
      Value<int> profileId,
      Value<int> weekday,
      Value<int> rowid,
    });

final class $$ProfileAvailableDaysTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProfileAvailableDaysTable,
          ProfileAvailableDay
        > {
  $$ProfileAvailableDaysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _profileIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('profile_available_days__profile_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<int>('profile_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProfileAvailableDaysTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileAvailableDaysTable> {
  $$ProfileAvailableDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get profileId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAvailableDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileAvailableDaysTable> {
  $$ProfileAvailableDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get weekday => $composableBuilder(
    column: $table.weekday,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get profileId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAvailableDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileAvailableDaysTable> {
  $$ProfileAvailableDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get weekday =>
      $composableBuilder(column: $table.weekday, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get profileId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfileAvailableDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileAvailableDaysTable,
          ProfileAvailableDay,
          $$ProfileAvailableDaysTableFilterComposer,
          $$ProfileAvailableDaysTableOrderingComposer,
          $$ProfileAvailableDaysTableAnnotationComposer,
          $$ProfileAvailableDaysTableCreateCompanionBuilder,
          $$ProfileAvailableDaysTableUpdateCompanionBuilder,
          (ProfileAvailableDay, $$ProfileAvailableDaysTableReferences),
          ProfileAvailableDay,
          PrefetchHooks Function({bool profileId})
        > {
  $$ProfileAvailableDaysTableTableManager(
    _$AppDatabase db,
    $ProfileAvailableDaysTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileAvailableDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileAvailableDaysTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProfileAvailableDaysTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> profileId = const Value.absent(),
                Value<int> weekday = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfileAvailableDaysCompanion(
                profileId: profileId,
                weekday: weekday,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int profileId,
                required int weekday,
                Value<int> rowid = const Value.absent(),
              }) => ProfileAvailableDaysCompanion.insert(
                profileId: profileId,
                weekday: weekday,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileAvailableDaysTable, ProfileAvailableDay>(
                    table,
                  ),
                  $$ProfileAvailableDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (profileId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.profileId,
                        referencedTable: $$ProfileAvailableDaysTableReferences
                            ._profileIdTable(db),
                        referencedColumn: $$ProfileAvailableDaysTableReferences
                            ._profileIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProfileAvailableDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileAvailableDaysTable,
      ProfileAvailableDay,
      $$ProfileAvailableDaysTableFilterComposer,
      $$ProfileAvailableDaysTableOrderingComposer,
      $$ProfileAvailableDaysTableAnnotationComposer,
      $$ProfileAvailableDaysTableCreateCompanionBuilder,
      $$ProfileAvailableDaysTableUpdateCompanionBuilder,
      (ProfileAvailableDay, $$ProfileAvailableDaysTableReferences),
      ProfileAvailableDay,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  required String id,
  required String name,
  required String category,
  required String type,
  required String muscleGroup,
  required String difficulty,
  required String prescription,
  required String easyVariant,
  required String hardVariant,
  required String impact,
  required String intensity,
  required String imageFilename,
  required String movement,
  required String breathing,
  required String safety,
  required int catalogVersion,
  Value<int> rowid,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> category,
  Value<String> type,
  Value<String> muscleGroup,
  Value<String> difficulty,
  Value<String> prescription,
  Value<String> easyVariant,
  Value<String> hardVariant,
  Value<String> impact,
  Value<String> intensity,
  Value<String> imageFilename,
  Value<String> movement,
  Value<String> breathing,
  Value<String> safety,
  Value<int> catalogVersion,
  Value<int> rowid,
});

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get easyVariant => $composableBuilder(
    column: $table.easyVariant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hardVariant => $composableBuilder(
    column: $table.hardVariant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get impact => $composableBuilder(
    column: $table.impact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageFilename => $composableBuilder(
    column: $table.imageFilename,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get movement => $composableBuilder(
    column: $table.movement,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breathing => $composableBuilder(
    column: $table.breathing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get safety => $composableBuilder(
    column: $table.safety,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get easyVariant => $composableBuilder(
    column: $table.easyVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hardVariant => $composableBuilder(
    column: $table.hardVariant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get impact => $composableBuilder(
    column: $table.impact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageFilename => $composableBuilder(
    column: $table.imageFilename,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movement => $composableBuilder(
    column: $table.movement,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breathing => $composableBuilder(
    column: $table.breathing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get safety => $composableBuilder(
    column: $table.safety,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prescription => $composableBuilder(
    column: $table.prescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get easyVariant => $composableBuilder(
    column: $table.easyVariant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hardVariant => $composableBuilder(
    column: $table.hardVariant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get impact =>
      $composableBuilder(column: $table.impact, builder: (column) => column);

  GeneratedColumn<String> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<String> get imageFilename => $composableBuilder(
    column: $table.imageFilename,
    builder: (column) => column,
  );

  GeneratedColumn<String> get movement =>
      $composableBuilder(column: $table.movement, builder: (column) => column);

  GeneratedColumn<String> get breathing =>
      $composableBuilder(column: $table.breathing, builder: (column) => column);

  GeneratedColumn<String> get safety =>
      $composableBuilder(column: $table.safety, builder: (column) => column);

  GeneratedColumn<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => column,
  );
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          ExerciseRow,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (
            ExerciseRow,
            BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
          ),
          ExerciseRow,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> muscleGroup = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> prescription = const Value.absent(),
                Value<String> easyVariant = const Value.absent(),
                Value<String> hardVariant = const Value.absent(),
                Value<String> impact = const Value.absent(),
                Value<String> intensity = const Value.absent(),
                Value<String> imageFilename = const Value.absent(),
                Value<String> movement = const Value.absent(),
                Value<String> breathing = const Value.absent(),
                Value<String> safety = const Value.absent(),
                Value<int> catalogVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                category: category,
                type: type,
                muscleGroup: muscleGroup,
                difficulty: difficulty,
                prescription: prescription,
                easyVariant: easyVariant,
                hardVariant: hardVariant,
                impact: impact,
                intensity: intensity,
                imageFilename: imageFilename,
                movement: movement,
                breathing: breathing,
                safety: safety,
                catalogVersion: catalogVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String category,
                required String type,
                required String muscleGroup,
                required String difficulty,
                required String prescription,
                required String easyVariant,
                required String hardVariant,
                required String impact,
                required String intensity,
                required String imageFilename,
                required String movement,
                required String breathing,
                required String safety,
                required int catalogVersion,
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                category: category,
                type: type,
                muscleGroup: muscleGroup,
                difficulty: difficulty,
                prescription: prescription,
                easyVariant: easyVariant,
                hardVariant: hardVariant,
                impact: impact,
                intensity: intensity,
                imageFilename: imageFilename,
                movement: movement,
                breathing: breathing,
                safety: safety,
                catalogVersion: catalogVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExercisesTable, ExerciseRow>(table),
                  BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      ExerciseRow,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (
        ExerciseRow,
        BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
      ),
      ExerciseRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppMetadataTableTableManager get appMetadata =>
      $$AppMetadataTableTableManager(_db, _db.appMetadata);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$ProfileAvailableDaysTableTableManager get profileAvailableDays =>
      $$ProfileAvailableDaysTableTableManager(_db, _db.profileAvailableDays);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
}
