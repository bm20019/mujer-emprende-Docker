import { Component, OnInit } from '@angular/core';
import { Comercio } from 'src/app/models/comercios';
import { ComerciosService } from 'src/app/services/comercios.service';

@Component({
  selector: 'app-comercios-list',
  templateUrl: './comercios-list.component.html',
  styleUrls: ['./comercios-list.component.css']
})
export class ComerciosListComponent implements OnInit {
  comercios: Comercio[] = [];
  respuesta: any;
  
  constructor(
    private comercioService: ComerciosService
  ) { }

  ngOnInit(): void {
    this.loadComercios();
  }

  loadComercios() {
    this.comercioService.getComercio().subscribe((response) => {
      this.respuesta = response;
      this.comercios = this.respuesta.respuesta;
    })
  }
}
