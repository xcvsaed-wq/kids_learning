import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const KidsLearningApp());
}

class AppTheme {
  static const Color background = Color(0xFFFFF8E1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF5F0DC);
  static const Color border = Color(0xFFE0D8B8);
  static const Color primary = Color(0xFF7E57C2);
  static const Color primaryLight = Color(0xFF9575CD);
  static const Color success = Color(0xFF43A047);
  static const Color danger = Color(0xFFE53935);
  static const Color warning = Color(0xFFFB8C00);
  static const Color textPrimary = Color(0xFF2E1A47);
  static const Color textMuted = Color(0xFF6D6478);

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: primaryLight,
          surface: surface,
          error: danger,
          onPrimary: Colors.white,
          onSurface: textPrimary,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surfaceAlt,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: primaryLight, width: 1.5),
          ),
        ),
      );
}

class StarStore {
  static const String _key = 'kids_learning_stars_v1';
  static final ValueNotifier<int> notifier = ValueNotifier<int>(0);

  static Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      notifier.value = prefs.getInt(_key) ?? 0;
    } catch (_) {}
  }

  static Future<void> add() async {
    notifier.value = notifier.value + 1;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, notifier.value);
    } catch (_) {}
  }

  static Future<void> reset() async {
    notifier.value = 0;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, 0);
    } catch (_) {}
  }
}

class TtsService {
  static final FlutterTts _tts = FlutterTts();
  static bool _ready = false;

  static Future<void> init() async {
    if (_ready) return;
    try {
      await _tts.setLanguage('ar-SA');
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(1.1);
      await _tts.setVolume(1.0);
      _ready = true;
    } catch (_) {}
  }

  static Future<void> speak(String text) async {
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (_) {}
  }

  static Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {}
  }
}

class LetterItem {
  final String letter;
  final String word;
  final String emoji;
  const LetterItem(this.letter, this.word, this.emoji);
}

class NumberItem {
  final int value;
  final String word;
  final String arabicDigit;
  const NumberItem(this.value, this.word, this.arabicDigit);
}

class ColorItem {
  final String name;
  final Color color;
  final String emoji;
  const ColorItem(this.name, this.color, this.emoji);
}

class AnimalItem {
  final String name;
  final String emoji;
  final String action;
  const AnimalItem(this.name, this.emoji, this.action);
}

enum ShapeKind {
  circle,
  square,
  triangle,
  rectangle,
  star,
  heart,
  diamond,
  hexagon,
}

class ShapeItem {
  final String name;
  final ShapeKind kind;
  const ShapeItem(this.name, this.kind);
}

const List<LetterItem> kLetters = [
  LetterItem('ا', 'أسد', '🦁'),
  LetterItem('ب', 'بطة', '🦆'),
  LetterItem('ت', 'تفاح', '🍎'),
  LetterItem('ث', 'ثعلب', '🦊'),
  LetterItem('ج', 'جمل', '🐪'),
  LetterItem('ح', 'حصان', '🐴'),
  LetterItem('خ', 'خروف', '🐑'),
  LetterItem('د', 'دب', '🐻'),
  LetterItem('ذ', 'ذئب', '🐺'),
  LetterItem('ر', 'ريشة', '🪶'),
  LetterItem('ز', 'زرافة', '🦒'),
  LetterItem('س', 'سمكة', '🐟'),
  LetterItem('ش', 'شمس', '☀️'),
  LetterItem('ص', 'صقر', '🦅'),
  LetterItem('ض', 'ضفدع', '🐸'),
  LetterItem('ط', 'طائرة', '✈️'),
  LetterItem('ظ', 'ظرف', '✉️'),
  LetterItem('ع', 'عنب', '🍇'),
  LetterItem('غ', 'غزال', '🦌'),
  LetterItem('ف', 'فيل', '🐘'),
  LetterItem('ق', 'قمر', '🌙'),
  LetterItem('ك', 'كلب', '🐕'),
  LetterItem('ل', 'ليمون', '🍋'),
  LetterItem('م', 'موز', '🍌'),
  LetterItem('ن', 'نحلة', '🐝'),
  LetterItem('ه', 'هدية', '🎁'),
  LetterItem('و', 'وردة', '🌹'),
  LetterItem('ي', 'يد', '✋'),
];

