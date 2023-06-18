import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, NgForm, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { UsuariosContra } from 'src/app/models/usuariocontra.model';
import { LoginService } from 'src/app/services/login.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  url: string = "admon";
  respuesta: any;
  usuarioscontra: UsuariosContra[] = [];
  formulario !: FormGroup;

  constructor(
    private router: Router,
    private loginservice: LoginService,
    private form: FormBuilder
  ) { }

  ngOnInit(): void {
    this.formulario = this.form.group({
      email: ['', Validators.required],
      password: ['', Validators.required]
    })
  }

  login() {
    this.usuarioscontra=[];
    const email = this.formulario.value.email;
    const password = this.formulario.value.password;
    console.log(email);
    console.log(password);
    this.usuarioscontra.push(email);
    this.usuarioscontra.push(password);
    console.log(this.usuarioscontra);
    this.loginservice.login().subscribe((data) => {
      this.respuesta = data;
      this.usuarioscontra = this.respuesta.respuesta;
      this.router.navigate([this.url]);
    })
    this.router.navigate([this.url]);
  }

  regresar(url: string) {
    this.router.navigate([this.url]);
  }
}
