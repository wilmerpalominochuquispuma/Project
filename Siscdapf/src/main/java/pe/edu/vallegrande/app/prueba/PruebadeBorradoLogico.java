package pe.edu.vallegrande.app.prueba;

import pe.edu.vallegrande.app.model.Persona;
import pe.edu.vallegrande.service.CrudPersonaService;

public class PruebadeBorradoLogico {
	public static void main(String[] args) {
			try {
				// Datos
				String id = "1";
				// Proceso
				CrudPersonaService empleadoService = new CrudPersonaService();
				empleadoService.delete(id);
				System.out.println("Registro eliminado.");
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
		}

	}

