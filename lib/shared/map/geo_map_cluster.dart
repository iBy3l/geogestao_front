import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geogestao_front/shared/map/geo_point.dart';
import 'package:geogestao_front/shared/map/map_global_tooltip.dart';
import 'package:geogestao_front/shared/map/map_tooltip_controller.dart';
import 'package:latlong2/latlong.dart';

class GeoMapCluster extends StatefulWidget {
  final List<GeoPoint> points;
  final double height;

  const GeoMapCluster({super.key, required this.points, this.height = 500});

  @override
  State<GeoMapCluster> createState() => _GeoMapClusterState();
}

class _GeoMapClusterState extends State<GeoMapCluster> {
  final tooltipController = MapTooltipController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: widget.points.isNotEmpty ? widget.points.first.position : const LatLng(-23.5505, -46.6333),
          initialZoom: 11,
          interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
            additionalOptions: const {'accessToken': String.fromEnvironment('MAPBOX_ACCESS_TOKEN')},
          ),
          MapGlobalTooltip(controller: tooltipController),

          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 45,
              size: const Size(46, 46),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(50),
              markers: widget.points.map((p) => buildMarker(p, ClientMapData(id: p.id, name: p.id, status: p.status.toString(), address: ''), tooltipController)).toList(),

              builder: (context, markers) {
                final info = _clusterStatusInfo(markers);
                final clusterColor = info.dominant.color;

                return Container(
                  decoration: BoxDecoration(
                    color: clusterColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      markers.length.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

  Marker buildMarker(GeoPoint p, ClientMapData client, MapTooltipController tooltip) {
    return Marker(
      point: p.position,
      width: 32,
      height: 32,
      child: Listener(
        onPointerHover: (event) {
          tooltip.show(event.position, client);
        },
        onPointerCancel: (_) {
          tooltip.hide();
        },
        child: Icon(Icons.location_on, color: p.color, size: 32),
      ),
    );
  }

  /// Regra: prioridade (atrasado > emVisita > ativo > inativo)
  /// Se tiver 1 atrasado dentro do cluster, o cluster fica vermelho.
  _ClusterInfo _clusterStatusInfo(List<Marker> markers) {
    // Aqui a gente “recupera” o status do marker usando a child.
    // Melhor prática: guardar isso num map id->status e consultar (mais robusto).
    // Para ficar simples, vamos usar um Map<Marker, ClientStatus> externamente?
    // Então vou te dar a versão robusta logo abaixo.
    throw UnimplementedError();
  }
}

class _ClusterInfo {
  final ClientStatus dominant;
  final Map<ClientStatus, int> counts;

  _ClusterInfo(this.dominant, this.counts);
}
