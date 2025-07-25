// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_entry_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stepEntryHash() => r'af4693691b17919b3c673348b58367526d8686f4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
///
/// Copied from [stepEntry].
@ProviderFor(stepEntry)
const stepEntryProvider = StepEntryFamily();

/// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
///
/// Copied from [stepEntry].
class StepEntryFamily extends Family<AsyncValue<void>> {
  /// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
  ///
  /// Copied from [stepEntry].
  const StepEntryFamily();

  /// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
  ///
  /// Copied from [stepEntry].
  StepEntryProvider call(int steps) {
    return StepEntryProvider(steps);
  }

  @override
  StepEntryProvider getProviderOverride(covariant StepEntryProvider provider) {
    return call(provider.steps);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'stepEntryProvider';
}

/// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
///
/// Copied from [stepEntry].
class StepEntryProvider extends AutoDisposeFutureProvider<void> {
  /// A FutureProvider.family that posts a StepEntry whenever you `watch` it.
  ///
  /// Copied from [stepEntry].
  StepEntryProvider(int steps)
    : this._internal(
        (ref) => stepEntry(ref as StepEntryRef, steps),
        from: stepEntryProvider,
        name: r'stepEntryProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$stepEntryHash,
        dependencies: StepEntryFamily._dependencies,
        allTransitiveDependencies: StepEntryFamily._allTransitiveDependencies,
        steps: steps,
      );

  StepEntryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.steps,
  }) : super.internal();

  final int steps;

  @override
  Override overrideWith(FutureOr<void> Function(StepEntryRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: StepEntryProvider._internal(
        (ref) => create(ref as StepEntryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        steps: steps,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _StepEntryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StepEntryProvider && other.steps == steps;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, steps.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StepEntryRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `steps` of this provider.
  int get steps;
}

class _StepEntryProviderElement extends AutoDisposeFutureProviderElement<void>
    with StepEntryRef {
  _StepEntryProviderElement(super.provider);

  @override
  int get steps => (origin as StepEntryProvider).steps;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
