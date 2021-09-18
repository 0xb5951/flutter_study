import 'package:app/blocs/search_bloc.dart';
import 'package:app/data/model/repository_item.dart';
import 'package:app/ui/component/search_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  const PostView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = Provider.of<SearchBloc>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SearchForm(),
            // ここでちゃんと型を定義してやらないとsnapshotでゲッターとか使えない
            StreamBuilder<List<dynamic>>(
                initialData: [],
                // resultがStream対象
                stream: searchBloc.result,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, int index) {
                              RepositoryItem item = snapshot.data![index];
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black38),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(item.fullName),
                                  subtitle: Text('Star: ' +
                                      item.stargazersCount.toString()),
                                  onTap: () {},
                                ),
                              );
                            }));
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}
