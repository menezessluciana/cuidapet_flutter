import 'package:cuidapet_curso/app/models/categoria_model.dart';
import 'package:cuidapet_curso/app/modules/home/components/home_appbar.dart';
import 'package:cuidapet_curso/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  var appBar;

  Map<String, IconData> categoriasIcons = {
    'P': Icons.pets,
    'V': Icons.local_hospital,
    'C': Icons.store_mall_directory
  };

  _HomePageState() {
    appBar = HomeAppBar(controller);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: Drawer(),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          width: ScreenUtil.screenWidthDp,
          //*para ajustar o scroll da tela e não dar scroll na appbar
          height: ScreenUtil.screenHeightDp -
              (appBar.preferredSize.height + ScreenUtil.statusBarHeight),
          child: Column(
            children: <Widget>[
              _buildEndereco(),
              _buildCategorias(),
              Expanded(child: _buildEstabelecimentos()),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildEndereco() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Estabelecimentos próximos de '),
          Observer(builder: (_) {
            return Text(
              controller.enderecoSelecionado?.endereco ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
          })
        ],
      ),
    );
  }

  Widget _buildCategorias() {
    return FutureBuilder<List<CategoriaModel>>(
        future: controller.categoriasFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao buscar categorias'),
                );
              }
              if (snapshot.hasData) {
                var cats = snapshot.data;
                return Container(
                  height: 130,
                  child: ListView.builder(
                    itemCount: cats.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var cat = cats[index];
                      return Container(
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: ThemeUtils.primaryColorLight,
                              child: Icon(categoriasIcons[cat.tipo],
                                  size: 30, color: Colors.black),
                            ),
                            SizedBox(height: 10),
                            Text(cat.nome),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Container();
              }

              break;
            default:
              return Container();
          }
        });
  }

  Widget _buildEstabelecimentos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text('Estabelecimentos'),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.view_headline),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.view_comfy),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              _buildEstabelecimentosLista(),
              _buildEstabelecimentosGrid(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEstabelecimentosLista() {
    return ListView.separated(
      itemBuilder: (context, index) {
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
                          Text('Petshop x'),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.grey[500], size: 16),
                              Text('20km de distancia'),
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
                          'https://image.freepik.com/vetores-gratis/logotipo-de-petshop-para-gatos-e-caes_9645-750.jpg',
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
      },
      separatorBuilder: (_, index) => Divider(color: Colors.transparent),
      itemCount: 3,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildEstabelecimentosGrid() {
    return GridView.builder(
      itemCount: 4,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Card(
              margin: EdgeInsets.only(top: 40, left: 10, right: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: ScreenUtil.screenWidthDp,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('PET X ',
                          style: ThemeUtils.theme.textTheme.subtitle2),
                      Text('20 km de distancia')
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            Positioned(
              top: 5,
              left: 0,
              right: 0,
              child: Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    'https://image.freepik.com/vetores-gratis/logotipo-de-petshop-para-gatos-e-caes_9645-750.jpg',
                  ),
                ),
              ),
            ),
          ],
        );
      },
      //*Criando um grid com 2 colunas
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.1),
    );
  }
}
