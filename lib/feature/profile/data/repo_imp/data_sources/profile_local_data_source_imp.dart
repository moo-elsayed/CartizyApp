import 'package:cartizy_app_nti/core/entities/user_response_entity.dart';
import 'package:cartizy_app_nti/feature/profile/domain/repo_contract/data_sources/profile_local_data_source.dart';
import 'package:hive/hive.dart';
import '../../../../../core/helpers/hive_helper.dart';

class ProfileLocalDataSourceImp implements ProfileLocalDataSource {
  @override
  Future<UserResponseEntity?> getProfile() async {
    var box = Hive.box<UserResponseEntity>(HiveHelper.profileBox);
    return box.values.isNotEmpty ? await Future.value(box.getAt(0)) : null;
  }
}
