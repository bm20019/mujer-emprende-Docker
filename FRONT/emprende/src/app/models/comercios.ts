export class Comercio {
    idComercio: number;
    nombre: string;
    descripcion: string;
    logo: string;
    activo: number;
    created:Date;
    

    constructor(idComercio: number, nombre: string, descripcion: string, logo: string, activo: number, created:Date) {
        this.idComercio = idComercio;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.logo = logo;
        this.activo = activo;
        this.created = created;
    }
}
