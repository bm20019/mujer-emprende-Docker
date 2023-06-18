import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
})
export class AppComponent {
  title = 'Mujer Emprende';
  simbolo: string = "";
  moneda: string = "";
  
  constructor() {
    this.variables_localstorage();
    this.recupera_localStorage();
  }

  variables_localstorage() {
    let simbolo: string = "$"; //€, $
    let moneda: string = "USD"; //EUR, USD
    localStorage.setItem("simbolo", simbolo);
    localStorage.setItem("moneda", moneda);
  }

  recupera_localStorage() {
    this.simbolo = JSON.stringify(localStorage.getItem("simbolo"));
    this.moneda = JSON.stringify(localStorage.getItem("moneda"));
  }
  
}
