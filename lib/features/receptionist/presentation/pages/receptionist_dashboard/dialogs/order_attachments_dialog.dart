import 'package:dental_link_dashboard/core/api/api_endpoints.dart';
import 'package:dental_link_dashboard/features/receptionist/data/models/orders_model/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderAttachmentsDialog extends StatelessWidget {
  const OrderAttachmentsDialog({super.key, required this.files});

  final List<FileElement> files;

Future<void> _openFile(String url) async {
  final fixedUrl = ApiEndpoints.resolveFileUrl(url);

  await launchUrl(
    Uri.parse(fixedUrl),
    mode: LaunchMode.externalApplication,
  );
}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("ملحقات الطلبية"),

      content: SizedBox(
        width: 450,
        child: files.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text("لا يوجد ملفات")),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: files.length,

                separatorBuilder: (_, __) => const Divider(),

                itemBuilder: (context, index) {
                  final file = files[index];

                  final isImage = file.fileType == "image";

                  return ListTile(
                    leading: Icon(
                      isImage ? Icons.image : Icons.insert_drive_file,
                    ),

                    subtitle: Text(file.fileType ?? ""),

                    trailing: Icon(
                      isImage ? Icons.open_in_new : Icons.download,
                    ),

                    onTap: () async {
                      if (file.filePath != null) {
                        await _openFile(file.filePath!);
                      }
                    },
                  );
                },
              ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("إغلاق"),
        ),
      ],
    );
  }
}
