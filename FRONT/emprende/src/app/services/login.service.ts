import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { UsuariosContra } from '../models/usuariocontra.model';
import { PasardatosService } from './pasardatos.service';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  baseUrl = '';
  token:string="";
  private usuarioscontra: UsuariosContra[] = [];

  constructor(
    private router:Router,
    private httpClient: HttpClient,
    public pasardatosservice: PasardatosService
    ) { }
  
  login(){
    this.llenarbaseUrl();
    const response = this.httpClient.get<UsuariosContra[]>(`${this.baseUrl}/comercio/auth`);
    response.pipe().subscribe(
      (response: any) => {
        this.usuarioscontra = response.respuesta;
      }
    );    
    return response;
  }

  llenarbaseUrl(){
    this.baseUrl = this.pasardatosservice.urlDocker;
  }
}
