package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppliedlimitsDao {

private Connection conn=null;
	
	public AppliedlimitsDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}

	public List<Appliedlimits> get_all_appliedlimits() throws Exception {
		List<Appliedlimits> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from applied_limits order by alid,pid");
			while (rs.next()) {
				Appliedlimits tempAppliedlimits = convertRowToAppliedlimits(rs);
				list.add(tempAppliedlimits);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
		}
		
		public Appliedlimits get_a_appliedlimit(int alid) throws Exception {
			
			Appliedlimits tempAppliedlimits=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from applied_limits where alid= ? ");
				stmt.setInt(1, alid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempAppliedlimits = convertRowToAppliedlimits(rs);
					
				}
				return tempAppliedlimits;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_appliedlimit(String facility_name, float existing_limit, float proposed_limit, float sanctioned_limit, int pid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into applied_limits (alid,facility_name,existing_limit,proposed_limit,sanctioned_limit,pid) values (appliedlimits_seq.nextval,?,?,?,?,?)");
				
				stmt.setString(1, facility_name);
				stmt.setFloat(2, existing_limit);
				stmt.setFloat(3, proposed_limit);
				stmt.setFloat(4, sanctioned_limit);
				stmt.setFloat(5, pid);
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_appliedlimit(int alid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from applied_limits where (alid=?)");
				stmt.setInt(1, alid);
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_appliedlimit(Appliedlimits appliedlimit) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update applied_limits set facility_name=?, existing_limit=?,proposed_limit=?,sanctioned_limit=?,pid=? where alid=?");
				
				stmt.setString(1, appliedlimit.getFacility_name());
				stmt.setFloat(2, appliedlimit.getExisting_limit());
				stmt.setFloat(3, appliedlimit.getProposed_limit());
				stmt.setFloat(4, appliedlimit.getSanctioned_limit());
				stmt.setInt(5, appliedlimit.getPid());
				stmt.setInt(6, appliedlimit.getAlid());
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Appliedlimits convertRowToAppliedlimits(ResultSet rs) throws SQLException {
			
			int alid = rs.getInt("alid");
			String facility_name = rs.getString("facility_name");
			float existing_limit = rs.getFloat("existing_limit");
			float proposed_limit = rs.getFloat("proposed_limit");
			float sanctioned_limit = rs.getFloat("sanctioned_limit");
			int pid = rs.getInt("pid");
					
			Appliedlimits tempAppliedlimit = new Appliedlimits(alid,facility_name,existing_limit,proposed_limit,sanctioned_limit,pid);
					return tempAppliedlimit;
		}
	
}
