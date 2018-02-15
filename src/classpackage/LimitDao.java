package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LimitDao {

	private Connection conn=null;
	
	public LimitDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Limit> get_all_limits() throws Exception {
	List<Limit> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from limits order by aid,lid");
		while (rs.next()) {
			Limit tempLimit = convertRowToLimit(rs);
			list.add(tempLimit);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Limit get_a_limit(int lid) throws Exception {
		
		Limit tempLimit=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from limits where lid= ? ");
			stmt.setInt(1, lid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempLimit = convertRowToLimit(rs);
				
			}
			return tempLimit;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_limit(Limit limit) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into limits (lid, aid, facility_name, sub_name, limit, cbs_no, sanction_ref, sanction_date, due_date, sub_limit, branch, dp, roc_status, fb_roi_pct, basis, spread_pct, term_premium, finer, nfb_fee_pct, sight_or_usance, nfb_period) values (limits_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setInt(1, limit.getAid());
			stmt.setString(2, limit.getFacility_name());
			stmt.setString(3, limit.getSub_name());
			stmt.setFloat(4, limit.getLimit());
			stmt.setString(5, limit.getCbs_no());
			stmt.setString(6, limit.getSanction_ref());
			stmt.setDate(7, new java.sql.Date(limit.getSanction_date().getTime()));
			stmt.setDate(8, new java.sql.Date(limit.getDue_date().getTime()));
			stmt.setString(9, limit.getSub_limit());
			stmt.setString(10, limit.getBranch());
			stmt.setFloat(11, limit.getDp());
			stmt.setString(12, limit.getRoc_status());
			stmt.setFloat(13, limit.getFb_roi_pct());
			stmt.setString(14, limit.getBasis());
			stmt.setFloat(15, limit.getSpread_pct());
			stmt.setFloat(16, limit.getTerm_premium());
			stmt.setString(17, limit.getFiner());
			stmt.setFloat(18, limit.getNfb_fee_pct());
			stmt.setString(19, limit.getSight_or_usance());
			stmt.setInt(20, limit.getNfb_period());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_limit(int lid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from limits where lid=?");
			stmt.setInt(1, lid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_limit(Limit limit) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update limits set aid=?, facility_name=?, sub_name=?, limit=?, cbs_no=?, sanction_ref=?, sanction_date=?, due_date=?, sub_limit=?, branch=?, dp=?, roc_status=?, fb_roi_pct=?, basis=?, spread_pct=?, term_premium=?, finer=?, nfb_fee_pct=?, sight_or_usance=?, nfb_period=? where lid=?");
			stmt.setInt(1, limit.getAid());
			stmt.setString(2, limit.getFacility_name());
			stmt.setString(3, limit.getSub_name());
			stmt.setFloat(4, limit.getLimit());
			stmt.setString(5, limit.getCbs_no());
			stmt.setString(6, limit.getSanction_ref());
			stmt.setDate(7, new java.sql.Date(limit.getSanction_date().getTime()));
			stmt.setDate(8, new java.sql.Date(limit.getDue_date().getTime()));
			stmt.setString(9, limit.getSub_limit());
			stmt.setString(10, limit.getBranch());
			stmt.setFloat(11, limit.getDp());
			stmt.setString(12, limit.getRoc_status());
			stmt.setFloat(13, limit.getFb_roi_pct());
			stmt.setString(14, limit.getBasis());
			stmt.setFloat(15, limit.getSpread_pct());
			stmt.setFloat(16, limit.getTerm_premium());
			stmt.setString(17, limit.getFiner());
			stmt.setFloat(18, limit.getNfb_fee_pct());
			stmt.setString(19, limit.getSight_or_usance());
			stmt.setInt(20, limit.getNfb_period());
			stmt.setInt(21, limit.getLid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Limit convertRowToLimit(ResultSet rs) throws SQLException {
		
		int lid = rs.getInt("lid");	
		int aid = rs.getInt("aid");
		String facility_name = rs.getString("facility_name");
		String sub_name = rs.getString("sub_name");
		Float limit = rs.getFloat("limit");
		String cbs_no = rs.getString("cbs_no");
		String sanction_ref = rs.getString("sanction_ref");
		Date sanction_date=rs.getDate("sanction_date");
		Date due_date=rs.getDate("due_date");
		String sub_limit = rs.getString("sub_limit");
		String branch = rs.getString("branch");
		Float dp = rs.getFloat("dp");
		String roc_status = rs.getString("roc_status");
		Float fb_roi_pct = rs.getFloat("fb_roi_pct");
		String basis = rs.getString("basis");
		Float spread_pct = rs.getFloat("spread_pct");
		Float term_premium = rs.getFloat("term_premium");
		String finer = rs.getString("finer");
		Float nfb_fee_pct = rs.getFloat("nfb_fee_pct");
		String sight_or_usance = rs.getString("sight_or_usance");
		int nfb_period = rs.getInt("nfb_period");
						
		Limit tempLimit = new Limit(lid, aid, facility_name, sub_name, limit, cbs_no, sanction_ref, sanction_date, due_date, sub_limit, branch, dp, roc_status, fb_roi_pct, basis, spread_pct, term_premium, finer, nfb_fee_pct, sight_or_usance, nfb_period);
				return tempLimit;
	}

}
