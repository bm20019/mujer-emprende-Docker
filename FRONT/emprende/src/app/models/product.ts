export class Product {
    idCatalogos: number;
    nombre: string;
    descripcion: string;
    precio: number;
    imagen: string[];
    activo: number;

    constructor(idCatalogos: number, nombre: string, descripcion: string, precio: number, imagen: string[], activo: number) {
        this.idCatalogos = idCatalogos;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.imagen = imagen;
        this.activo = activo;
    }
}
