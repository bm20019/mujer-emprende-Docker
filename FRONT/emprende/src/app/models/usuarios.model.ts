export class Usuarios {
    idUsuario: number;
    correo: string;
    nombres: string;
    apellidos: string;
    contacto: string;
    direccion: string;
    password: string;
    activo: number;
    rol: string;
    created: Date;
    idComercio: number

    constructor(
        idUsuario: number,
        correo: string,
        nombres: string,
        apellidos: string,
        contacto: string,
        direccion: string,
        password: string,
        activo: number,
        rol: string,
        created: Date,
        idComercio: number) {
        this.idUsuario = idUsuario;
        this.correo = correo;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.contacto = contacto;
        this.direccion = direccion;
        this.password = password;
        this.activo = activo;
        this.rol = rol;
        this.created = created;
        this.idComercio = idComercio
    }
}