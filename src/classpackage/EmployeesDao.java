package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class EmployeesDao {

	private Connection conn=null;
	
	public EmployeesDao() throws SQLException {
		
		
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	public List<Employees> get_all_employees() throws Exception {
		List<Employees> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from employees order by eid ");
			while (rs.next()) {
				
				Employees tempEmployee = convertRowToEmployee(rs);
				list.add(tempEmployee);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Employees get_a_employee(String emp_name) throws Exception {
			
			Employees tempEmployee=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				emp_name+="%";
				stmt=conn.prepareStatement("select * from employees where emp_name like ? ");
				stmt.setString(1, emp_name);
				rs=stmt.executeQuery();
				while (rs.next()) {
					
					tempEmployee = convertRowToEmployee(rs);
					
				}
				return tempEmployee;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		
	
	public void add_employee(Employees emp) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into employees (eid,scale,designation,hire_date,reports_to,emp_name,discretionary_powers,sub_dept) values (?,?,?,?,?,?,?,?)");
			stmt.setInt(1, emp.getEid());
			stmt.setString(2, emp.getScale());
			stmt.setString(3, emp.getDesignation());
			stmt.setDate(4, new java.sql.Date(emp.getHire_date().getTime()));
			stmt.setInt(5, emp.getReports_to());
			stmt.setString(6, emp.getEmp_name());
			stmt.setFloat(7, emp.getDiscretionary_powers());
			stmt.setInt(8, emp.getSub_dept());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}





	public void delete_employee(String emp_name) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from employees where emp_name=?");
			stmt.setString(1, emp_name);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_employee(Employees emp) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update employees set eid=?,scale=?,designation=?,hire_date=?,reports_to=?,emp_name=?,discretionary_powers=?,sub_dept=? where eid=?");
			stmt.setInt(1, emp.getEid());
			stmt.setString(2, emp.getScale());
			stmt.setString(3, emp.getDesignation());
			stmt.setDate(4, new java.sql.Date(emp.getHire_date().getTime()));
			stmt.setInt(5, emp.getReports_to());
			stmt.setString(6, emp.getEmp_name());
			stmt.setFloat(7, emp.getDiscretionary_powers());
			stmt.setInt(8, emp.getSub_dept());
			stmt.setInt(9, emp.getEid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}



	private Employees convertRowToEmployee(ResultSet rs) throws SQLException {
			
			int eid = rs.getInt("eid");
			int reports_to = rs.getInt("reports_to");
			float discretionary_powers = rs.getFloat("discretionary_powers");
			int sub_dept = rs.getInt("sub_dept");
			String scale = rs.getString("scale");
			String designation = rs.getString("designation");
			String emp_name = rs.getString("emp_name");
			Date hire_date=rs.getDate("hire_date");

			Employees tempEmployee = new Employees(eid,reports_to,discretionary_powers,sub_dept,scale,designation,emp_name,hire_date);
			
			return tempEmployee;
		}
}
