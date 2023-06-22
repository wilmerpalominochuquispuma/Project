package pe.edu.vallegrande.app.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import pe.edu.vallegrande.app.model.Persona;
import pe.edu.vallegrande.service.CrudPersonaService;

@WebServlet({ "/PersonaBuscar", "/PersonaBuscar2", "/PersonaProcesar", "/bbbb" })
public class PersonaController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CrudPersonaService service = new CrudPersonaService();

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
		switch (path) {
		case "/PersonaBuscar":
			buscar(request, response);
			break;
		case "/PersonaBuscar2":
			buscar2(request, response);
			break;
		case "/PersonaProcesar":
			procesar(request, response);
			break;
		}
	}

	private void procesar(HttpServletRequest request, HttpServletResponse response) {
		// Datos
		String accion = request.getParameter("accion");
		Persona bean = new Persona();
		bean.setId(Integer.parseInt(request.getParameter("id")));
		bean.setNombre(request.getParameter("nombre"));
		bean.setApellido(request.getParameter("apellido"));
		bean.setCelular(request.getParameter("celular"));
		bean.setTipo_documento(request.getParameter("tipo_documento"));
		bean.setNumero_documento(request.getParameter("numero_documento"));
		bean.setEmail(request.getParameter("email"));
		bean.setTipo(request.getParameter("tipo"));
		bean.setEstado(request.getParameter("estado"));
		// Proceso
		try {
			switch (accion) {
			case ControllerUtil.CRUD_NUEVO: 
				service.insert(bean);
				break;
			case ControllerUtil.CRUD_EDITAR: 
				service.update(bean);
				break;
			case ControllerUtil.CRUD_ELIMINAR: 
				service.delete(bean.getId().toString());
				break;
			default:
				throw new IllegalArgumentException("Unexpected value: " + accion);
			}
			ControllerUtil.responseJson(response, "Proceso ok.");
		} catch (Exception e) {
			ControllerUtil.responseJson(response, e.getMessage());
		}
	}

	private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Datos
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		// Proceso
		Persona bean = new Persona();
		bean.setNombre(nombre);
		bean.setApellido(apellido);
		List<Persona> lista = service.get(bean);
		// Reporte
		request.setAttribute("listado", lista);
		RequestDispatcher rd = request.getRequestDispatcher("persona.jsp");
		rd.forward(request, response);
	}

	private void buscar2(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Datos
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		// Proceso
		Persona bean = new Persona();
		bean.setNombre(nombre);
		bean.setApellido(apellido);
		List<Persona> lista = service.get(bean);
		// Preparando el JSON
		Gson gson = new Gson();
		String data = gson.toJson(lista);
		// Reporte
		ControllerUtil.responseJson(response,data);
	}

}
