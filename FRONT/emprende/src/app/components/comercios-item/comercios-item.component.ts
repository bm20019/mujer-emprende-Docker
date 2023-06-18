import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Comercio } from 'src/app/models/comercios';
import { PasardatosService } from 'src/app/services/pasardatos.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-comercios-item',
  templateUrl: './comercios-item.component.html',
  styleUrls: ['./comercios-item.component.css']
})
export class ComerciosItemComponent implements OnInit {
  @Input()
  comercio!: Comercio;
  comercios: Comercio[] = [];

  constructor(
    private router: Router,
    private productService: ProductService,
    public pasardatosservice: PasardatosService,
  ) { }

  ngOnInit(): void {
    
  }

  ingresoComercio(url:string): void {
    this.pasardatosservice.clearIdComercio();
    this.pasardatosservice.addIdComercio(this.comercio.idComercio);    
    this.router.navigate([url]);
  }

}
