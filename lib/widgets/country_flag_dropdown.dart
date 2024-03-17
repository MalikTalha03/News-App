import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flag/flag.dart';

class CountryFlagDropdown extends StatefulWidget {
  final ValueChanged<String?> onChanged;
  final FlagsCode? initialValue;

  const CountryFlagDropdown({
    required this.onChanged,
    this.initialValue = FlagsCode.US,
  });

  @override
  _CountryFlagDropdownState createState() => _CountryFlagDropdownState();
}

class _CountryFlagDropdownState extends State<CountryFlagDropdown> {
  String? _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialValue
        ?.toString()
        .split('.')[1]; // Convert FlagsCode to string
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedCountryCode,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCountryCode = newValue;
          widget.onChanged(newValue);
        });
      },
      items: <FlagsCode>[
        FlagsCode.AE,
        FlagsCode.AR,
        FlagsCode.AT,
        FlagsCode.AU,
        FlagsCode.BE,
        FlagsCode.BG,
        FlagsCode.BR,
        FlagsCode.CA,
        FlagsCode.CH,
        FlagsCode.CN,
        FlagsCode.CO,
        FlagsCode.CU,
        FlagsCode.CZ,
        FlagsCode.DE,
        FlagsCode.EG,
        FlagsCode.FR,
        FlagsCode.GB,
        FlagsCode.GR,
        FlagsCode.HK,
        FlagsCode.HU,
        FlagsCode.ID,
        FlagsCode.IE,
        FlagsCode.IL,
        FlagsCode.IN,
        FlagsCode.IT,
        FlagsCode.JP,
        FlagsCode.KR,
        FlagsCode.LT,
        FlagsCode.LV,
        FlagsCode.MA,
        FlagsCode.MX,
        FlagsCode.MY,
        FlagsCode.NG,
        FlagsCode.NL,
        FlagsCode.NO,
        FlagsCode.NZ,
        FlagsCode.PH,
        FlagsCode.PL,
        FlagsCode.PT,
        FlagsCode.RO,
        FlagsCode.RS,
        FlagsCode.RU,
        FlagsCode.SA,
        FlagsCode.SE,
        FlagsCode.SG,
        FlagsCode.SI,
        FlagsCode.SK,
        FlagsCode.TH,
        FlagsCode.TR,
        FlagsCode.TW,
        FlagsCode.US,
        FlagsCode.VE,
        FlagsCode.ZA,
      ].map<DropdownMenuItem<String>>((FlagsCode flagsCode) {
        final String countryCode = flagsCode.toString().split('.')[1];
        return DropdownMenuItem<String>(
          value: countryCode,
          child: Row(
            children: [
              Flag.fromCode(
                flagsCode,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 10),
              Text(countryCode),
            ],
          ),
        );
      }).toList(),
    );
  }
}