const List<NumberItem> kNumbers = [
  NumberItem(1, 'واحد', '١'),
  NumberItem(2, 'اثنان', '٢'),
  NumberItem(3, 'ثلاثة', '٣'),
  NumberItem(4, 'أربعة', '٤'),
  NumberItem(5, 'خمسة', '٥'),
  NumberItem(6, 'ستة', '٦'),
  NumberItem(7, 'سبعة', '٧'),
  NumberItem(8, 'ثمانية', '٨'),
  NumberItem(9, 'تسعة', '٩'),
  NumberItem(10, 'عشرة', '١٠'),
];

const List<ColorItem> kColors = [
  ColorItem('أحمر', Color(0xFFE53935), '🍓'),
  ColorItem('أزرق', Color(0xFF1E88E5), '🌊'),
  ColorItem('أصفر', Color(0xFFFDD835), '🌻'),
  ColorItem('أخضر', Color(0xFF43A047), '🌳'),
  ColorItem('برتقالي', Color(0xFFFB8C00), '🍊'),
  ColorItem('بنفسجي', Color(0xFF8E24AA), '🍇'),
  ColorItem('وردي', Color(0xFFEC407A), '🌸'),
  ColorItem('بني', Color(0xFF6D4C41), '🍫'),
  ColorItem('أسود', Color(0xFF212121), '🐧'),
  ColorItem('أبيض', Color(0xFFF5F5F5), '☁️'),
];

const List<ShapeItem> kShapes = [
  ShapeItem('دائرة', ShapeKind.circle),
  ShapeItem('مربع', ShapeKind.square),
  ShapeItem('مثلث', ShapeKind.triangle),
  ShapeItem('مستطيل', ShapeKind.rectangle),
  ShapeItem('نجمة', ShapeKind.star),
  ShapeItem('قلب', ShapeKind.heart),
  ShapeItem('معين', ShapeKind.diamond),
  ShapeItem('سداسي', ShapeKind.hexagon),
];

