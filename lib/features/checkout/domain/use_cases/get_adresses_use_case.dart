import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/domain/entities/adresses/address_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAdressesUseCase {
  final CheckoutRepository repository;

  const GetAdressesUseCase(this.repository);

  Future<BaseResponse<List<AddressEntity>>> call() {
    return repository.getAddresses();
  }
}
