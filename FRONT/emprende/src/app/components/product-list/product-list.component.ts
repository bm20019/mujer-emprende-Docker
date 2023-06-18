import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product';
import { PasardatosService } from 'src/app/services/pasardatos.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[] = [];
  respuesta: any;

  constructor(
    private productService: ProductService,
    private pasardatosservice: PasardatosService,
  ) { }

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(){
    // console.log('DATO SETEADO DESDE COMERCIOS');
    console.log(this.pasardatosservice.idComer);
      this.productService.getProduct(this.pasardatosservice.idComer).subscribe((data)=>{
      this.respuesta = data;
      this.products = this.respuesta.respuesta;
      // return this.products=data;
    })
  }
}
