import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class PasardatosService {
  messages: string[] = [];
  idComer: number = 0;
  urlDocker: string = "";

  add(message: string) {
    this.messages.push(message);
  }

  addIdComercio(id: number) {
    this.idComer = id;
  }

  clear() {
    this.messages = [];
  }

  clearIdComercio() {
    this.idComer = 0;
  }
  constructor() { }

  iniciarUrl(urlArch: string) {
    this.urlDocker = urlArch;
  }
}
