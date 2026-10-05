import '../../features/profile/domain/user_profile.dart';

abstract final class WeightConverter {
  static const double kilogramsPerPound = 0.45359237;

  static double toKilograms(double value, WeightUnit unit) =>
      unit == WeightUnit.kg ? value : value * kilogramsPerPound;

  static double fromKilograms(double value, WeightUnit unit) =>
      unit == WeightUnit.kg ? value : value / kilogramsPerPound;
}
