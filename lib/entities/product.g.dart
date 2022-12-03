// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String?,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      createdBy: json['createdBy'] == null
          ? null
          : Creator.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      slug: json['slug'] as String?,
      image: json['image'] as String? ?? 'https://picsum.photos/760/800',
      favorite: json['favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'slug': instance.slug,
      'image': instance.image,
      'favorite': instance.favorite,
    };
