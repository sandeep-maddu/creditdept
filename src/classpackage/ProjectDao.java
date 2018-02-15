package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProjectDao {

	private Connection conn=null;
	
	public ProjectDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Project> get_all_projects() throws Exception {
	List<Project> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from projects order by aid,project_id");
		while (rs.next()) {
			Project tempProject = convertRowToProject(rs);
			list.add(tempProject);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Project get_a_project(int project_id) throws Exception {
		
		Project tempProject=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from projects where project_rid= ? ");
			stmt.setInt(1, project_id);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempProject = convertRowToProject(rs);
				
			}
			return tempProject;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_project(Project project) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into projects (project_id,aid,description,project_cost,envisaged_cod,npa_trigger_date,status,remarks) values (projects_seq.nextval,?,?,?,?,?,?,?)");
			stmt.setInt(1, project.getAid());
			stmt.setString(2, project.getDescription());
			stmt.setFloat(3, project.getProject_cost());
			stmt.setDate(4, new java.sql.Date(project.getEnvisaged_cod().getTime()));
			stmt.setDate(5, new java.sql.Date(project.getNpa_trigger_date().getTime()));
			stmt.setString(6, project.getStatus());
			stmt.setString(7, project.getRemarks());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_project(int project_id) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from projects where project_id=?");
			stmt.setInt(1, project_id);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_project(Project project) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update projects set aid=?,description=?,project_cost=?,envisaged_cod=?,npa_trigger_date=?,status=?,remarks=? where project_id=?");
			stmt.setInt(1, project.getAid());
			stmt.setString(2, project.getDescription());
			stmt.setFloat(3, project.getProject_cost());
			stmt.setDate(4, new java.sql.Date(project.getEnvisaged_cod().getTime()));
			stmt.setDate(5, new java.sql.Date(project.getNpa_trigger_date().getTime()));
			stmt.setString(6, project.getStatus());
			stmt.setString(7, project.getRemarks());
			stmt.setInt(8, project.getProject_id());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Project convertRowToProject(ResultSet rs) throws SQLException {
		
		int project_id = rs.getInt("project_id");	
		int aid = rs.getInt("aid");
		String description = rs.getString("description");
		Float project_cost = rs.getFloat("project_cost");
		Date envisaged_cod= rs.getDate("envisaged_cod");
		Date npa_trigger_date= rs.getDate("npa_trigger_date");
		String status = rs.getString("status");
		String remarks = rs.getString("remarks");
						
		Project tempProject = new Project(project_id,aid,description,project_cost,envisaged_cod,npa_trigger_date,status,remarks);
				return tempProject;
	}

}
