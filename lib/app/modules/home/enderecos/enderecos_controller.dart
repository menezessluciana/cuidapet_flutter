import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:cuidapet_curso/app/services/endereco_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'enderecos_controller.g.dart';

@Injectable()
class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  final EnderecoService _enderecoService;

  _EnderecosControllerBase(this._enderecoService);

  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecoGooglePlaces(endereco);
  }

  Future<void> minhaLocalizacao() async {
    try {
      Loader.show();
      var geolocator = Geolocator();
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var placemark = await geolocator.placemarkFromPosition(position);
      var place = placemark[0];
      var endereco = '${place.thoroughfare} ${place.subThoroughfare}';
      var enderecoModel = EnderecoModel(
        id: null,
        endereco: endereco,
        latitude: position.latitude,
        longitude: position.longitude,
        complemento: null,
      );
      Loader.hide();
      await Modular.link.pushNamed('/detalhe', arguments: enderecoModel);
      buscarEnderecosCadastrados();
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Não foi possivel identificar sua localização');
    }
  }

//*Utiizar observablefuture quando um campo será atualizado baseando em chamado de api, atualização dinamica.
  void buscarEnderecosCadastrados() {
    enderecosFuture =
        ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }
}
