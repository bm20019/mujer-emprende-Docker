import { Component,Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { Product } from 'src/app/models/product';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.css']
})
export class EditProductComponent implements OnInit {

  constructor(
    private fb: FormBuilder,
    private productService: ProductService,
    public ref: DynamicDialogRef,
    public config: DynamicDialogConfig
  ) { 
    this.formulario = this.fb.group({
      nombre: '',
      descripcion: '',
      logo: ''
    });
  }

  formulario: FormGroup;

  ngOnInit(): void {
    this.formulario = this.fb.group({
      nombre: [this.config.data.producto.nombre],
      descripcion: [this.config.data.producto.descripcion],
      precio: [this.config.data.producto.precio],
      imagen: [this.config.data.producto.imagen],
      activo: [this.config.data.producto.activo]
    });
  }

  guardarEdicion() {
    const productoEditado: Product = {
      idCatalogos: this.config.data.producto.idCatalogos,
      nombre: this.formulario.value.nombre,
      descripcion: this.formulario.value.descripcion,
      precio: this.formulario.value.precio,
      imagen: this.formulario.value.imagen,
      activo: this.formulario.value.activo
    };
  
    this.productService.saveProducto(productoEditado).subscribe(
      (response: any) => {
        console.log(response);
        this.ref.close(true); // Cierra el diálogo y pasa true como resultado
      }
    );
  }

}
