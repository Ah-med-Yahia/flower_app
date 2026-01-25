import 'package:flower_app/features/home/data/mappers/home_response_mapper.dart';
import 'package:flower_app/features/home/data/models/category_dto.dart';
import 'package:flower_app/features/home/data/models/home_response_dto.dart';
import 'package:flower_app/features/home/data/models/home_screen_product_dto.dart';
import 'package:flower_app/features/home/data/models/occasion_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeResponseMapper', () {
    test('should map HomeResponseDto to HomeResponseEntity', () {
      // Arrange
      final homeResponseDto = HomeResponseDto(
        message: 'message',
        categories: [
          CategoryDto(
            id: '1',
            name: 'Category 1',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
          CategoryDto(
            id: '2',
            name: 'Category 2',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
          CategoryDto(
            id: '3',
            name: 'Category 3',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
        ],
        bestSeller: [
          HomeScreenProductDto(
            id: '1',
            title: 'title',
            slug: 'slug',
            description: 'description',
            imgCover: 'imgCover',
            images: [],
            price: 1,
            priceAfterDiscount: 1,
            quantity: 1,
            category: 'category',
            occasion: 'occasion',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 1,
            isSuperAdmin: false,
            rateAvg: 1,
            rateCount: 1,
          ),
          HomeScreenProductDto(
            id: '2',
            title: 'title',
            slug: 'slug',
            description: 'description',
            imgCover: 'imgCover',
            images: [],
            price: 1,
            priceAfterDiscount: 1,
            quantity: 1,
            category: 'category',
            occasion: 'occasion',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 1,
            isSuperAdmin: false,
            rateAvg: 1,
            rateCount: 1,
          ),
          HomeScreenProductDto(
            id: '3',
            title: 'title',
            slug: 'slug',
            description: 'description',
            imgCover: 'imgCover',
            images: [],
            price: 1,
            priceAfterDiscount: 1,
            quantity: 1,
            category: 'category',
            occasion: 'occasion',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            v: 1,
            isSuperAdmin: false,
            rateAvg: 1,
            rateCount: 1,
          ),
        ],
        occasions: [
          OccasionDto(
            id: '1',
            name: 'Occasion 1',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
          OccasionDto(
            id: '2',
            name: 'Occasion 2',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
          OccasionDto(
            id: '3',
            name: 'Occasion 3',
            slug: 'slug',
            image: 'image.jpg',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSuperAdmin: null,
          ),
        ],
      );

      // Act
      final homeResponseEntity = homeResponseDto.toEntity();

      // Assert
      expect(homeResponseEntity.message, homeResponseDto.message);
      expect(
        homeResponseEntity.categories.first.name,
        homeResponseDto.categories?.first.name,
      );
      expect(
        homeResponseEntity.categories.first.id,
        homeResponseDto.categories?.first.id,
      );
      expect(
        homeResponseEntity.categories.first.image,
        homeResponseDto.categories?.first.image,
      );
      expect(
        homeResponseEntity.categories.first.slug,
        homeResponseDto.categories?.first.slug,
      );
      expect(
        homeResponseEntity.categories.first.createdAt,
        homeResponseDto.categories?.first.createdAt,
      );
      expect(
        homeResponseEntity.categories.first.updatedAt,
        homeResponseDto.categories?.first.updatedAt,
      );
      expect(homeResponseEntity.categories.first.isSuperAdmin, false);
      expect(
        homeResponseEntity.categories.length,
        homeResponseDto.categories?.length,
      );
      expect(
        homeResponseEntity.bestSeller.length,
        homeResponseDto.bestSeller?.length,
      );
      expect(
        homeResponseEntity.occasions.length,
        homeResponseDto.occasions?.length,
      );
    });
  });
}
