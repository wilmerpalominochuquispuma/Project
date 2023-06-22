package pe.edu.vallegrande.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import pe.edu.vallegrande.app.db.AccesoDB;
import pe.edu.vallegrande.app.model.Persona;
import pe.edu.vallegrande.app.service.spec.CrudServiceSpec;
import pe.edu.vallegrande.app.service.spec.RowMapper;

public class CrudPersonaService implements CrudServiceSpec<Persona>, RowMapper<Persona> {

	// Definiendo cosas
	private final String SQL_SELECT_BASE = "SELECT idpersona id,  nombre,apellido, celular, tipo_documento,numero_documento,email,tipo,estado   FROM persona ";
	private final String SQL_INSERT = "INSERT INTO persona(idpersona,nombre,apellido,celular,tipo_documento,numero_documento,email,tipo,estado) VALUES(?,?,?,?,?,?,?,?,?)";
	private final String SQL_UPDATE = "UPDATE persona SET nombre=?,apellido=?,celular=?,tipo_documento=?,numero_documento=?, email=?, tipo=?, estado=? WHERE idpersona=?";
	private final String SQL_DELETE = "UPDATE persona SET estado='i' WHERE idpersona=?";

	@Override
	public List<Persona> getAll() {
		// Variables
		Connection cn = null;
		List<Persona> lista = new ArrayList<>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Persona bean;
		// Proceso
		try {
			cn = AccesoDB.getConnection();
			pstm = cn.prepareStatement(SQL_SELECT_BASE);
			rs = pstm.executeQuery();
			while (rs.next()) {
				bean = mapRow(rs);
				lista.add(bean);
			}
			rs.close();
			pstm.close();
		} catch (SQLException e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				cn.close();
			} catch (Exception e2) {
			}
		}
		return lista;
	}

	@Override
	public Persona getForId(String id) {
		// Variables
		Connection cn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Persona bean = null;
		String sql;
		// Proceso
		try {
			cn = AccesoDB.getConnection();
			sql = SQL_SELECT_BASE + " WHERE idpersona=?";
			pstm = cn.prepareStatement(sql);
			pstm.setInt(1, Integer.parseInt(id));
			rs = pstm.executeQuery();
			if (rs.next()) {
				bean = mapRow(rs);
			}
			rs.close();
			pstm.close();
		} catch (SQLException e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				cn.close();
			} catch (Exception e2) {
			}
		}
		return bean;
	}

	/**
	 * Realiza la busqueda por apellido y nombre.
	 */
	@Override
	public List<Persona> get(Persona bean) {
		// Variables
		Connection cn = null;
		List<Persona> lista = new ArrayList<>();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		Persona item;
		String sql;
		String nombre;
		String apellido;
		// Preparar los datos
		nombre = "%" + UtilService.setStringVacio(bean.getNombre()) + "%";
		apellido = "%" + UtilService.setStringVacio(bean.getApellido()) + "%";
		// Proceso
		try {
			// Conexion
			cn = AccesoDB.getConnection();
			// La consulta
			sql = SQL_SELECT_BASE + " WHERE apellido LIKE ? AND nombre LIKE ?";
			pstm = cn.prepareStatement(sql);
			pstm.setString(1, nombre);
			pstm.setString(2, apellido);
			rs = pstm.executeQuery();
			while (rs.next()) {
				item = mapRow(rs);
				lista.add(item);
			}
			rs.close();
			pstm.close();
		} catch (SQLException e) {
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				cn.close();
			} catch (Exception e2) {
			}
		}
		return lista;
	}

	@Override
	public void insert(Persona bean) {
		// Variables
		Connection cn = null;
		String sql = null;
		PreparedStatement pstm = null;
		ResultSet rs;
		Integer id = 0;
		// Proceso
		try {
			// Iniciar la Tx
			cn = AccesoDB.getConnection();
			cn.setAutoCommit(false);
			// Traer contador
			sql = "SELECT valor FROM control WHERE parametro='Persona'";
			pstm = cn.prepareStatement(sql);
			rs = pstm.executeQuery();
			if (!rs.next()) {
				rs.close();
				pstm.close();
				throw new SQLException("Contador de persona no existe.");
			}
			id = Integer.parseInt(rs.getString("valor"));
			rs.close();
			pstm.close();
			// Actualizar contador
			id++;
			sql = "UPDATE control SET valor = ? WHERE parametro='Persona'";
			pstm = cn.prepareStatement(sql);
			pstm.setString(1, id + "");
			pstm.executeUpdate();
			pstm.close();
			// Insertar nuevo persona
			pstm = cn.prepareStatement(SQL_INSERT);
			pstm.setString(1, id + "");
			pstm.setString(2, bean.getNombre());
			pstm.setString(3, bean.getApellido());
			pstm.setString(4, bean.getCelular());
			pstm.setString(5, bean.getTipo_documento());
			pstm.setString(6, bean.getNumero_documento());
			pstm.setString(7, bean.getEmail());
			pstm.setString(8, bean.getTipo());
			pstm.setString(9, bean.getEstado());
			pstm.executeUpdate();
			pstm.close();
			// Fin de Tx
			bean.setId(id);
			cn.commit();
		} catch (SQLException e) {
			try {
				cn.rollback();
				cn.close();
			} catch (Exception e2) {
			}
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				cn.close();
			} catch (Exception e2) {
			}
		}
	}

	@Override
	public void update(Persona bean) {
		// Variables
		Connection cn = null;
		PreparedStatement pstm = null;
		int filas;
		// Proceso
		try {
			// Iniciar la Tx
			cn = AccesoDB.getConnection();
			cn.setAutoCommit(false);
			// Actualizar el registro
			pstm = cn.prepareStatement(SQL_UPDATE);
			pstm.setString(1, bean.getNombre());
			pstm.setString(2, bean.getApellido());
			pstm.setString(3, bean.getCelular());
			pstm.setString(4, bean.getTipo_documento());
			pstm.setString(5, bean.getNumero_documento());
			pstm.setString(6, bean.getEmail());
			pstm.setString(7, bean.getTipo());
			pstm.setString(8, bean.getEstado());
			pstm.setInt(9, bean.getId());
			filas = pstm.executeUpdate();
			pstm.close();
			if (filas != 1) {
				throw new SQLException("Error, verifique sus datos e intentelo nuevamente.");
			}
			// Fin de Tx
			cn.commit();
		} catch (SQLException e) {
			try {
				cn.rollback();
				cn.close();
			} catch (Exception e2) {
			}
			throw new RuntimeException(e.getMessage());
		} finally {
			try {
				cn.close();
			} catch (Exception e2) {
			}
		}

	}

	@Override
    public void delete(String id) {
        Connection cn = null;
        PreparedStatement pstm = null;
        int filas = 0;
        try {
            // Inicio de Tx
            cn = AccesoDB.getConnection();
            cn.setAutoCommit(false);
            pstm = cn.prepareStatement(SQL_DELETE);
            pstm.setInt(1, Integer.parseInt(id));
            filas = pstm.executeUpdate();
            pstm.close();
            if (filas != 1) {
                throw new SQLException("No se pudo eliminar el usuario.");
            }
            cn.commit();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try {
                cn.close();
            } catch (Exception e2) {
            }
        }
    }
	@Override
	public Persona mapRow(ResultSet rs) throws SQLException {
		Persona bean = new Persona();
		// Columnas: id, apellido, nombre, direccion, email
		bean.setId(rs.getInt("id"));
		bean.setNombre(rs.getString("nombre"));
		bean.setApellido(rs.getString("apellido"));
		bean.setCelular(rs.getString("celular"));
		bean.setTipo_documento(rs.getString("tipo_documento"));
		bean.setNumero_documento(rs.getString("numero_documento"));
		bean.setEmail(rs.getString("email"));
		bean.setTipo(rs.getString("tipo"));
		bean.setEstado(rs.getString("estado"));
		return bean;
	}

}

