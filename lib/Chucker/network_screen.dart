import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'ch_provider.dart';

class ChNetworkScreen extends StatelessWidget {
  const ChNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var httpResList = Provider.of<ChuckerHttpProvider>(context).getHttpResList;

    return ListView.builder(
        itemCount: httpResList.length,
        itemBuilder: (context, index) {
          var res = httpResList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                '${res.statusCode}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${res.request}',
                      maxLines: 6,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${res.request?.url.host}',
                      maxLines: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text('9:38:44 PM'),
                        Text('200ms'),
                        Text('${res.bodyBytes.elementSizeInBytes} B'),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          );
        });
  }
}
