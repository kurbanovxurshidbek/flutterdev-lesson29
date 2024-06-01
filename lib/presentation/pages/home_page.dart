import 'package:flutter/material.dart';
import '../../core/services/log_service.dart';
import '../../core/services/utils_service.dart';
import '../../data/repositories/gemini_talk_repository_impl.dart';
import '../../domain/usecases/gemini_text_and_image_usecase.dart';
import '../../domain/usecases/gemini_text_only_usecase.dart';
import '../widgets/loading_view.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GeminiTextOnlyUseCase textOnlyUseCase = GeminiTextOnlyUseCase(GeminiTalkRepositoryImpl());
  GeminiTextAndImageUseCase textAndImageUseCase = GeminiTextAndImageUseCase(GeminiTalkRepositoryImpl());

  apiTextOnly() async {
    var text = "What is the best way to learn Flutter development?";
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
    });
  }

  apiTextAndImage() async {
    var text = "What is this image?";
    var base64 = await Utils.pickAndConvertImage();

    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      LogService.d(l);
    }, (r) async {
      LogService.d(r);
    });
  }

  @override
  void initState() {
    super.initState();
    apiTextOnly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Gemini"),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView(),
                ),
                Container(
                  height: 50,
                  color: Colors.grey[300],
                  child: TextField(),
                ),
              ],
            ),
          ),

          const LoadingView(showIndicator: true,),
        ],
      )
    );
  }
}
