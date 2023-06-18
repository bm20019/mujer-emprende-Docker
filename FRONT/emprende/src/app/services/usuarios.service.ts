import { Injectable } from "@angular/core";
import { Usuario } from "../models/usuario";
import { HttpClient } from "@angular/common/http";
import { Observable } from "rxjs";
import { PasardatosService } from "./pasardatos.service";

@Injectable({
    providedIn: 'root'
  })
  export class UsuariosService {
    baseUrl = '';
    private usuario: Usuario[] = [];
    constructor(
      private httpClient: HttpClient,
      public pasardatosservice: PasardatosService
      ) { }
  
  
    getUsuario(id: number): Observable<any> {
      this.llenarbaseUrl();
      const response = this.httpClient.get(`${this.baseUrl + "/comercio/usuarios/search"}${id}`);
      response.pipe().subscribe(
        (response: any) => {
          this.usuario = response.respuesta;
        }
      );
      return response;
    }
  
    saveUsuario(usuario: Usuario): Observable<any> {
      this.llenarbaseUrl();
      const response = this.httpClient.post(`${this.baseUrl + "/comercio/usuarios/save"}`, usuario);
      response.pipe().subscribe(
        (response: any) => {
          this.usuario = response.respuesta;
        }
      );
      return response;
    }

    llenarbaseUrl(){
      this.baseUrl = this.pasardatosservice.urlDocker;
    }
  }