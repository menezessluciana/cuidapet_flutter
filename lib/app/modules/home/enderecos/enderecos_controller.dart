import 'package:cuidapet_curso/app/models/endereco_model.dart';
import 'package:cuidapet_curso/app/repository/shared_prefs_repository.dart';
import 'package:cuidapet_curso/app/services/endereco_service.dart';
import 'package:cuidapet_curso/app/shared/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'enderecos_controller.g.dart';

@Injectable()
class EnderecosController = _EnderecosControllerBase with _$EnderecosController;

abstract class _EnderecosControllerBase with Store {
  FocusNode enderecoFocusNode = FocusNode();
  final EnderecoService _enderecoService;
  TextEditingController enderecoTextController = TextEditingController();

  _EnderecosControllerBase(this._enderecoService);

  @observable
  ObservableFuture<List<EnderecoModel>> enderecosFuture;

  Future<List<Prediction>> buscarEnderecos(String endereco) {
    return _enderecoService.buscarEnderecoGooglePlaces(endereco);
  }

  @action
  Future<void> enviarDetalhe(Prediction pred) async {
    var resultado =
        await _enderecoService.buscarDetalheEnderecoGooglePlaces(pred.placeId);
    var detalhe = resultado.result;
    var enderecoModel = EnderecoModel(
      id: null,
      endereco: detalhe.formattedAddress,
      latitude: detalhe.geometry.location.lat,
      longitude: detalhe.geometry.location.lng,
      complemento: null,
    );
    var enderecoEdicao = await Modular.link
        .pushNamed('/detalhe', arguments: enderecoModel) as EnderecoModel;

    verificaEdicaoEndereco(enderecoEdicao);
  }

  @action
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
      var enderecoEdicao = await Modular.link
          .pushNamed('/detalhe', arguments: enderecoModel) as EnderecoModel;

      verificaEdicaoEndereco(enderecoEdicao);
      buscarEnderecosCadastrados();
    } catch (e) {
      Loader.hide();
      Get.snackbar('Erro', 'Não foi possivel identificar sua localização');
    }
  }

  @action
  void verificaEdicaoEndereco(EnderecoModel enderecoEdicao) {
    if (enderecoEdicao == null) {
      buscarEnderecosCadastrados();
      enderecoTextController.text = '';
    } else {
      enderecoTextController.text = enderecoEdicao.endereco;
      enderecoFocusNode.requestFocus();
    }
  }

  @action
  void buscarEnderecosCadastrados() {
    enderecosFuture =
        ObservableFuture(_enderecoService.buscarEnderecosCadastrados());
  }

  @action
  Future<void> selecionarEndereco(EnderecoModel model) async {
    var prefs = await SharedPrefsRepository.instance;
    await prefs.registrarEnderecoSelecionado(model);
    Modular.to.pop();
  }

  Future<bool> enderecoFoiSelecionado() async {
    var prefs = await SharedPrefsRepository.instance;
    return await prefs.enderecoSelecionado != null;
  }
}
