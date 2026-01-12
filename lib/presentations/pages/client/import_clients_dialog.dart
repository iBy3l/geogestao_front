import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geogestao_front/domain/entities/client/client_param.dart';
import 'package:geogestao_front/presentations/pages/client/controllers/import_clients_controller.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

const exampleHeaders = [
  'Nome*',
  'CNPJ/CPF*',
  'Proprietário',
  'Telefone',
  'Email',
  'Endereço',
  'Status',
];

const exampleRows = [
  [
    'Mercado Central',
    '75265933000100',
    'João Silva',
    '11991234567',
    'joao@mercado.com',
    'Rua do Bosque, 136 - Barra Funda - SP',
    'active',
  ],
  [
    'Padaria São Jorge',
    '11222333000199',
    'Maria Santos',
    '11990001122',
    'maria@padaria.com',
    'Av Pacaembu, 500 - São Paulo - SP',
    'lead',
  ],
];

class ImportClientsDialog extends StatefulWidget {
  final Function(List<ClientParam> clients) onImport;
  const ImportClientsDialog({super.key, required this.onImport});

  @override
  State<ImportClientsDialog> createState() => _ImportClientsDialogState();
}

class _ImportClientsDialogState extends State<ImportClientsDialog> {
  late final ImportClientsController controller;

  @override
  void initState() {
    super.initState();
    controller = Modular.get<ImportClientsController>();
    controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 760,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Importar Clientes do Excel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                const Text(
                  'Faça upload de um arquivo Excel (CSV) com a lista de clientes.',
                ),

                const SizedBox(height: 16),

                /// Exemplo
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Formato esperado do Excel',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                controller.downloadAssetFile(
                                  assetPath:
                                      'assets/file/modelo_importacao_clientes.xlsx',
                                  fileName: 'modelo_importacao_clientes.xlsx',
                                );
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('Baixar modelo'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        /// Tabela exemplo com scroll
                        SizedBox(
                          width: double.infinity,
                          child: Scrollbar(
                            controller: controller.horizontalScroll,
                            thumbVisibility: true,
                            interactive: true,
                            child: SingleChildScrollView(
                              controller: controller.horizontalScroll,
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              child: DataTable(
                                columnSpacing: 48,
                                columns: exampleHeaders
                                    .map((h) => DataColumn(label: Text(h)))
                                    .toList(),
                                rows: exampleRows
                                    .map(
                                      (row) => DataRow(
                                        cells: row
                                            .map(
                                              (cell) => DataCell(
                                                Text(
                                                  cell,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          '* Nome e CNPJ/CPF são obrigatórios\n'
                          'Status válidos: active, inactive, lead, cold',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Erro (se houver)
                if (controller.error != null) ...[
                  Text(
                    controller.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                /// Upload
                InkWell(
                  onTap: controller.isLoading ? null : controller.pickFile,
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: controller.clients.isEmpty
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, size: 32),
                                SizedBox(height: 8),
                                Text(
                                  'Clique para selecionar ou arraste o arquivo',
                                ),
                              ],
                            )
                          : Text(
                              '${controller.clients.length} cliente(s) encontrado(s)',
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: controller.isLoading
                          ? null
                          : () => Navigator.pop(context),
                      child: const Text('Fechar'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed:
                          controller.clients.isEmpty || controller.isLoading
                          ? null
                          : () async =>
                                await widget.onImport(controller.clients),
                      icon: controller.isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.cloud_upload),
                      label: Text(
                        'Importar ${controller.clients.length} Cliente(s)',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
