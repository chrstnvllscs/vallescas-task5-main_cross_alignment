import 'package:flutter/material.dart';

void main() {
  runApp(const MainCrossAlignmentApp());
}

class MainCrossAlignmentApp extends StatelessWidget {
  const MainCrossAlignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TASK 5 - VALLESCAS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const AlignmentDemoHomePage(),
    );
  }
}

enum WidgetType {
  row('Row Widget', Icons.table_rows_outlined),
  column('Column Widget', Icons.view_column_outlined);

  final String label;
  final IconData icon;
  const WidgetType(this.label, this.icon);
}

enum AlignmentCategory {
  mainAxis('MainAxisAlignment'),
  crossAxis('CrossAxisAlignment');

  final String label;
  const AlignmentCategory(this.label);
}

class AlignmentOption {
  final String name;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const AlignmentOption({
    required this.name,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });
}

class AlignmentDemoHomePage extends StatefulWidget {
  const AlignmentDemoHomePage({super.key});

  @override
  State<AlignmentDemoHomePage> createState() => _AlignmentDemoHomePageState();
}

class _AlignmentDemoHomePageState extends State<AlignmentDemoHomePage> {
  WidgetType _selectedWidgetType = WidgetType.row;
  AlignmentCategory _selectedCategory = AlignmentCategory.mainAxis;
  int _selectedMainIndex = 0;
  int _selectedCrossIndex = 0;
  bool _cleanScreenshotMode = false;
  bool _showGridOverview = false;

  // MainAxisAlignment properties: center, spaceAround, spaceBetween, spaceEvenly, start, end
  static const List<AlignmentOption> mainAxisOptions = [
    AlignmentOption(
      name: 'MainAxisAlignment.center',
      mainAxisAlignment: MainAxisAlignment.center,
    ),
    AlignmentOption(
      name: 'MainAxisAlignment.spaceAround',
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    ),
    AlignmentOption(
      name: 'MainAxisAlignment.spaceBetween',
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ),
    AlignmentOption(
      name: 'MainAxisAlignment.spaceEvenly',
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    ),
    AlignmentOption(
      name: 'MainAxisAlignment.start',
      mainAxisAlignment: MainAxisAlignment.start,
    ),
    AlignmentOption(
      name: 'MainAxisAlignment.end',
      mainAxisAlignment: MainAxisAlignment.end,
    ),
  ];

