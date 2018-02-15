package classpackage;



import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubDepartmentDao {

	private Connection conn=null;
	
	public SubDepartmentDao() throws SQLException {
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<SubDepartment> get_all_subdepts() throws Exception {
	List<SubDepartment> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from sub_department order by dept_id");
		while (rs.next()) {
			
			SubDepartment tempSubDept = convertRowToSubDept(rs);
			list.add(tempSubDept);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public SubDepartment get_a_subdept(String dept_name) throws Exception {
		
		SubDepartment tempSubDept=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			dept_name+="%";
			stmt=conn.prepareStatement("select * from sub_department where dept_name like ? ");
			stmt.setString(1, dept_name);
			rs=stmt.executeQuery();
			while (rs.next()) {
				
				tempSubDept = convertRowToSubDept(rs);
				
			}
			return tempSubDept;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	
public void add_subdept(SubDepartment subdept) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into sub_department (dept_id,dept_name,hod) values (dept_id_seq.nextval,?,?)");
			stmt.setString(1, subdept.getDept_name());
			stmt.setInt(2, subdept.getHod());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	



public void delete_subdept(int dept_id) throws Exception {
	
	
	PreparedStatement stmt=null;
	
	
	try{
		
		stmt=conn.prepareStatement("delete from sub_department where dept_id=?");
		stmt.setInt(1, dept_id);
		
		stmt.execute();
				}
	finally {
		stmt.close();
		conn.close();
		}
				
	}

public void edit_subdept(SubDepartment subdept) throws Exception {
	
	
	PreparedStatement stmt=null;
	
	
	try{
		
		stmt=conn.prepareStatement("update sub_department set dept_name=?,hod=? where dept_id=?");
		stmt.setString(1, subdept.getDept_name());
		stmt.setInt(2, subdept.getHod());
		stmt.setInt(3, subdept.getDept_id());
		stmt.execute();
				}
	finally {
		stmt.close();
		conn.close();
		}
				
	}

private SubDepartment convertRowToSubDept(ResultSet rs) throws SQLException {
		
		int dept_id = rs.getInt("dept_id");
		String dept_name = rs.getString("dept_name");
		int hod = rs.getInt("hod");
		
		
		SubDepartment tempSubDept = new SubDepartment(dept_id,dept_name,hod);
		
		return tempSubDept;
	}

}
