import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Product } from 'src/app/models/product';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-pagempren',
  templateUrl: './pagempren.component.html',
  styleUrls: ['./pagempren.component.css']
})
export class PagemprenComponent implements OnInit {
  products: Product[] = [];
  constructor(
    private productService: ProductService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }
  
  login(url:string) {
    this.router.navigate([url]);
  }
}
