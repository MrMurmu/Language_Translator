import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:shimmer/shimmer.dart';  // add shimmer package

class LanguageTranslations extends StatefulWidget {
  const LanguageTranslations({super.key});

  @override
  State<LanguageTranslations> createState() => _LanguageTranslationsState();
}

class _LanguageTranslationsState extends State<LanguageTranslations> {
  var language = ['English', 'Bengali', 'Hindi'];
  var originLanguage = 'From';
  var destinationLanguage = "To";
  var output = '';
  bool isLoading = false;

  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--' || input.trim().isEmpty) {
      setState(() {
        output = 'Fail to translate';
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      output = '';
    });

    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);

    setState(() {
      output = translation.text.toString();
      isLoading = false;
    });
  }

  String getalanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Bengali') {
      return 'bn';
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(70),
  child: AppBar(
    backgroundColor: Colors.grey.shade100,
    elevation: 0,
    centerTitle: true,
    title: const Padding(
      padding: EdgeInsets.only(top: 12),
      child: Text(
        "Language Translator",
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          letterSpacing: 1.5,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
),

      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              // Language selection row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      constraints: BoxConstraints(maxWidth: 140),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black54),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: originLanguage == 'From' ? null : originLanguage,
                        hint: Text(
                          originLanguage,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        underline: const SizedBox(),
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black87,
                        ),
                        items:
                            language.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                child: Text(dropDownStringItem),
                                value: dropDownStringItem,
                              );
                            }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            originLanguage = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 24),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.black54,
                  ),

                  const SizedBox(width: 24),

                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      constraints: BoxConstraints(maxWidth: 140),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black54),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value:
                            destinationLanguage == 'To'
                                ? null
                                : destinationLanguage,
                        hint: Text(
                          destinationLanguage,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        underline: const SizedBox(),
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black87,
                        ),
                        items:
                            language.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                child: Text(dropDownStringItem),
                                value: dropDownStringItem,
                              );
                            }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            destinationLanguage = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // Input text field
              TextFormField(
                controller: languageController,
                cursorColor: Colors.black87,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Please enter your text",
                  labelStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.primaryColor, width: 2),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text to translate';
                  }
                  return null;
                },
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              // Translate button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: theme.primaryColor.withOpacity(0.5),
                  ),
                  onPressed: () {
                    translate(
                      getalanguageCode(originLanguage),
                      getalanguageCode(destinationLanguage),
                      languageController.text.toString(),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.translate),
                      SizedBox(width: 5),
                      Text(
                        "Translate",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Output text container with shimmer effect
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 30,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        output.isEmpty ? 'Translation will appear here' : output,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: output.isEmpty ? Colors.black38 : Colors.black87,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
