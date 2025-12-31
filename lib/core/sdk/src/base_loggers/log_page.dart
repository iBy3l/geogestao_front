import 'package:flutter/material.dart';

import 'app_logger.dart';
import 'log.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  String search = '';
  List<Log> filteredLogs = List.from(logs);
  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshLogs() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      filteredLogs = List.from(logs);
      _filterLogs();
    });
  }

  void _filterLogs() {
    setState(() {
      filteredLogs = logs.where((log) {
        return log.title.toLowerCase().contains(search.toLowerCase()) || log.message.toLowerCase().contains(search.toLowerCase());
      }).toList();
    });
  }

  // Função para deletar o último item da lista
  void _deleteLastLog() {
    if (filteredLogs.isNotEmpty) {
      setState(() {
        logs.clear();
        _filterLogs();
      });
    }
  }

  // Função para scrollar até o último item da lista
  void _scrollToLastLog() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Logs',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    onChanged: (v) {
                      setState(() {
                        search = v;
                        _filterLogs();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _refreshLogs,
                  icon: const Icon(Icons.replay_outlined),
                ),
                IconButton(
                  onPressed: _deleteLastLog,
                  icon: const Icon(Icons.delete),
                  tooltip: 'Deletar último',
                ),
                IconButton(
                  onPressed: _scrollToLastLog,
                  icon: const Icon(Icons.visibility),
                  tooltip: 'Mostrar último',
                ),
                const CloseButton(),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshLogs,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(Colors.red),
                      thumbVisibility: WidgetStateProperty.all(true),
                    ),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    thickness: 3,
                    scrollbarOrientation: ScrollbarOrientation.right,
                    trackVisibility: true,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: filteredLogs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        final log = filteredLogs[index];
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(15.0),
                                leading: Icon(
                                  log.icon,
                                  color: log.color,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    log.title,
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  ),
                                ),
                                subtitle: Text(
                                  log.message,
                                  style: TextStyle(color: log.color),
                                ),
                              ),
                            ),
                            if (log == filteredLogs.last)
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  TextButton(
                                    onPressed: () => throw Exception(),
                                    child: const Text("Throw Test Exception"),
                                  ),
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