const List<AnimalItem> kAnimals = [
  AnimalItem('أسد', '🦁', 'يزأر'),
  AnimalItem('فيل', '🐘', 'يخور'),
  AnimalItem('قرد', '🐵', 'يصرخ'),
  AnimalItem('زرافة', '🦒', 'طويلة'),
  AnimalItem('أرنب', '🐰', 'يقفز'),
  AnimalItem('قطة', '🐱', 'تموء'),
  AnimalItem('كلب', '🐶', 'ينبح'),
  AnimalItem('حصان', '🐴', 'يصهل'),
  AnimalItem('بقرة', '🐮', 'تخور'),
  AnimalItem('دجاجة', '🐔', 'تقرق'),
  AnimalItem('بطة', '🦆', 'تبطبط'),
  AnimalItem('سمكة', '🐟', 'تسبح'),
];

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kids_learning',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class CategoryEntry {
  final String title;
  final String subtitle;
  final String emoji;
  final Color color;
  final WidgetBuilder builder;
  const CategoryEntry({
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.color,
    required this.builder,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    StarStore.load();
    TtsService.init();
  }

  List<CategoryEntry> get _categories => const [
        CategoryEntry(
          title: 'الحروف',
          subtitle: 'أ ب ت',
          emoji: '🔤',
          color: Color(0xFFEF5350),
          builder: _lettersBuilder,
        ),
        CategoryEntry(
          title: 'الأرقام',
          subtitle: '١ ٢ ٣',
          emoji: '🔢',
          color: Color(0xFF42A5F5),
          builder: _numbersBuilder,
        ),
        CategoryEntry(
          title: 'الألوان',
          subtitle: 'ملوّن',
          emoji: '🎨',
          color: Color(0xFFAB47BC),
          builder: _colorsBuilder,
        ),
        CategoryEntry(
          title: 'الأشكال',
          subtitle: 'هندسة',
          emoji: '⭐',
          color: Color(0xFFFFA726),
          builder: _shapesBuilder,
        ),
        CategoryEntry(
          title: 'الحيوانات',
          subtitle: 'أصوات',
          emoji: '🐘',
          color: Color(0xFF66BB6A),
          builder: _animalsBuilder,
        ),
        CategoryEntry(
          title: 'الاختبار',
          subtitle: 'العب',
          emoji: '🎯',
          color: Color(0xFFEC407A),
          builder: _quizBuilder,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final cats = _categories;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.05,
                ),
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  return _CategoryCard(item: cats[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          const Text('🌟', style: TextStyle(fontSize: 36)),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تعلم معي',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  'هيا نلعب ونتعلم!',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: StarStore.notifier,
            builder: (context, stars, child) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$stars',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _lettersBuilder(BuildContext context) => const LettersScreen();
Widget _numbersBuilder(BuildContext context) => const NumbersScreen();
Widget _colorsBuilder(BuildContext context) => const ColorsScreen();
Widget _shapesBuilder(BuildContext context) => const ShapesScreen();
Widget _animalsBuilder(BuildContext context) => const AnimalsScreen();
Widget _quizBuilder(BuildContext context) => const QuizScreen();

class _CategoryCard extends StatefulWidget {
  final CategoryEntry item;
  const _CategoryCard({required this.item});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails d) {
    setState(() => _pressed = true);
  }

  void _onTapUp(TapUpDetails d) {
    setState(() => _pressed = false);
  }

  void _onTapCancel() {
    setState(() => _pressed = false);
  }

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak(widget.item.title);
    Navigator.of(context).push(
      MaterialPageRoute(builder: widget.item.builder),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(0.45),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 44)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LettersScreen extends StatelessWidget {
  const LettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الحروف الهجائية'),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        itemCount: kLetters.length,
        itemBuilder: (context, index) {
          return _LetterCard(item: kLetters[index]);
        },
      ),
    );
  }
}

class _LetterCard extends StatefulWidget {
  final LetterItem item;
  const _LetterCard({required this.item});

  @override
  State<_LetterCard> createState() => _LetterCardState();
}

class _LetterCardState extends State<_LetterCard> {
  bool _pressed = false;

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak('${widget.item.letter} ${widget.item.word}');
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.93 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.letter,
                style: const TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(item.emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  item.word,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
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

class NumbersScreen extends StatelessWidget {
  const NumbersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الأرقام'),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: kNumbers.length,
        itemBuilder: (context, index) {
          return _NumberCard(item: kNumbers[index]);
        },
      ),
    );
  }
}

class _NumberCard extends StatefulWidget {
  final NumberItem item;
  const _NumberCard({required this.item});

  @override
  State<_NumberCard> createState() => _NumberCardState();
}

class _NumberCardState extends State<_NumberCard> {
  bool _pressed = false;

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak(widget.item.word);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.97 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 68,
                height: 68,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF42A5F5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  '${item.value}',
                  style: const TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.word,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 2,
                      children: List.generate(
                        item.value,
                        (_) => const Text(
                          '⭐',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item.arabicDigit,
                style: const TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1565C0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الألوان'),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
        ),
        itemCount: kColors.length,
        itemBuilder: (context, index) {
          return _ColorCard(item: kColors[index]);
        },
      ),
    );
  }
}

class _ColorCard extends StatefulWidget {
  final ColorItem item;
  const _ColorCard({required this.item});

  @override
  State<_ColorCard> createState() => _ColorCardState();
}

class _ColorCardState extends State<_ColorCard> {
  bool _pressed = false;

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak(widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final bool isLight = item.color.computeLuminance() > 0.7;
    final Color textColor = isLight ? Colors.black87 : Colors.white;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(22),
            border: isLight
                ? Border.all(color: Colors.black12, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 46)),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShapesScreen extends StatelessWidget {
  const ShapesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الأشكال'),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: kShapes.length,
        itemBuilder: (context, index) {
          return _ShapeCard(item: kShapes[index]);
        },
      ),
    );
  }
}

