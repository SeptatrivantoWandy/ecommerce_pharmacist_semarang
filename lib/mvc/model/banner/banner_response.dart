import 'package:flutter/foundation.dart';

class BannerResponse {
  bool status;
  String message;
  List<ImageData> imageData;

  BannerResponse({required this.status, required this.message, required this.imageData});

  // Factory method to create a BannerResponse from JSON
  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    return BannerResponse(
      status: json['status'],
      message: json['message'],
      imageData: json['imageData'] != null
          ? (json['imageData'] as List)
              .map((item) => ImageData.fromJson(item))
              .toList()
          : [],
    );
  }

  // Method to convert a BannerResponse to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'imageData': imageData.map((item) => item.toJson()).toList(),
    };
  }

  void printBannerResponse() {
    if (kDebugMode) {
      print('========== printBannerResponse ==========');
      print('Status: $status');
      print('Message: $message');
      print('Image Data:');
      for (var data in imageData) {
        print('Image Name: ${data.imageName}');
        print('Image URL: ${data.imageUrl}');
      }
        }
  }
}

class ImageData {
  String? imageName;
  String? imageUrl;

  ImageData({this.imageName, this.imageUrl});

  // Factory method to create ImageData from JSON
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageName: json['imageName'],
      imageUrl: json['imageUrl'],
    );
  }

  // Method to convert ImageData to JSON
  Map<String, dynamic> toJson() {
    return {
      'imageName': imageName,
      'imageUrl': imageUrl,
    };
  }
}
