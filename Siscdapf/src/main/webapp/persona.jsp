<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<title>Siscdapf</title>
<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

</head>
<body>

	<jsp:include page="menu.jsp"></jsp:include>

	<div class="container">

		<h1>PERSONA</h1>

		<!-- Card de datos de entrada -->
		<div class="card">

			<div class="card-header">Criterios de busqueda</div>
			<div class="card-body">
				<form method="post" action="#">
					<div class="mb-3 row">
						<div class="col-sm-4">
							<input type="text" class="form-control" id="nombre" name="nombre"
								placeholder="Ingrese nombre">
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="apellido"
								name="apellido" placeholder="Ingrese apellido">
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-dark mb-3" id="btnBuscar"
								name="btnBuscar">Buscar</button>
						</div>
						<div class="col-sm-2">
							<button type="button" class="btn btn-dark mb-3" id="btnNuevo"
								name="btnNuevo">Nuevo</button>

						</div>
						
                           <div class="dropdown">
								<button onclick="exportToExcel()">Exportar a excel</button>
							</div>
					<br>
						<div class="dropdown">
							<button class="btn btn-success dropdown-toggle" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false">Filtro por:</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#">Activos</a></li>
								<li><a class="dropdown-item" href="#">Inactivos</a></li>
								<li><a class="dropdown-item" href="#">Todos</a></li>
							</ul>
						</div>



					</div>
				</form>
			</div>
		</div>
		<br />

		<!-- Card de resultados -->
		<div class="card" id="divResultado">
			<div class="card-header">Resultado</div>
			<div class="card-body">
				<table class="table table-bordered border-dark">
					<thead>
						<tr class="table-success">
							<th>ID</th>
							<th>NOMBRE</th>
							<th>APELLIDO</th>
							<th>CELULAR</th>
							<th>TIPO_DOC</th>
							<th>NUMDOC</th>
							<th>EMAIL</th>
							<th>TIPO</th>
							<th>ESTADO</th>
							<th>ACCIONES</th>
						</tr>
					</thead>
					<tbody id="detalleTabla">
					</tbody>
				</table>
			</div>
		</div>

		<!-- Formulario de edición de registro -->
		<div class="card" id="divRegistro" style="display: none;">
			<div class="card-header" id="tituloRegistro">{accion} PERSONA</div>
			<div class="card-body">
				<form>
					<input type="hidden" id="accion" name="accion">
					<div class="row mb-3">
						<label for="frmId" class="col-sm-2 col-form-label">ID</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="frmId"
								disabled="disabled" value="0">
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmNombre" class="col-sm-2 col-form-label">Nombre</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="frmNombre">
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmApellido" class="col-sm-2 col-form-label">Apellido</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="frmApellido"
								placeholder="" required>
							<div class="valid-feedback">¡Ok valido!</div>
							<div class="invalid-feedback">¡Complete el campo!</div>
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmCelular" class="col-sm-2 col-form-label">Celular</label>
						<div class="col-sm-10">

							<input type="text" class="form-control" maxlength="	/^\d{9}$/"
								id="frmCelular">

						</div>
					</div>
					<div class="row mb-3">
						<label for="frmTipo_documento" class="col-sm-2 col-form-label">Tipo_documento</label>
						<div class="col-sm-10">
							<select class="form-select" id="frmTipo_documento">
							<option value="DNI">DNI</option>
							<option value="CNE">CNE</option>
							</select>
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmNumero_documento" class="col-sm-2 col-form-label">Numero_documento</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" maxlength="9"
								id="frmNumero_documento">
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmEmail" class="col-sm-2 col-form-label">Email</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="frmEmail">
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmTipo" class="col-sm-2 col-form-label">Tipo</label>
						<div class="col-sm-10">
							<select class="form-select" id="frmTipo">
							<option value="apoderado">apoderado</option>
							<option value="director">director</option>
							<option value="estudiante">estudiante</option>
							</select>
						</div>
					</div>
					<div class="row mb-3">
						<label for="frmActive" class="col-sm-2 col-form-label">Estado</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" maxlength="1"
							disabled="disabled" value="a" 	id="frmEstado">
						</div>
					</div>
					<button type="button" class="btn btn-success" id="btnProcesar"
						class="btn-close btn-close-white" aria-label="Close">Procesar</button>
					<input type="reset" class="btn btn-info" value="Limpiar">

				</form>
			</div>
		</div>
	</div>

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<script>
		// Constantes del CRUD
		const ACCION_NUEVO = "NUEVO";
		const ACCION_EDITAR = "EDITAR";
		const ACCION_ELIMINAR = "ELIMINAR";

		// Arreglo de registros
		let arreglo = [];

		// Acceder a los controles
		let btnBuscar = document.getElementById("btnBuscar");
		let btnNuevo = document.getElementById("btnNuevo");
		let btnProcesar = document.getElementById("btnProcesar");

		// Programar los controles
		btnBuscar.addEventListener("click", fnBtnBuscar);
		btnNuevo.addEventListener("click", fnBtnNuevo);
		btnProcesar.addEventListener("click", fnBtnProcesar);

		// Funcion fnEditar
		function fnEditar(id) {
			// Preparando el formulario
			document.getElementById("tituloRegistro").innerHTML = ACCION_EDITAR
					+ " REGISTRO";
			document.getElementById("accion").value = ACCION_EDITAR;
			fnCargarForm(id);

			// Mostrar formulario
			document.getElementById("divResultado").style.display = "none";
			document.getElementById("divRegistro").style.display = "block";
		}

		// Funcion fnEliminar

		function fnEliminar(id) {
			// Preparando el formulario
			document.getElementById("tituloRegistro").innerHTML = ACCION_ELIMINAR
					+ " REGISTRO";
			document.getElementById("accion").value = ACCION_ELIMINAR;
			fnCargarForm(id);
			// Mostrar formulario
			document.getElementById("divResultado").style.display = "none";
			document.getElementById("divRegistro").style.display = "block";
		}

		// Funcion fnBtnProcesar
		function fnBtnProcesar() {
			// Preparar los datos
			let datos = "accion=" + document.getElementById("accion").value;
			datos += "&id=" + document.getElementById("frmId").value;
			datos += "&nombre=" + document.getElementById("frmNombre").value;
			datos += "&apellido="
					+ document.getElementById("frmApellido").value;
			datos += "&celular=" + document.getElementById("frmCelular").value;
			datos += "&tipo_documento="
					+ document.getElementById("frmTipo_documento").value;
			datos += "&numero_documento="
					+ document.getElementById("frmNumero_documento").value;
			datos += "&email=" + document.getElementById("frmEmail").value;
			datos += "&tipo=" + document.getElementById("frmTipo").value;
			datos += "&estado=" + document.getElementById("frmEstado").value;

			// El envio con AJAX
			let xhr = new XMLHttpRequest();
			xhr.open("POST", "PersonaProcesar", true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4 && xhr.status === 200) {
					// La solicitud se completó correctamente
					console.log(xhr.responseText);
					alert(xhr.responseText);
				}
			};
			xhr.send(datos);
		}

		// Funcion fnBtnNuevo
		function fnBtnNuevo() {
			// Preparando el formulario
			document.getElementById("tituloRegistro").innerHTML = ACCION_NUEVO
					+ " REGISTRO";
			document.getElementById("accion").value = ACCION_NUEVO;
			// Mostrar formulario
			document.getElementById("divResultado").style.display = "none";
			document.getElementById("divRegistro").style.display = "block";
		}

		// Función fnBtnBuscar
		function fnBtnBuscar() {
			// Datos
			let apellido = document.getElementById("nombre").value;
			let nombre = document.getElementById("apellido").value;
			// Preparar la URL
			let url = "PersonaBuscar2?nombre=" + nombre + "&apellido="
					+ apellido;
			// La llama AJAX
			let xhttp = new XMLHttpRequest();
			xhttp.open("GET", url, true);
			xhttp.onreadystatechange = function() {
				if (this.readyState == 4 && this.status == 200) {
					let respuesta = xhttp.responseText;
					arreglo = JSON.parse(respuesta);
					let detalleTabla = "";
					arreglo.forEach(function(item) {
						detalleTabla += "<tr>";
						detalleTabla += "<td>" + item.id + "</td>";
						detalleTabla += "<td>" + item.nombre + "</td>";
						detalleTabla += "<td>" + item.apellido + "</td>";
						detalleTabla += "<td>" + item.celular + "</td>";
						detalleTabla += "<td>" + item.tipo_documento + "</td>";
						detalleTabla += "<td>" + item.numero_documento
								+ "</td>";
						detalleTabla += "<td>" + item.email + "</td>";
						detalleTabla += "<td>" + item.tipo + "</td>";
						detalleTabla += "<td>" + item.estado + "</td>";
						detalleTabla += "<td>";
						detalleTabla += "<a href='javascript:void(0);' onclick='fnEditar(" + item.id + ");'>Editar</a> ";
						detalleTabla += "<a href='javascript:void(0);' onclick='fnEliminar(" + item.id + ");'>Eliminar</a>";
						detalleTabla += "</td>";
						detalleTabla += "</tr>";
					});
					document.getElementById("detalleTabla").innerHTML = detalleTabla;
					// Mostrar formulario
					document.getElementById("divResultado").style.display = "block";
					document.getElementById("divRegistro").style.display = "none";
				}
			};
			xhttp.send();
		}

		function fnCargarForm(id) {
			arreglo
					.forEach(function(item) {
						if (item.id == id) {
							/*
							document.getElementById("frmId").value = item.id;
							document.getElementById("frmNombre").value = item.nombre;
							document.getElementById("frmApellido").value = item.apellido;
							document.getElementById("frmCelular").value = item.celular;
							document.getElementById("frmTipo_documento").value = item.tipo_documento;
							document.getElementById("frmNumero_documento").value = item.numero_documento;
							document.getElementById("frmEmail").value = item.email;
							document.getElementById("frmTipo").value = item.tipo;
							document.getElementById("frmEstado").value = item.estado;
							*/
							frmId.value = item.id;
							frmNombre.value = item.nombre;
							frmApellido.value = item.apellido;
		 					frmCelular.value = item.celular;
							frmTipo_documento.value = item.tipo_documento;
							frmNumero_documento.value = item.numero_documento;
							frmEmail.value = item.email;
							frmTipo.value = item.tipo;
							frmEstado.value = item.estado;
							
							return true;

							
						}
					});
		}
		function fnEstadoFormulario(estado){
			frmNombre.disabled = (estado==ACCION_ELIMINAR)
			frmApellido.disabled = (estado==ACCION_ELIMINAR)
			frmCelular.disabled = (estado==ACCION_ELIMINAR)
			frmTipo_documento.disabled = (estado==ACCION_ELIMINAR)
			frmNumero_documento.disabled = (estado==ACCION_ELIMINAR)
			frmEmail.disabled = (estado==ACCION_ELIMINAR)
			frmTipo.disabled = (estado==ACCION_ELIMINAR)
			frmEstado.disabled = (estado==ACCION_ELIMINAR)
			if(estado==ACCION_NUEVO){
				frmId.value = "0";
				frmNombre.value = "";
				frmApellido.value = "";
				frmCelular.value = "";
				frmTipo_Documento.value = "";
				frmNumero_Documento.value = "";
				frmEmail.value = "";
				frmTipo.value = "";
				frmEstado.value = "";
			}
		}
		
		function fnValidar(){
			
			return true;
		}
		
		function exportToExcel() {
            // Obtener los datos de la tabla
            let rows = document.querySelectorAll("#detalleTabla tr");
            // Crear una matriz de datos con las columnas deseadas
            let data = [];
            // Agregar los encabezados de columna
            data.push(["ID", "NOMBRE", "APELLIDO","CELULAR", "TIPO DOCUMENTO", "NUMDOC", "EMAIL", "TIPO","ESTADO"]);
            rows.forEach(function(row) {
              let rowData = [];
              let columns = row.querySelectorAll("td:nth-child(1), td:nth-child(2), td:nth-child(3), td:nth-child(4), td:nth-child(5), td:nth-child(6), td:nth-child(7),td:nth-child(8),td:nth-child(9)"); // Incluir solo las columnas deseadas
              columns.forEach(function(column) {
                rowData.push(column.innerText);
              });
              data.push(rowData);
            });
            // Crear una hoja de cálculo de Excel
            let worksheet = XLSX.utils.aoa_to_sheet(data);
            // Crear un libro de Excel y agregar la hoja de cálculo
            let workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, "Apoderados");
            // Guardar el archivo de Excel
            XLSX.writeFile(workbook, "reporteApoderados.xlsx");
      }
		// Ejemplo de JavaScript inicial para deshabilitar el envío de formularios si hay campos no válidos
		(function () {
		  'use strict'

		  // Obtener todos los formularios a los que queremos aplicar estilos de validación de Bootstrap personalizados
		  var forms = document.querySelectorAll('.needs-validation')

		  // Bucle sobre ellos y evitar el envío
		  Array.prototype.slice.call(forms)
		    .forEach(function (form) {
		      form.addEventListener('submit', function (event) {
		        if (!form.checkValidity()) {
		          event.preventDefault()
		          event.stopPropagation()
		        }

		        form.classList.add('was-validated')
		      }, false)
		    })
		})()
		
	</script>
	

</body>
</html>