import 'package:clockify_project/component/circular_checkbox.dart';
import 'package:flutter/material.dart';

class GeneralSettingsTab extends StatefulWidget {
  const GeneralSettingsTab({Key? key}) : super(key: key);

  @override
  State<GeneralSettingsTab> createState() => _GeneralSettingsTabState();
}

class _GeneralSettingsTabState extends State<GeneralSettingsTab> {
  final List<String> _optionLanguage = ['English', 'Thai'];
  final List<String> _timeZone = [
    '(UTC -12:00) International Date Line West',
    '(UTC -11:00) Coordinated Universal Time-11',
    '(UTC -10:00) Hawaii-Aleutian Standard Time',
    '(UTC -09:00) Alaska Standard Time',
    '(UTC -08:00) Pacific Standard Time',
    '(UTC -07:00) Mountain Standard Time',
    '(UTC -07:00) Pacific Daylight Time (US & Canada)',
    '(UTC -06:00) Central Standard Time',
    '(UTC -06:00) Mountain Daylight Time (US & Canada)',
    '(UTC -05:00) Eastern Standard Time',
    '(UTC -05:00) Central Daylight Time (US & Canada)',
    '(UTC -04:00) Atlantic Standard Time',
    '(UTC -04:00) Eastern Daylight Time (US & Canada)',
    '(UTC -03:30) Newfoundland Standard Time',
    '(UTC -03:00) Argentina Standard Time',
    '(UTC -03:00) Atlantic Daylight Time (Canada)',
    '(UTC -02:00) Coordinated Universal Time-02',
    '(UTC -01:00) Azores Standard Time',
    '(UTC ±00:00) Coordinated Universal Time',
    '(UTC ±00:00) Greenwich Mean Time',
    '(UTC +01:00) Central European Standard Time',
    '(UTC +01:00) West Africa Standard Time',
    '(UTC +02:00) Central Africa Standard Time',
    '(UTC +02:00) Eastern European Standard Time',
    '(UTC +02:00) South Africa Standard Time',
    '(UTC +03:00) East Africa Time',
    '(UTC +03:00) Arabia Standard Time',
    '(UTC +03:30) Iran Standard Time',
    '(UTC +04:00) Gulf Standard Time',
    '(UTC +04:30) Afghanistan Time',
    '(UTC +05:00) Pakistan Standard Time',
    '(UTC +05:30) Indian Standard Time',
    '(UTC +05:45) Nepal Time',
    '(UTC +06:00) Bangladesh Standard Time',
    '(UTC +06:30) Myanmar Time',
    '(UTC +07:00) Indochina Time',
    '(UTC +07:00) Asia/Bangkok',
    '(UTC +08:00) China Standard Time',
    '(UTC +08:00) Australian Western Standard Time',
    '(UTC +09:00) Japan Standard Time',
    '(UTC +09:30) Australian Central Standard Time',
    '(UTC +10:00) Australian Eastern Standard Time',
    '(UTC +10:00) Vladivostok Standard Time',
    '(UTC +11:00) Solomon Islands Time',
    '(UTC +12:00) Fiji Time',
    '(UTC +12:00) New Zealand Standard Time',
    '(UTC +13:00) Tonga Time',
    '(UTC +14:00) Line Islands Time',
  ];

  final List<String> _dateFormat = [
    'MM/dd/yyyy', // 12/31/2024
    'dd/MM/yyyy', // 31/12/2024
    'yyyy-MM-dd', // 2024-12-31
    'dd-MM-yyyy', // 31-12-2024
    'MMMM dd, yyyy', // December 31, 2024
    'dd MMMM yyyy', // 31 December 2024
    'MMM dd, yyyy', // Dec 31, 2024
    'dd MMM yyyy', // 31 Dec 2024
    'yyyy.MM.dd', // 2024.12.31
    'MM.dd.yyyy', // 12.31.2024
    'dd.MM.yyyy', // 31.12.2024
    'yyyy/MM/dd', // 2024/12/31
    'dd/MMM/yyyy', // 31/Dec/2024
    'EEE, MMM dd, yyyy', // Tue, Dec 31, 2024
    'EEEE, dd MMMM yyyy', // Tuesday, 31 December 2024
    'yyyyMMdd', // 20241231
    'MMddyyyy', // 12312024
    'ddMMyyyy', // 31122024
  ];

  final List<String> _timeFormat = [
    'HH:mm:ss', // 14:30:00
    'hh:mm:ss a', // 02:30:00 PM
    'HH:mm', // 14:30
    'hh:mm a', // 02:30 PM
    'H:mm', // 2:30
    'h:mm a', // 2:30 PM
  ];

  final List<String> _weekStart = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  String _selectedLanguage = '';
  String _selectedTimeZone = '';
  String _selectedDateFormat = '';
  String _selectedTimeFormat = '';
  String _selectedWeekStart = '';

  @override
  void initState() {
    super.initState();
    _selectedLanguage = _optionLanguage[0];
    _selectedTimeZone = _timeZone[0];
    _selectedDateFormat = _dateFormat[0];
    _selectedTimeFormat = _timeFormat[0];
    _selectedWeekStart = _weekStart[1]; // Default to Monday
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
                'Themes', 'Choose your theme to suit your mood.'),
            _buildThemeSelection(),
            SizedBox(height: 10),
            _buildSectionHeader('Language',
                'Set language in which Clockify is displayed in all your workspaces.'),
            _buildDropdown('Language', _selectedLanguage, _optionLanguage,
                (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
              });
            }),
            _buildSectionHeader(
                'Time settings', 'Configure your time settings.'),
            _buildDropdown('Time zone', _selectedTimeZone, _timeZone,
                (String? newValue) {
              setState(() {
                _selectedTimeZone = newValue!;
              });
            }),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                      'Date format', _selectedDateFormat, _dateFormat,
                      (String? newValue) {
                    setState(() {
                      _selectedDateFormat = newValue!;
                    });
                  }),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildDropdown(
                      'Time format', _selectedTimeFormat, _timeFormat,
                      (String? newValue) {
                    setState(() {
                      _selectedTimeFormat = newValue!;
                    });
                  }),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                      'Week start', _selectedWeekStart, _weekStart,
                      (String? newValue) {
                    setState(() {
                      _selectedWeekStart = newValue!;
                    });
                  }),
                ),
                // Add 'Day start' dropdown or widget here if needed
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyLarge),
        Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildThemeSelection() {
    return Row(
      children: [
        Row(children: [
          CircularCheckbox(),
          SizedBox(width: 5),
          Text('Light'),
        ]),
        SizedBox(width: 20),
        Row(children: [
          CircularCheckbox(),
          SizedBox(width: 5),
          Text('Dark'),
        ]),
      ],
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