  // CrossAxisAlignment properties: start, end, baseline, center, stretch
  static const List<AlignmentOption> crossAxisOptions = [
    AlignmentOption(
      name: 'CrossAxisAlignment.start',
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    AlignmentOption(
      name: 'CrossAxisAlignment.end',
      crossAxisAlignment: CrossAxisAlignment.end,
    ),
    AlignmentOption(
      name: 'CrossAxisAlignment.baseline',
      crossAxisAlignment: CrossAxisAlignment.baseline,
    ),
    AlignmentOption(
      name: 'CrossAxisAlignment.center',
      crossAxisAlignment: CrossAxisAlignment.center,
    ),
    AlignmentOption(
      name: 'CrossAxisAlignment.stretch',
      crossAxisAlignment: CrossAxisAlignment.stretch,
    ),
  ];

  AlignmentOption get _currentOption {
    if (_selectedCategory == AlignmentCategory.mainAxis) {
      return mainAxisOptions[_selectedMainIndex];
    } else {
      return crossAxisOptions[_selectedCrossIndex];
    }
  }

  void _nextAlignment() {
    setState(() {
      if (_selectedCategory == AlignmentCategory.mainAxis) {
        _selectedMainIndex = (_selectedMainIndex + 1) % mainAxisOptions.length;
      } else {
        _selectedCrossIndex = (_selectedCrossIndex + 1) % crossAxisOptions.length;
      }
    });
  }

  void _prevAlignment() {
    setState(() {
      if (_selectedCategory == AlignmentCategory.mainAxis) {
        _selectedMainIndex = (_selectedMainIndex - 1 + mainAxisOptions.length) % mainAxisOptions.length;
      } else {
        _selectedCrossIndex = (_selectedCrossIndex - 1 + crossAxisOptions.length) % crossAxisOptions.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF2F8), // Soft pastel background matching sample PDF
      appBar: AppBar(
        title: const Text(
          'TASK 5 - VALLESCAS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            tooltip: _showGridOverview ? 'Single View' : 'All Examples Overview',
            icon: Icon(_showGridOverview ? Icons.view_agenda : Icons.grid_view_rounded),
            onPressed: () {
              setState(() {
                _showGridOverview = !_showGridOverview;
              });
            },
          ),
          IconButton(
            tooltip: _cleanScreenshotMode ? 'Show Controls' : 'Clean Screenshot Mode',
            icon: Icon(_cleanScreenshotMode ? Icons.fullscreen_exit : Icons.camera_alt_outlined),
            onPressed: () {
              setState(() {
                _cleanScreenshotMode = !_cleanScreenshotMode;
              });
            },
          ),
        ],
      ),
      body: _showGridOverview
          ? _buildGridOverview()
          : Column(
              children: [
                // Top control bar (hidden in clean screenshot mode)
                if (!_cleanScreenshotMode) _buildTopControls(),

                // Center Demonstration View matching the PDF style
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapUp: _cleanScreenshotMode
                        ? (details) {
                            final width = MediaQuery.of(context).size.width;
                            if (details.localPosition.dx > width / 2) {
                              _nextAlignment();
                            } else {
                              _prevAlignment();
                            }
                          }
                        : null,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Alignment Name Label matching the PDF screenshot
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Text(
                                  _currentOption.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),

                              // The alignment demonstration
                              _buildDemonstrationCanvas(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom control panel (hidden in clean screenshot mode)
                if (!_cleanScreenshotMode) _buildBottomControlPanel(),
              ],
            ),
    );
  }

  /// Top controls: Widget selector (Row vs Column) and Category selector
  Widget _buildTopControls() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 420;
          final rowColToggle = SegmentedButton<WidgetType>(
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
            ),
            segments: const [
              ButtonSegment(
                value: WidgetType.row,
                label: Text('Row'),
                icon: Icon(Icons.table_rows, size: 16),
              ),
              ButtonSegment(
                value: WidgetType.column,
                label: Text('Column'),
                icon: Icon(Icons.view_column, size: 16),
              ),
            ],
            selected: {_selectedWidgetType},
            onSelectionChanged: (newSelection) {
              setState(() {
                _selectedWidgetType = newSelection.first;
              });
            },
          );

          final categoryToggle = SegmentedButton<AlignmentCategory>(
            showSelectedIcon: false,
            style: SegmentedButton.styleFrom(
              selectedBackgroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
            ),
            segments: const [
              ButtonSegment(
                value: AlignmentCategory.mainAxis,
                label: Text('MainAxis'),
              ),
              ButtonSegment(
                value: AlignmentCategory.crossAxis,
                label: Text('CrossAxis'),
              ),
            ],
            selected: {_selectedCategory},
            onSelectionChanged: (newSelection) {
              setState(() {
                _selectedCategory = newSelection.first;
              });
            },
          );

          if (isNarrow) {
            return Column(
              children: [
                SizedBox(width: double.infinity, child: rowColToggle),
                const SizedBox(height: 8),
                SizedBox(width: double.infinity, child: categoryToggle),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: rowColToggle),
              const SizedBox(width: 12),
              Expanded(child: categoryToggle),
            ],
          );
        },
      ),
    );
  }

  /// The interactive demonstration canvas
  Widget _buildDemonstrationCanvas() {
    final isRow = _selectedWidgetType == WidgetType.row;
    final isMain = _selectedCategory == AlignmentCategory.mainAxis;

    final mainAlign = isMain ? _currentOption.mainAxisAlignment! : MainAxisAlignment.center;
    final crossAlign = !isMain
        ? _currentOption.crossAxisAlignment!
        : CrossAxisAlignment.center;

    // In Row: CrossAxis demonstration requires explicit container height
    // In Column: MainAxis demonstration requires explicit container height
    final double containerHeight;
    if (isRow) {
      containerHeight = isMain ? 100.0 : 180.0;
    } else {
      containerHeight = isMain ? 260.0 : 200.0;
    }

    return Container(
      width: double.infinity,
      height: containerHeight,
      // Transparent to match the sample PDF exactly
      decoration: BoxDecoration(
        color: _cleanScreenshotMode ? Colors.transparent : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
        border: _cleanScreenshotMode
            ? null
            : Border.all(
                color: Colors.black.withValues(alpha: 0.08),
                width: 1.0,
              ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: isRow
            ? _buildRowLayout(mainAlign, crossAlign, WidgetType.row)
            : _buildColumnLayout(mainAlign, crossAlign, WidgetType.column),
      ),
    );
  }

  /// Row layout implementation
  Widget _buildRowLayout(MainAxisAlignment mainAlign, CrossAxisAlignment crossAlign, WidgetType widgetType) {
    final isBaseline = crossAlign == CrossAxisAlignment.baseline;
    final isStretch = crossAlign == CrossAxisAlignment.stretch;

    return Row(
      mainAxisAlignment: mainAlign,
      crossAxisAlignment: crossAlign,
      textBaseline: isBaseline ? TextBaseline.alphabetic : null,
      children: [
        _buildDemoBox(
          color: const Color(0xFFE53935), // Red box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedHeight: isStretch ? null : 55,
        ),
        _buildDemoBox(
          color: const Color(0xFFFFEB3B), // Yellow box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedHeight: isStretch ? null : 55,
        ),
        _buildDemoBox(
          color: const Color(0xFF2196F3), // Blue box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedHeight: isStretch ? null : 55,
        ),
      ],
    );
  }

  /// Column layout implementation
  Widget _buildColumnLayout(MainAxisAlignment mainAlign, CrossAxisAlignment crossAlign, WidgetType widgetType) {
    final isStretch = crossAlign == CrossAxisAlignment.stretch;
    final safeCrossAlign = crossAlign == CrossAxisAlignment.baseline
        ? CrossAxisAlignment.start
        : crossAlign;

    return Column(
      mainAxisAlignment: mainAlign,
      crossAxisAlignment: safeCrossAlign,
      children: [
        _buildDemoBox(
          color: const Color(0xFFE53935), // Red box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedWidth: isStretch ? null : 55,
          fixedHeight: 55,
        ),
        _buildDemoBox(
          color: const Color(0xFFFFEB3B), // Yellow box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedWidth: isStretch ? null : 55,
          fixedHeight: 55,
        ),
        _buildDemoBox(
          color: const Color(0xFF2196F3), // Blue box
          isStretch: isStretch,
          widgetType: widgetType,
          fixedWidth: isStretch ? null : 55,
          fixedHeight: 55,
        ),
      ],
    );
  }

  /// Colored boxes matching the PDF screenshots
  Widget _buildDemoBox({
    required Color color,
    required WidgetType widgetType,
    bool isStretch = false,
    double? fixedWidth = 55,
    double? fixedHeight = 55,
  }) {
    return Container(
      width: isStretch && widgetType == WidgetType.column ? double.infinity : fixedWidth,
      height: isStretch && widgetType == WidgetType.row ? double.infinity : fixedHeight,
      margin: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  /// Bottom control panel with chips and navigation buttons
  Widget _buildBottomControlPanel() {
    final isMain = _selectedCategory == AlignmentCategory.mainAxis;
    final options = isMain ? mainAxisOptions : crossAxisOptions;
    final currentIndex = isMain ? _selectedMainIndex : _selectedCrossIndex;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Chips for each alignment property
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(options.length, (index) {
                final isSelected = index == currentIndex;
                final shortName = options[index].name.split('.').last;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(shortName),
                    selected: isSelected,
                    selectedColor: Colors.black,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12.5,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          if (isMain) {
                            _selectedMainIndex = index;
                          } else {
                            _selectedCrossIndex = index;
                          }
                        });
                      }
                    },
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 6),
          // Navigation controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: _prevAlignment,
                icon: const Icon(Icons.arrow_back_ios, size: 14),
                label: const Text('Previous'),
              ),
              Text(
                '${currentIndex + 1} of ${options.length}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                onPressed: _nextAlignment,
                icon: const Icon(Icons.arrow_forward_ios, size: 14),
                label: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// All Examples Grid/List Overview
  Widget _buildGridOverview() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: const TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'Row Widget Examples'),
                Tab(text: 'Column Widget Examples'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildOverviewList(WidgetType.row),
                _buildOverviewList(WidgetType.column),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewList(WidgetType type) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Section 1: MainAxisAlignment
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'MainAxisAlignment Examples (6)',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ...mainAxisOptions.map((opt) => _buildOverviewCard(type, opt, true)),

        const SizedBox(height: 16),
        // Section 2: CrossAxisAlignment
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'CrossAxisAlignment Examples (5)',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ...crossAxisOptions.map((opt) => _buildOverviewCard(type, opt, false)),
      ],
    );
  }

  Widget _buildOverviewCard(WidgetType type, AlignmentOption option, bool isMain) {
    final isRow = type == WidgetType.row;
    final mainAlign = isMain ? option.mainAxisAlignment! : MainAxisAlignment.center;
    final crossAlign = !isMain ? option.crossAxisAlignment! : CrossAxisAlignment.center;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Container(
              height: isRow ? 90 : 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2F8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: isRow
                    ? _buildRowLayout(mainAlign, crossAlign, type)
                    : _buildColumnLayout(mainAlign, crossAlign, type),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
