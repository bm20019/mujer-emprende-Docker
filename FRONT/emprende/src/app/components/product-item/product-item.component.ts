import { Component, Input, OnInit } from '@angular/core';
import { Product } from 'src/app/models/product';
import { MessageService } from 'src/app/services/message.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-item',
  templateUrl: './product-item.component.html',
  styleUrls: ['./product-item.component.css']
})
export class ProductItemComponent implements OnInit {

  simb = localStorage.getItem("simbolo");
  @Input()
  product!: Product;
  products: Product[] = [];

  constructor(
    private messageService: MessageService
  ) { }

  ngOnInit(): void {
  }

  addToCart(): void {
    this.messageService.sendMessage(this.product);
  }

}
