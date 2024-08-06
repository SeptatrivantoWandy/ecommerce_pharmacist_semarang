import 'package:ecommerce_pharmacist_semarang/mvc/controller/register_controller.dart';
import 'package:ecommerce_pharmacist_semarang/resource/resource_manager.dart';
import 'package:flutter/material.dart';

class ImagePickerModal {
  void imagePickerModalPressed(
      BuildContext context, RegisterController registerController, String fotoDari, Function onUpdate) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 6),
              Container(
                width: 38,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadiusManager.textfieldRadius,
                      ),
                      onTap: () {
                        registerController.pickImageFromCamera(fotoDari).then((_) {
                          Navigator.pop(context);
                          onUpdate();
                        });
                      },
                      child: Container(
                        margin: PaddingMarginManager.listSuperView,
                        child: const Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: ColorManager.primary,
                              size: 36,
                            ),
                            SizedBox(height: 4),
                            Text('Ambil Foto'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadiusManager.textfieldRadius,
                      ),
                      onTap: () {
                        registerController.pickImageFromGallery(fotoDari).then((_) {
                          Navigator.pop(context);
                          onUpdate();
                        });
                      },
                      child: Container(
                        margin: PaddingMarginManager.listSuperView,
                        child: const Column(
                          children: [
                            Icon(
                              Icons.photo_outlined,
                              color: ColorManager.primary,
                              size: 36,
                            ),
                            SizedBox(height: 4),
                            Text('Pilih dari Galeri'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
