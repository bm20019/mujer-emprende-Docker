import { Injectable } from '@angular/core';
import { Product } from '../models/product';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PasardatosService } from './pasardatos.service';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  baseUrl = '';

  private products: Product[] = [];

  constructor(
    private httpClient: HttpClient,
    public pasardatosservice: PasardatosService
    ) { }

  getProduct(idCom:number): Observable<Product[]> {
    this.llenarbaseUrl();
    const response = this.httpClient.get<Product[]>(`${this.baseUrl}/comercio/catalogos/productcomercio/${idCom}`);
    response.pipe().subscribe(
      (response: any) => {
        this.products = response.respuesta;
      }
    );   
    return response;
  }

  getProductById(idProducto:number): Observable<Product[]> {
    this.llenarbaseUrl();
    const response = this.httpClient.get<Product[]>(`${this.baseUrl}/comercio/catalogos/search/${idProducto}`);
    response.pipe().subscribe(
      (response: any) => {
        this.products = response.respuesta;
      }
    );    
    return response;
  }

  saveProducto(producto: Product): Observable<any> {
    this.llenarbaseUrl();
    const response = this.httpClient.post(`${this.baseUrl}/comercio/catalogos/save`, producto);
    response.pipe().subscribe(
      (response: any) => {
        this.products = response.respuesta;
      }
    );
    return response;
  }

  updateProducto(producto: Product): Observable<any> {
    this.llenarbaseUrl();
    const response = this.httpClient.post(`${this.baseUrl}/comercio/catalogos/update/1`, producto);
    response.pipe().subscribe(
      (response: any) => {
        this.products = response.respuesta;
      }
    );
    return response;
  }

  inactivarProducto(producto: Product): Observable<any> {
    this.llenarbaseUrl();
    const response = this.httpClient.post(`${this.baseUrl}/comercio/catalogos/inactivar/${producto.idCatalogos}`, producto);
    response.pipe().subscribe(
      (response: any) => {
        this.products = response.respuesta;
      }
    );
    return response;
  }

  llenarbaseUrl(){
    this.baseUrl = this.pasardatosservice.urlDocker;
  }
}
