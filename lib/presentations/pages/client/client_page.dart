import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:geogestao_front/presentations/pages/client/states/client_state.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/cep_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:geogestao_front/shared/shared.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'controllers/client_controller.dart';

class ClientPage extends StatelessWidget {
  final ClientController controller;
  final CepController cepController;
  final MapController mapController;

  const ClientPage({
    super.key,
    required this.controller,
    required this.cepController,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBuilder(
      controller: controller,
      build: (context, state) {
        if (state is ClientLoadingStates) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ListClientsSuccessStates) {
          if (!controller.isClientsPanelOpen) {
            return const SizedBox.shrink();
          }

          return Material(
            elevation: 6,
            color: Colors.white,
            child: Column(
              children: [
                _Header(
                  searchController: controller.searchController,
                  onAdd: () => _openAddClientDialog(context, null),
                  onClose: controller.toggleClientsPanel,
                  onSearchChanged: controller.seacrhClients,
                ),

                /// LISTA DE CLIENTES
                Expanded(
                  child: ListView.builder(
                    itemCount: state.clients.length,
                    itemBuilder: (context, index) {
                      final client = state.clients[index];
                      return GestureDetector(
                        onTap: () {
                          mapController.moveToLocation(
                            LatLng(client.latitude, client.longitude),
                            15,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Text(
                                        client.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 8,
                                          top: 4,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: client.status.color
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          client.status.decription,
                                          style: TextStyle(
                                            color: client.status.color,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit_outlined,
                                          size: 16,
                                        ),
                                        onPressed: () {
                                          _openAddClientDialog(context, client);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                          size: 16,
                                        ),
                                        onPressed: () async {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: const Text(
                                                  'Confirmar Exclusão',
                                                ),
                                                content: Text(
                                                  'Tem certeza que deseja excluir o cliente "${client.name}"? Esta ação não pode ser desfeita.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(
                                                          context,
                                                        ).pop(),
                                                    child: const Text(
                                                      'Cancelar',
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                    onPressed: () async {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                      await controller
                                                          .deleteClient(
                                                            client.id,
                                                          );
                                                    },
                                                    child: const Text(
                                                      'Excluir',
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'Responsável: ${client.ownerName ?? 'N/A'}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'CNPJ: ${client.cnpj}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                client.address,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android_outlined,
                                        size: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        client.phone ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        client.email ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // =========================
  // DIALOG ADICIONAR CLIENTE
  // =========================
  void _openAddClientDialog(BuildContext context, ClientEntity? client) {
    showDialog(
      context: context,
      builder: (_) {
        if (client != null) {
          controller.fillForEdit(client);
        } else {
          controller.clearControllers();
        }
        return AlertDialog(
          title: Text(client == null ? 'Adicionar Cliente' : 'Editar Cliente'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cepController.isLoading) const LinearProgressIndicator(),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.ownerNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome do Responsável',
                            prefixIcon: Icon(Icons.person_2_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: controller.nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nome da Empresa',
                            prefixIcon: Icon(Icons.business_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Telefone',
                            prefixIcon: Icon(Icons.phone_android_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: controller.cnpjController,
                    decoration: const InputDecoration(labelText: 'CNPJ'),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cepController.cepController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'CEP'),
                          onChanged: (value) {
                            final cep = value.replaceAll(RegExp(r'\D'), '');
                            if (cep.length == 8) {
                              cepController.getAddress(cep);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: cepController.stateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Estado',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: cepController.cityController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Cidade'),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: cepController.streetController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Rua'),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: cepController.neighborhoodController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Bairro'),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cepController.numberController,
                          decoration: const InputDecoration(
                            labelText: 'Número',
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: cepController.complementController,
                          decoration: const InputDecoration(
                            labelText: 'Complemento',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField(
                    items: controller.values.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.decription),
                      );
                    }).toList(),
                    initialValue: controller.selectedStatus,
                    onChanged: (v) => controller.selectStatus(v!),
                    decoration: const InputDecoration(
                      labelText: 'Status do Cliente',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            CustomTextButtom(
              text: 'Cancelar',
              style: const TextStyle(color: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              onPressed: () async {
                String address =
                    '${cepController.streetController.text}, '
                    '${cepController.numberController.text} - '
                    '${cepController.neighborhoodController.text}, '
                    '${cepController.cityController.text} - '
                    '${cepController.stateController.text}, '
                    'CEP: ${cepController.cepController.text}';
                final lt = await mapController.searchAutocomplete(address);
                debugPrint('Endereço completo: $address');
                debugPrint('LatLng encontrado: $lt');
                if (client != null) {
                  await controller.updateClient(
                    client.id,
                    address,
                    lt?.latitude.toString() ?? '',
                    lt?.longitude.toString() ?? '',
                  );
                } else {
                  await controller.fetch(
                    address,
                    lt?.latitude.toString() ?? '',
                    lt?.longitude.toString() ?? '',
                  );
                }
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}

// =========================
// HEADER
// =========================
class _Header extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onClose;
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  const _Header({
    required this.onAdd,
    required this.onClose,
    required this.searchController,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          SpaceWidget.extraSmall(),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: const InputDecoration(
                hintText: 'Buscar cliente...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: onClose),
        ],
      ),
    );
  }
}
