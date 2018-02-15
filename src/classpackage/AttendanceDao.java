package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AttendanceDao {

	private Connection conn=null;
	
	public AttendanceDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Attendance> get_all_attendance() throws Exception {
	List<Attendance> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from attendance order by attdid");
		while (rs.next()) {
			Attendance tempAttendance = convertRowToAttendance(rs);
			list.add(tempAttendance);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Attendance get_a_attendance(int attdid) throws Exception {
		
		Attendance tempAttendance=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from attendance where attdid= ? ");
			stmt.setInt(1, attdid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempAttendance = convertRowToAttendance(rs);
				
			}
			return tempAttendance;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_attendance(Attendance attendance) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into attendance (attdid,period,report_name,aid,received_date,reviewed_date,responsible_officer) values (attendance_seq.nextval,?,?,?,?,?,?)");
			stmt.setDate(1, new java.sql.Date(attendance.getPeriod().getTime()));
			stmt.setString(2, attendance.getReport_name());
			stmt.setInt(3, attendance.getAid());
			stmt.setDate(4, new java.sql.Date(attendance.getReceived_date().getTime()));
			stmt.setDate(5, new java.sql.Date(attendance.getReviewed_date().getTime()));
			stmt.setInt(6, attendance.getResponsible_officer());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_attendance(int attdid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from attendance where attdid=?");
			stmt.setInt(1, attdid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_attendance(Attendance attendance) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update attendance set period=?,report_name=?,aid=?,received_date=?,reviewed_date=?,responsible_officer=? where attdid=?");
			stmt.setDate(1, new java.sql.Date(attendance.getPeriod().getTime()));
			stmt.setString(2, attendance.getReport_name());
			stmt.setInt(3, attendance.getAid());
			stmt.setDate(4, new java.sql.Date(attendance.getReceived_date().getTime()));
			stmt.setDate(5, new java.sql.Date(attendance.getReviewed_date().getTime()));
			stmt.setInt(6, attendance.getResponsible_officer());
			stmt.setInt(7, attendance.getAttdid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Attendance convertRowToAttendance(ResultSet rs) throws SQLException {
		
		int attdid = rs.getInt("attdid");
		Date period=rs.getDate("period");
		String report_name = rs.getString("report_name");
		int aid = rs.getInt("aid");
		Date received_date=rs.getDate("received_date");
		Date reviewed_date=rs.getDate("reviewed_date");
		int responsible_officer = rs.getInt("responsible_officer");
				
		Attendance tempAttendance = new Attendance(attdid,period,report_name,aid,received_date,reviewed_date,responsible_officer);
				return tempAttendance;
	}

}
