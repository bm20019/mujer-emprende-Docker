import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Comercio } from 'src/app/models/comercios';
import { ComerciosService } from 'src/app/services/comercios.service';

@Component({
  selector: 'app-form-comercio',
  templateUrl: './form-comercio.component.html',
  styleUrls: ['./form-comercio.component.css'],
})
export class FormComercioComponent implements OnInit {

  formulario: FormGroup;

  constructor(
    private fb: FormBuilder, 
    private comercioService: ComerciosService, 
    private router: Router) { 
    this.formulario = this.fb.group({
      nombre: '',
      descripcion: '',
      logo: '',
      activo: 1,
      created: new Date()
    });
  }

  comercio: Comercio = {
    idComercio: 0,
    nombre: '',
    descripcion: '',
    logo: '',
    activo: 1,
    created: new Date()
  };

  ngOnInit(): void {
  }

  //Creación de formulario
  formGroup: FormGroup = this.fb.group({
    nombre: [{ value: this.comercio.nombre , disabled: false }],
    descripcion: [{ value: this.comercio.descripcion , disabled: false }],
    logo: [{ value: this.comercio.logo , disabled: false }]    
  });

  submit() {  
    console.log(this.formGroup.value);
    this.comercioService.saveComercio(this.formGroup.value).subscribe(
      (response: any) => {
        console.log(response);
      }
    );
  }

  regresar(url: string) {
    this.router.navigate([url]);
  }
}
