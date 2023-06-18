import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Comercio } from 'src/app/models/comercios';
import { ComerciosService } from 'src/app/services/comercios.service';
import { PasardatosService } from 'src/app/services/pasardatos.service';

@Component({
  selector: 'app-principal',
  templateUrl: './principal.component.html',
  styleUrls: ['./principal.component.css']
})
export class PrincipalComponent implements OnInit {
  comercios: Comercio[] = [];
  configUrl = 'assets/configurlbase.txt';
  configData: string = "";

  constructor(
    private comerciosService: ComerciosService,
    public pasardatosservice: PasardatosService,
    private http: HttpClient
  ) { }

  ngOnInit(): void {
    this.setearUrlDocker();
  }

  iniciarUrlDocker() {
    this.getConfig()
      .subscribe(data => {
        this.configData = data;
        this.pasardatosservice.iniciarUrl(this.configData);
        console.log("Ruta", this.configData); // Imprime el contenido del archivo de texto en la consola
      });    
  }

  getConfig() {
    return this.http.get(this.configUrl, { responseType: 'text' });
  }

  setearUrlDocker() {
    this.pasardatosservice.iniciarUrl('http://ip172-19-0-18-ci71odcsnmng00ej6v60-8080.direct.labs.play-with-docker.com:8080');
  }
}
