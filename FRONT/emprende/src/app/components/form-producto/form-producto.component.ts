import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Product } from 'src/app/models/product';
import { DialogService } from 'primeng/dynamicdialog';
import { ProductService } from 'src/app/services/product.service';
import { EditProductComponent } from '../edit-product/edit-product.component';
import { MessageService } from 'primeng/api';
import { Router } from '@angular/router';
import { PasardatosService } from 'src/app/services/pasardatos.service';

@Component({
  selector: 'app-form-producto',
  templateUrl: './form-producto.component.html',
  styleUrls: ['./form-producto.component.css']
})
export class FormProductoComponent implements OnInit {

  products: any[] = [];
  formulario: FormGroup;
  respuesta: any;

  constructor(
    private fb: FormBuilder, 
    private productoService: ProductService, 
    private dialogService: DialogService,
    public messageService: MessageService,
    private router: Router,
    public pasardatosservice: PasardatosService
    ) { 
    this.formulario = this.fb.group({
      nombre: '',
      descripcion: '',
      logo: ''
    });
  }

  producto: Product = {
    idCatalogos: 0,
    nombre: '',
    descripcion: '',
    precio: 0,
    imagen: [],
    activo: 1
  };

  //Creación de formulario
  formGroup: FormGroup = this.fb.group({
    nombre: [{ value: this.producto.nombre , disabled: false }],
    descripcion: [{ value: this.producto.descripcion , disabled: false }],
    precio: [{ value: this.producto.precio , disabled: false }],
    imagen: [{ value: this.producto.imagen , disabled: false }],
    activo: [{ value: this.producto.activo , disabled: false }]  
  });

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(){
    // console.log('DATO SETEADO DESDE COMERCIOS');
    // console.log(this.pasardatosservice.idComer);
      this.productoService.getProduct(this.pasardatosservice.idComer).subscribe((data)=>{
      this.respuesta = data;
      this.products = this.respuesta.respuesta;
      // return this.products=data;
    })
  }

  refresh(){
    this.loadProducts();
  }

  submit() {  
    console.log(this.formGroup.value);
    this.productoService.saveProducto(this.formGroup.value).subscribe(
      (response: any) => {
        console.log(response);
        this.messageService.add({severity: 'success', summary: 'Éxito', detail: 'Producto guardado correctamente'});
      }
    );
  }

  desactivarProducto(producto: Product) {
    console.log(producto);
    producto.activo = 0; 
    this.productoService.updateProducto(producto, producto.idCatalogos).subscribe(
      (response: any) => {
        console.log(response);
        this.messageService.add({severity: 'success', summary: 'Éxito', detail: 'Producto desactivado correctamente'});
      }
    );
  }

  openEditarProductoDialog(producto: Product) {
    const dialogRef = this.dialogService.open(EditProductComponent, {
      //header: 'Editar Producto',
      width: '70%',
      data: {
        producto: producto
      }
    });  
    dialogRef.onClose.subscribe((result) => {
      if (result) {
        console.log('Producto editado' + result);
        this.messageService.add({severity: 'success', summary: 'Éxito', detail: 'Producto editado correctamente'});
        // Aquí puedes realizar acciones después de que se cierre el diálogo y se haya guardado la edición del producto
      }
    });
  }

  regresar(url: string) {
    this.router.navigate([url]);
  }

  inactivar() {  
    console.log(this.formGroup.value);
    this.productoService.inactivarProducto(this.formGroup.value).subscribe(
      (response: any) => {
        console.log(response);
        this.messageService.add({severity: 'success', summary: 'Éxito', detail: 'Producto inactivado correctamente'});
      }
    );
  }
}
