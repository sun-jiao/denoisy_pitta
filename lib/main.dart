import 'package:flutter/material.dart';
import 'package:fonnx/models/msmarcoMiniLmL6V3/msmarco_mini_lm_l6_v3.dart';

void main() {
  runApp(const DenoisyPitta());
}

class DenoisyPitta extends StatelessWidget {
  const DenoisyPitta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Denoisy Pitta'),
        ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: ImagePreviewLabel(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectImagesButton(),
                    ClearImagesButton(),
                    ImageList(),
                    ImageOperationsLabel(),
                    ExportOriginalCheckbox(),
                    SelectOutputDirectoryButton(),
                    GPUandCPURadioButtons(),
                    ProcessButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePreviewLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/placeholder.jpg'), // Placeholder for initial image
    );
  }
}

class SelectImagesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add logic for selecting images
      },
      child: Text('Select Images'),
    );
  }
}

class ClearImagesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add logic for clearing images
      },
      child: Text('Clear Images'),
    );
  }
}

class ImageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Add logic to display selected images
        ],
      ),
    );
  }
}

class ImageOperationsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Image Operations:');
  }
}

class ExportOriginalCheckbox extends StatefulWidget {
  @override
  _ExportOriginalCheckboxState createState() => _ExportOriginalCheckboxState();
}

class _ExportOriginalCheckboxState extends State<ExportOriginalCheckbox> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value ?? false;
        });
        // Add logic for handling checkbox state change
      },
    );
  }
}

class SelectOutputDirectoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add logic for selecting output directory
      },
      child: Text('Select Output Directory'),
    );
  }
}

class GPUandCPURadioButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: 0, groupValue: null, onChanged: null), // Add logic for GPU
        Text('Use GPU'),
        Radio(value: 1, groupValue: null, onChanged: null), // Add logic for CPU
        Text('Use CPU'),
      ],
    );
  }
}

class ProcessButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add logic for processing and saving images
      },
      child: Text('Process and Save'),
    );
  }
}
