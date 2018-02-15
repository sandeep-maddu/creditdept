package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AccountDao {

	private Connection conn=null;
	
	public AccountDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Account> get_all_accounts() throws Exception {
	List<Account> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from accounts order by aid");
		while (rs.next()) {
			Account tempAccount = convertRowToAccount(rs);
			list.add(tempAccount);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Account get_a_account(int aid) throws Exception {
		
		Account tempAccount=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from accounts where aid= ? ");
			stmt.setInt(1, aid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempAccount = convertRowToAccount(rs);
				
			}
			return tempAccount;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_account(Account account) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into accounts (aid,cust_id,account_name,subdept,file_no,powers,asset_classf,constitution,chief_exec,concerned_officer,close_status,activity_name,incorp_date,dealing_since) values (aid_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			stmt.setString(1, account.getCust_id());
			stmt.setString(2, account.getAccount_name());
			stmt.setInt(3, account.getSubdept());
			stmt.setString(4, account.getFile_no());
			stmt.setInt(5, account.getPowers());
			stmt.setString(6, account.getAsset_classf());
			stmt.setString(7, account.getConstitution());
			stmt.setString(8, account.getChief_exec());
			stmt.setInt(9, account.getConcerned_officer());
			stmt.setString(10, account.getClose_status());
			stmt.setString(11, account.getActivity_name());
			stmt.setDate(12, new java.sql.Date(account.getIncorp_date().getTime()));
			stmt.setDate(13, new java.sql.Date(account.getDealing_since().getTime()));
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_account(int aid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from accounts where aid=?");
			stmt.setInt(1, aid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_account(Account account) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update accounts set cust_id=?,account_name=?,subdept=?,file_no=?,powers=?,asset_classf=?,constitution=?,chief_exec=?,concerned_officer=?,close_status=?,activity_name=?,incorp_date=?,dealing_since=? where aid=?");
			stmt.setString(1, account.getCust_id());
			stmt.setString(2, account.getAccount_name());
			stmt.setInt(3, account.getSubdept());
			stmt.setString(4, account.getFile_no());
			stmt.setInt(5, account.getPowers());
			stmt.setString(6, account.getAsset_classf());
			stmt.setString(7, account.getConstitution());
			stmt.setString(8, account.getChief_exec());
			stmt.setInt(9, account.getConcerned_officer());
			stmt.setString(10, account.getClose_status());
			stmt.setString(11, account.getActivity_name());
			stmt.setDate(12, new java.sql.Date(account.getIncorp_date().getTime()));
			stmt.setDate(13, new java.sql.Date(account.getDealing_since().getTime()));
			stmt.setInt(14, account.getAid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Account convertRowToAccount(ResultSet rs) throws SQLException {
		
		int aid = rs.getInt("aid");
		String cust_id = rs.getString("cust_id");
		String account_name = rs.getString("account_name");
		int subdept = rs.getInt("subdept");
		String file_no = rs.getString("file_no");
		int powers = rs.getInt("powers");
		String asset_classf = rs.getString("asset_classf");
		Date incorp_date=rs.getDate("incorp_date");
		String constitution = rs.getString("constitution");
		String chief_exec = rs.getString("chief_exec");
		Date dealing_since=rs.getDate("dealing_since");
		int concerned_officer = rs.getInt("concerned_officer");
		String close_status = rs.getString("close_status");
		String activity_name = rs.getString("activity_name");
				
		Account tempAccount = new Account(aid,subdept,powers,concerned_officer, cust_id, account_name, file_no, asset_classf, constitution, chief_exec, close_status, activity_name, incorp_date, dealing_since);
				return tempAccount;
	}

}
