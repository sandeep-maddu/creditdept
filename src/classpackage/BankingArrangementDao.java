package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BankingArrangementDao {

	private Connection conn=null;
	
	public BankingArrangementDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<BankingArrangement> get_all_bankingarrangement() throws Exception {
	List<BankingArrangement> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from banking_arrangement order by aid,bid");
		while (rs.next()) {
			BankingArrangement tempBankingArrangement = convertRowToBankingArrangement(rs);
			list.add(tempBankingArrangement);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public BankingArrangement get_a_bankingarrangement(int bid) throws Exception {
		
		BankingArrangement tempBankingArrangement=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from banking_arrangement where bid= ? ");
			stmt.setInt(1, bid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempBankingArrangement = convertRowToBankingArrangement(rs);
				
			}
			return tempBankingArrangement;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_bankingarrangement(BankingArrangement bankingarrangement) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into banking_arrangement (bid,aid,facility_name,type,number_banks,leader_bank,latest_consortium_meeting,diligence_report,credit_information_exchange) values (bid_seq.nextval,?,?,?,?,?,?,?,?)");
			stmt.setInt(1, bankingarrangement.getAid());
			stmt.setString(2, bankingarrangement.getFacility_name());
			stmt.setString(3, bankingarrangement.getType());
			stmt.setInt(4, bankingarrangement.getNumber_banks());
			stmt.setString(5, bankingarrangement.getLeader_bank());
			stmt.setDate(6, new java.sql.Date(bankingarrangement.getLatest_consortium_meeting().getTime()));
			stmt.setString(7, bankingarrangement.getDiligence_report());
			stmt.setString(8, bankingarrangement.getCredit_information_exchange());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_bankingarrangement(int aid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from banking_arrangement where bid=?");
			stmt.setInt(1, aid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_bankingarrangement(BankingArrangement bankingarrangement) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update banking_arrangement set aid=?,facility_name=?,type=?,number_banks=?,leader_bank=?,latest_consortium_meeting=?,diligence_report=?,credit_information_exchange=? where bid=?");
			stmt.setInt(1, bankingarrangement.getAid());
			stmt.setString(2, bankingarrangement.getFacility_name());
			stmt.setString(3, bankingarrangement.getType());
			stmt.setInt(4, bankingarrangement.getNumber_banks());
			stmt.setString(5, bankingarrangement.getLeader_bank());
			stmt.setDate(6, new java.sql.Date(bankingarrangement.getLatest_consortium_meeting().getTime()));
			stmt.setString(7, bankingarrangement.getDiligence_report());
			stmt.setString(8, bankingarrangement.getCredit_information_exchange());
			stmt.setInt(9, bankingarrangement.getBid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private BankingArrangement convertRowToBankingArrangement(ResultSet rs) throws SQLException {
		
		int bid = rs.getInt("bid");	
		int aid = rs.getInt("aid");
		String facility_name = rs.getString("facility_name");
		String type = rs.getString("type");
		int number_banks = rs.getInt("number_banks");
		String leader_bank = rs.getString("leader_bank");
		Date latest_consortium_meeting=rs.getDate("latest_consortium_meeting");
		String diligence_report = rs.getString("diligence_report");
		String credit_information_exchange = rs.getString("credit_information_exchange");
				
		BankingArrangement tempBankingArrangement = new BankingArrangement(bid,aid,facility_name,type,number_banks,leader_bank,latest_consortium_meeting,diligence_report,credit_information_exchange);
				return tempBankingArrangement;
	}

}
