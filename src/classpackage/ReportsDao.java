package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportsDao {

	private Connection conn=null;
	
	public ReportsDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	public List<Reports> get_all_reports() throws Exception {
		List<Reports> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from reports order by report_name");
			while (rs.next()) {
				Reports tempReport = convertRowToReport(rs);
				list.add(tempReport);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Reports get_a_report(String report_name) throws Exception {
			
			Reports tempReport=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from reports where report_name= ? ");
				stmt.setString(1, report_name);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempReport = convertRowToReport(rs);
					
				}
				return tempReport;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_report(Reports report) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into reports (report_name,periodicity) values (?,?)");
				stmt.setString(1, report.getReport_name());
				stmt.setString(2, report.getPeriodicity());
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_report(String report_name) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from reports where report_name=?");
				stmt.setString(1, report_name);
				
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_report(Reports report) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update reports set report_name=?,periodicity=? where report_name=?");
				stmt.setString(1, report.getReport_name());
				stmt.setString(2, report.getPeriodicity());
				stmt.setString(3, report.getReport_name());
				
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Reports convertRowToReport(ResultSet rs) throws SQLException {
			
			String report_name = rs.getString("report_name");
			String periodicity = rs.getString("periodicity");
							
			Reports tempReport = new Reports(report_name,periodicity);
					return tempReport;
		}
}
