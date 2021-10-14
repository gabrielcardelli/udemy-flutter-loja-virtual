import 'package:flutter/material.dart';
import 'package:lojavirtual/models/product.dart';

class ProductListTile extends StatelessWidget {

  ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("/product",arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(aspectRatio: 1, child:
              Image.network(product.images.first)
              ),
              SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),),
                  Padding(padding: EdgeInsets.only(top: 4),
                    child: Text('A partir de', style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12
                    ),),),
                  Text('R\$ 19.99', style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Theme.of(context).primaryColor),)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