class _ShapeCard extends StatefulWidget {
  final ShapeItem item;
  const _ShapeCard({required this.item});

  @override
  State<_ShapeCard> createState() => _ShapeCardState();
}

class _ShapeCardState extends State<_ShapeCard> {
  bool _pressed = false;

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak(widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 84,
                height: 84,
                child: CustomPaint(
                  painter: ShapePainter(
                    kind: item.kind,
                    color: const Color(0xFFFFA726),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final ShapeKind kind;
  final Color color;

  ShapePainter({required this.kind, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double r = size.width / 2 - 4;

    switch (kind) {
      case ShapeKind.circle:
        canvas.drawCircle(center, r, paint);
        break;
      case ShapeKind.square:
        canvas.drawRect(
          Rect.fromCenter(center: center, width: r * 1.75, height: r * 1.75),
          paint,
        );
        break;
      case ShapeKind.triangle:
        final Path path = Path()
          ..moveTo(center.dx, center.dy - r)
          ..lineTo(center.dx - r, center.dy + r)
          ..lineTo(center.dx + r, center.dy + r)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case ShapeKind.rectangle:
        canvas.drawRect(
          Rect.fromCenter(center: center, width: r * 2, height: r * 1.2),
          paint,
        );
        break;
      case ShapeKind.star:
        canvas.drawPath(_starPath(center, r, r * 0.45, 5), paint);
        break;
      case ShapeKind.heart:
        canvas.drawPath(_heartPath(center, r), paint);
        break;
      case ShapeKind.diamond:
        final Path path = Path()
          ..moveTo(center.dx, center.dy - r)
          ..lineTo(center.dx + r, center.dy)
          ..lineTo(center.dx, center.dy + r)
          ..lineTo(center.dx - r, center.dy)
          ..close();
        canvas.drawPath(path, paint);
        break;
      case ShapeKind.hexagon:
        final Path path = Path();
        for (int i = 0; i < 6; i++) {
          final double angle = (i * 60 - 90) * pi / 180;
          final double x = center.dx + r * cos(angle);
          final double y = center.dy + r * sin(angle);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  Path _starPath(Offset center, double outer, double inner, int points) {
    final Path path = Path();
    for (int i = 0; i < points * 2; i++) {
      final double rr = i.isEven ? outer : inner;
      final double angle = (i * 180 / points - 90) * pi / 180;
      final double x = center.dx + rr * cos(angle);
      final double y = center.dy + rr * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  Path _heartPath(Offset center, double r) {
    final Path path = Path();
    final double w = r * 1.8;
    final double h = r * 1.6;
    path.moveTo(center.dx, center.dy + h * 0.5);
    path.cubicTo(
      center.dx - w,
      center.dy - h * 0.3,
      center.dx - w * 0.5,
      center.dy - h,
      center.dx,
      center.dy - h * 0.3,
    );
    path.cubicTo(
      center.dx + w * 0.5,
      center.dy - h,
      center.dx + w,
      center.dy - h * 0.3,
      center.dx,
      center.dy + h * 0.5,
    );
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant ShapePainter old) {
    return old.kind != kind || old.color != color;
  }
}

class AnimalsScreen extends StatelessWidget {
  const AnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الحيوانات'),
      body: GridView.builder(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: kAnimals.length,
        itemBuilder: (context, index) {
          return _AnimalCard(item: kAnimals[index]);
        },
      ),
    );
  }
}

class _AnimalCard extends StatefulWidget {
  final AnimalItem item;
  const _AnimalCard({required this.item});

  @override
  State<_AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<_AnimalCard> {
  bool _pressed = false;

  void _onTap() {
    HapticFeedback.lightImpact();
    TtsService.speak('${widget.item.name} ${widget.item.action}');
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.94 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF81C784), Color(0xFF43A047)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 54)),
              const SizedBox(height: 8),
              Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                item.action,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizQuestion {
  final String prompt;
  final String question;
  final List<String> options;
  final int correctIndex;
  final Color color;

  QuizQuestion({
    required this.prompt,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.color,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Random _rng = Random();
  late QuizQuestion _current;
  int _score = 0;
  int _total = 0;
  int? _selected;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _current = _generate();
  }

  QuizQuestion _generate() {
    final int type = _rng.nextInt(3);
    if (type == 0) return _lettersQuestion();
    if (type == 1) return _numbersQuestion();
    return _colorsQuestion();
  }

  QuizQuestion _lettersQuestion() {
    final LetterItem correct = kLetters[_rng.nextInt(kLetters.length)];
    final List<String> options = <String>[correct.letter];
    while (options.length < 4) {
      final String other = kLetters[_rng.nextInt(kLetters.length)].letter;
      if (!options.contains(other)) options.add(other);
    }
    options.shuffle(_rng);
    return QuizQuestion(
      prompt: correct.emoji,
      question: 'ما الحرف الأول من "${correct.word}"؟',
      options: options,
      correctIndex: options.indexOf(correct.letter),
      color: const Color(0xFFEF5350),
    );
  }

  QuizQuestion _numbersQuestion() {
    final NumberItem correct = kNumbers[_rng.nextInt(kNumbers.length)];
    final List<String> options = <String>[correct.word];
    while (options.length < 4) {
      final String other = kNumbers[_rng.nextInt(kNumbers.length)].word;
      if (!options.contains(other)) options.add(other);
    }
    options.shuffle(_rng);
    return QuizQuestion(
      prompt: '${correct.value}',
      question: 'ما اسم الرقم ${correct.value}؟',
      options: options,
      correctIndex: options.indexOf(correct.word),
      color: const Color(0xFF42A5F5),
    );
  }

  QuizQuestion _colorsQuestion() {
    final ColorItem correct = kColors[_rng.nextInt(kColors.length)];
    final List<String> options = <String>[correct.name];
    while (options.length < 4) {
      final String other = kColors[_rng.nextInt(kColors.length)].name;
      if (!options.contains(other)) options.add(other);
    }
    options.shuffle(_rng);
    return QuizQuestion(
      prompt: correct.emoji,
      question: 'ما هذا اللون؟',
      options: options,
      correctIndex: options.indexOf(correct.name),
      color: correct.color,
    );
  }

  void _select(int index) {
    if (_answered) return;
    final bool isCorrect = index == _current.correctIndex;
    setState(() {
      _selected = index;
      _answered = true;
      _total = _total + 1;
      if (isCorrect) {
        _score = _score + 1;
      }
    });
    HapticFeedback.mediumImpact();
    if (isCorrect) {
      StarStore.add();
      TtsService.speak('أحسنت');
    } else {
      TtsService.speak('حاول مرة أخرى');
    }
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      setState(() {
        _current = _generate();
        _selected = null;
        _answered = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildKidsAppBar(context, 'الاختبار'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  _scoreChip('النتيجة', '$_score / $_total', AppTheme.success),
                  const SizedBox(width: 8),
                  _scoreChip(
                    'الدقة',
                    '${_total == 0 ? 0 : (_score / _total * 100).toInt()}%',
                    AppTheme.warning,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _questionCard(),
              const SizedBox(height: 20),
              Expanded(child: _optionsGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _questionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _current.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _current.color.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(_current.prompt, style: const TextStyle(fontSize: 74)),
          const SizedBox(height: 10),
          Text(
            _current.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemCount: _current.options.length,
      itemBuilder: (context, index) {
        return _buildOption(index);
      },
    );
  }

  Widget _buildOption(int index) {
    final bool isCorrect = index == _current.correctIndex;
    final bool isSelected = index == _selected;

    Color bg = AppTheme.surface;
    Color borderColor = _current.color;

    if (_answered) {
      if (isCorrect) {
        bg = Colors.green.shade100;
        borderColor = Colors.green;
      } else if (isSelected) {
        bg = Colors.red.shade100;
        borderColor = Colors.red;
      }
    }

    return GestureDetector(
      onTap: () => _select(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 2.5),
        ),
        alignment: Alignment.center,
        child: Text(
          _current.options[index],
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _scoreChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildKidsAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        TtsService.stop();
        Navigator.of(context).pop();
      },
    ),
  );
}