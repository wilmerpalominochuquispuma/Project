package pe.edu.vallegrande.app.model;

public class Persona {

	private Integer id;
	private String nombre;
	private String apellido;
	private String celular;
	private String tipo_documento;
	private String numero_documento;
	private String email;
	private String tipo;
	private String estado;
	public Persona(Integer id, String nombre, String apellido, String celular, String tipo_documento,
			String numero_documento, String email, String tipo, String estado) {
		super();
		this.id = id;
		this.nombre = nombre;
		this.apellido = apellido;
		this.celular = celular;
		this.tipo_documento = tipo_documento;
		this.numero_documento = numero_documento;
		this.email = email;
		this.tipo = tipo;
		this.estado = estado;
	}
	public Persona() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Persona [id=" + id + ", nombre=" + nombre + ", apellido=" + apellido + ", celular=" + celular
				+ ", tipo_documento=" + tipo_documento + ", numero_documento=" + numero_documento + ", email=" + email
				+ ", tipo=" + tipo + ", estado=" + estado + "]";
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellido() {
		return apellido;
	}
	public void setApellido(String apellido) {
		this.apellido = apellido;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getTipo_documento() {
		return tipo_documento;
	}
	public void setTipo_documento(String tipo_documento) {
		this.tipo_documento = tipo_documento;
	}
	public String getNumero_documento() {
		return numero_documento;
	}
	public void setNumero_documento(String numero_documento) {
		this.numero_documento = numero_documento;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}

}
