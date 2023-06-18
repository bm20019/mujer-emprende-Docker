import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Comercio } from '../models/comercios';
import { PasardatosService } from './pasardatos.service';

@Injectable({
  providedIn: 'root'
})
export class ComerciosService {
  baseUrl = '';
  private comercio: Comercio[] = [];
  constructor(
    private httpClient: HttpClient,
    public pasardatosservice: PasardatosService
    ) { }


  getComercio(): Observable<any> {
    this.llenarbaseUrl();
    const response = this.httpClient.get(`${this.baseUrl + "/comercio/comercio/search"}`);
    response.pipe().subscribe(
      (response: any) => {
        this.comercio = response.respuesta;
      }
    );
    return response;
  }

  saveComercio(comercio: Comercio): Observable<any> {
    this.llenarbaseUrl();
    const response = this.httpClient.post(`${this.baseUrl}/comercio/comercio/save`, comercio);
    response.pipe().subscribe(
      (response: any) => {
        this.comercio = response.respuesta;
        console.log(this.comercio);
      }
    );
    return response;
  }

  llenarbaseUrl(){
    console.log("Comercio ",this.pasardatosservice.urlDocker)
    this.baseUrl = this.pasardatosservice.urlDocker;
  }
}
