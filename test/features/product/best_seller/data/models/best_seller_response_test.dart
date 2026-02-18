import 'package:flower_app/features/products/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/products/best_seller/data/models/best_seller_response_dto.dart';
import 'package:flower_app/features/products/best_seller/domain/entities/best_seller_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BestSellerResponseDto toEntity mapping', () {
    _setupSuccessfulMappingScenarios();
    _setupNullValueHandling();
    _setupEdgeCaseValues();
    _setupBehaviorValidation();
    _setupPaginationMetadata();
  });
}

void _setupSuccessfulMappingScenarios() {
  group('successful mapping scenarios', () {
    _testMapsResponseWithMultipleItemsCorrectly();
    _testMapsResponseWithSingleItemCorrectly();
    _testMapsAllFieldsCorrectly();
  });
}

void _testMapsResponseWithMultipleItemsCorrectly() {
  test('maps response with multiple items correctly', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [
        BestSellerDto(
          id: '1',
          title: 'Product 1',
          imgCover: 'img1.jpg',
          price: 100,
          priceAfterDiscount: 90,
          quantity: 10,
          sold: 5,
          bestSellerId: 'bs1',
          discount: 10,
        ),
        BestSellerDto(
          id: '2',
          title: 'Product 2',
          imgCover: 'img2.jpg',
          price: 200,
          priceAfterDiscount: 180,
          quantity: 20,
          sold: 10,
          bestSellerId: 'bs2',
          discount: 20,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result, isA<BestSellerResponse>());
    expect(result.message, 'Success');
    expect(result.bestSeller?.length, 2);

    final firstItem = result.bestSeller![0];
    expect(firstItem.id, '1');
    expect(firstItem.title, 'Product 1');
    expect(firstItem.imgCover, 'img1.jpg');
    expect(firstItem.price, 100);
    expect(firstItem.priceAfterDiscount, 90);
    expect(firstItem.quantity, 10);
    expect(firstItem.sold, 5);
    expect(firstItem.bestSellerId, 'bs1');
    expect(firstItem.discount, 10);

    final secondItem = result.bestSeller![1];
    expect(secondItem.id, '2');
    expect(secondItem.price, 200);
  });
}

void _testMapsResponseWithSingleItemCorrectly() {
  test('maps response with single item correctly', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [
        BestSellerDto(
          id: '1',
          title: 'Product 1',
          imgCover: 'img.jpg',
          price: 100,
          priceAfterDiscount: 90,
          quantity: 10,
          sold: 5,
          bestSellerId: 'bs1',
          discount: 10,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.length, 1);
    expect(result.bestSeller?.first.id, '1');
    expect(result.bestSeller?.first.title, 'Product 1');
  });
}

void _testMapsAllFieldsCorrectly() {
  test('maps all fields correctly', () {
    final dto = BestSellerResponseDto(
      message: 'Test Message',
      bestSellerDto: [
        BestSellerDto(
          id: 'id1',
          title: 'title1',
          imgCover: 'cover1',
          price: 50,
          priceAfterDiscount: 40,
          quantity: 5,
          sold: 2,
          bestSellerId: 'bsid1',
          discount: 5,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.message, 'Test Message');
    expect(result.bestSeller?[0].imgCover, 'cover1');
    expect(result.bestSeller?[0].price, 50);
    expect(result.bestSeller?[0].priceAfterDiscount, 40);
    expect(result.bestSeller?[0].quantity, 5);
    expect(result.bestSeller?[0].sold, 2);
    expect(result.bestSeller?[0].discount, 5);
    expect(result.bestSeller?[0].bestSellerId, 'bsid1');
  });
}

void _setupNullValueHandling() {
  group('null value handling', () {
    _testHandlesNullBestSellerList();
    _testHandlesNullMessage();
    _testHandlesNullFieldsInBestSellerItems();
  });
}

void _testHandlesNullBestSellerList() {
  test('handles null best seller list', () {
    final dto = BestSellerResponseDto(message: 'Success', bestSellerDto: null);

    final result = dto.toEntity();

    expect(result.message, 'Success');
    expect(result.bestSeller, isEmpty);
  });
}

void _testHandlesNullMessage() {
  test('handles null message', () {
    final dto = BestSellerResponseDto(message: null, bestSellerDto: []);

    final result = dto.toEntity();

    expect(result.message, '');
    expect(result.bestSeller, isEmpty);
  });
}

void _testHandlesNullFieldsInBestSellerItems() {
  test('handles null fields in best seller items', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [BestSellerDto()],
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.first.id, '');
    expect(result.bestSeller?.first.title, '');
    expect(result.bestSeller?.first.imgCover, '');
    expect(result.bestSeller?.first.price, 0);
    expect(result.bestSeller?.first.priceAfterDiscount, 0);
    expect(result.bestSeller?.first.quantity, 0);
    expect(result.bestSeller?.first.sold, 0);
    expect(result.bestSeller?.first.bestSellerId, '');
    expect(result.bestSeller?.first.discount, 0);
  });
}

void _setupEdgeCaseValues() {
  group('edge case values', () {
    _testHandlesEmptyBestSellerList();
    _testHandlesEmptyStringValues();
    _testHandlesZeroNumericValues();
    _testHandlesNegativeNumericValues();
    _testHandlesLargeNumericValues();
    _testHandlesSpecialCharactersInStrings();
    _testHandlesLargeListOfItems();
  });
}

void _testHandlesEmptyBestSellerList() {
  test('handles empty best seller list', () {
    final dto = BestSellerResponseDto(message: 'No items', bestSellerDto: []);

    final result = dto.toEntity();

    expect(result.message, 'No items');
    expect(result.bestSeller, isEmpty);
  });
}

