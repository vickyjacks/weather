/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:weather/core/either.dart';
import 'package:weather/core/failure.dart';
import 'package:weather/data/data_sources/unit_system_local_data_source.dart';
import 'package:weather/data/models/unit_system_model.dart';
import 'package:weather/domain/entities/unit_system.dart';
import 'package:weather/domain/repos/unit_system_repo.dart';
import 'package:riverpod/riverpod.dart';

class UnitSystemRepoImpl implements UnitSystemRepo {
  UnitSystemRepoImpl(this._localDataSource);

  final UnitSystemLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, UnitSystem>> getUnitSystem() async =>
      (await _localDataSource.getUnitSystem())
          .map((model) => model?.unitSystem ?? UnitSystem.metric);

  @override
  Future<Either<Failure, void>> setUnitSystem(UnitSystem unitSystem) =>
      _localDataSource.setUnitSystem(UnitSystemModel(unitSystem));
}

final unitSystemRepoImplProvider = Provider(
  (ref) => UnitSystemRepoImpl(ref.watch(unitSystemLocalDataSourceProvider)),
);
