import 'package:cuidapet_curso/app/models/fornecedor_busca_model.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class EstabelecimentoItemLista extends StatelessWidget {
  final FornecedorBuscaModel _fornecedor;
  const EstabelecimentoItemLista(this._fornecedor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            height: 88,
            width: ScreenUtil.screenWidthDp,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_fornecedor.nome),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.grey[500], size: 16),
                          Text(
                              '${_fornecedor.distancia.toStringAsFixed(2)}km de distancia'),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CircleAvatar(
                    maxRadius: 15,
                    backgroundColor: ThemeUtils.primaryColor,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[100],
                    width: 5,
                  ),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(
                      _fornecedor.logo,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