void _testHandlesEmptyStringValues() {
  test('handles empty string values', () {
    final dto = BestSellerResponseDto(
      message: '',
      bestSellerDto: [
        BestSellerDto(
          id: '',
          title: '',
          imgCover: '',
          price: 100,
          priceAfterDiscount: 90,
          quantity: 10,
          sold: 5,
          bestSellerId: '',
          discount: 10,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.message, '');
    expect(result.bestSeller?.first.id, '');
    expect(result.bestSeller?.first.title, '');
    expect(result.bestSeller?.first.imgCover, '');
    expect(result.bestSeller?.first.bestSellerId, '');
  });
}

void _testHandlesZeroNumericValues() {
  test('handles zero numeric values', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [
        BestSellerDto(
          id: '1',
          title: 'Product',
          imgCover: 'img.jpg',
          price: 0,
          priceAfterDiscount: 0,
          quantity: 0,
          sold: 0,
          bestSellerId: '1',
          discount: 0,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.first.price, 0);
    expect(result.bestSeller?.first.priceAfterDiscount, 0);
    expect(result.bestSeller?.first.quantity, 0);
    expect(result.bestSeller?.first.sold, 0);
    expect(result.bestSeller?.first.discount, 0);
  });
}

void _testHandlesNegativeNumericValues() {
  test('handles negative numeric values', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [
        BestSellerDto(
          id: '1',
          title: 'Product',
          imgCover: 'img.jpg',
          price: -100,
          priceAfterDiscount: -90,
          quantity: -10,
          sold: -5,
          bestSellerId: '1',
          discount: -10,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.first.price, -100);
    expect(result.bestSeller?.first.priceAfterDiscount, -90);
    expect(result.bestSeller?.first.quantity, -10);
    expect(result.bestSeller?.first.sold, -5);
    expect(result.bestSeller?.first.discount, -10);
  });
}

void _testHandlesLargeNumericValues() {
  test('handles large numeric values', () {
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: [
        BestSellerDto(
          id: '1',
          title: 'Product',
          imgCover: 'img.jpg',
          price: 999999999,
          priceAfterDiscount: 888888888,
          quantity: 777777777,
          sold: 666666666,
          bestSellerId: '1',
          discount: 555555555,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.first.price, 999999999);
    expect(result.bestSeller?.first.priceAfterDiscount, 888888888);
    expect(result.bestSeller?.first.quantity, 777777777);
    expect(result.bestSeller?.first.sold, 666666666);
    expect(result.bestSeller?.first.discount, 555555555);
  });
}

void _testHandlesSpecialCharactersInStrings() {
  test('handles special characters in strings', () {
    final dto = BestSellerResponseDto(
      message: 'Success @#\$%',
      bestSellerDto: [
        BestSellerDto(
          id: '123-abc',
          title: 'Product @#\$%&*()!',
          imgCover: 'https://example.com/img?p=1&t=2',
          price: 100,
          priceAfterDiscount: 90,
          quantity: 10,
          sold: 5,
          bestSellerId: 'bs-123',
          discount: 10,
        ),
      ],
    );

    final result = dto.toEntity();

    expect(result.message, 'Success @#\$%');
    expect(result.bestSeller?.first.id, '123-abc');
    expect(result.bestSeller?.first.title, 'Product @#\$%&*()!');
    expect(
      result.bestSeller?.first.imgCover,
      'https://example.com/img?p=1&t=2',
    );
    expect(result.bestSeller?.first.bestSellerId, 'bs-123');
  });
}

void _testHandlesLargeListOfItems() {
  test('handles large list of items', () {
    final largeList = List.generate(
      100,
      (i) => BestSellerDto(
        id: '$i',
        title: 'Product $i',
        imgCover: 'img$i.jpg',
        price: 100 * i,
        priceAfterDiscount: 90 * i,
        quantity: 10,
        sold: 5,
        bestSellerId: 'bs$i',
        discount: 10,
      ),
    );
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: largeList,
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.length, 100);
    expect(result.bestSeller?.first.id, '0');
    expect(result.bestSeller?.last.id, '99');
  });
}

void _setupBehaviorValidation() {
  group('behavior validation', () {
    _testCreatesNewInstanceOnEachToEntityCall();
  });
}

void _testCreatesNewInstanceOnEachToEntityCall() {
  test('creates new instance on each toEntity call', () {
    final dto = BestSellerResponseDto(message: 'Success', bestSellerDto: []);

    final result1 = dto.toEntity();
    final result2 = dto.toEntity();

    expect(identical(result1, result2), false);
  });
}

void _setupPaginationMetadata() {
  group('pagination metadata', () {
    _testCreatesPaginationMetadataCorrectly();
  });
}

void _testCreatesPaginationMetadataCorrectly() {
  test('creates pagination metadata correctly', () {
    final largeList = List.generate(
      75,
      (i) => BestSellerDto(
        id: '$i',
        title: 'Product $i',
        imgCover: 'img$i.jpg',
        price: 100 * i,
        priceAfterDiscount: 90 * i,
        quantity: 10,
        sold: 5,
        bestSellerId: 'bs$i',
        discount: 10,
      ),
    );
    final dto = BestSellerResponseDto(
      message: 'Success',
      bestSellerDto: largeList,
    );

    final result = dto.toEntity();

    expect(result.bestSeller?.length, 75);
    expect(result.bestSeller?.first.id, '0');
    expect(result.bestSeller?.last.id, '74');

    expect(result.paginationMetadata?.currentPage, 1);
    expect(result.paginationMetadata?.numberOfPages, 8);
    expect(result.paginationMetadata?.limit, 10);
    expect(result.paginationMetadata?.total, 75);
    expect(result.paginationMetadata?.total, result.bestSeller?.length);
  });
}
