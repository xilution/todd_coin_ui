import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todd_coin_ui/models/domain/date_range.dart';

class SelectDateRange extends StatefulWidget {
  final void Function(DateRange dateRange) onSelect;

  const SelectDateRange({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<SelectDateRange> createState() => _SelectDateRangeState();
}

class _SelectDateRangeState extends State<SelectDateRange> {
  final _formKey = GlobalKey<FormState>();

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 00, minute: 00);
  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime = const TimeOfDay(hour: 00, minute: 00);

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _fromDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _fromDate = picked;
        _fromDateController.text = _fmtDate(_fromDate);
      });
    }
  }

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _fromTime,
    );
    if (picked != null) {
      setState(() {
        _fromTime = picked;
        _fromTimeController.text = _fmtTime(_fromTime);
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _toDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        _toDate = picked;
        _toDateController.text = _fmtDate(_toDate);
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _toTime,
    );
    if (picked != null) {
      setState(() {
        _toTime = picked;
        _toTimeController.text = _fmtTime(_toTime);
      });
    }
  }

  String _fmtDate(DateTime fromDate) => DateFormat.yMd().format(fromDate);

  String _fmtTime(TimeOfDay fromTime) {
    return formatDate(DateTime(2019, 08, 1, fromTime.hour, fromTime.minute),
        [hh, ':', nn, " ", am]).toString();
  }

  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Date Range')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'From Date',
                ),
                controller: _fromDateController,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectFromDate(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'From Time',
                ),
                controller: _fromTimeController,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectFromTime(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'To Date',
                ),
                controller: _toDateController,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectToDate(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'To Time',
                ),
                controller: _toTimeController,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectToTime(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onSelect(
                          DateRange(
                            from: DateTime(
                              _fromDate.year,
                              _fromDate.month,
                              _fromDate.day,
                              _fromTime.hour,
                              _fromTime.minute,
                            ),
                            to: DateTime(
                              _toDate.year,
                              _toDate.month,
                              _toDate.day,
                              _toTime.hour,
                              _toTime.minute,
                            ),
                          ),
                        );
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
