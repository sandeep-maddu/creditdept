package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DecisionDao {

	private Connection conn=null;
	
	public DecisionDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Decision> get_all_decisions() throws Exception {
	List<Decision> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from decisions order by did");
		while (rs.next()) {
			Decision tempDecision = convertRowToDecision(rs);
			list.add(tempDecision);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Decision get_a_decision(int did) throws Exception {
		
		Decision tempDecision=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from decisions where did= ? ");
			stmt.setInt(1, did);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempDecision = convertRowToDecision(rs);
				
			}
			return tempDecision;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_decision(Decision decision) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into decisions (did,decision_date,approving_authority,aid,letter_ref,received_on,review_authority) values (decisions_seq.nextval,?,?,?,?,?,?)");
			
			stmt.setDate(1, new java.sql.Date(decision.getDecision_date().getTime()));
			stmt.setInt(2, decision.getApproving_authority());
			stmt.setInt(3, decision.getAid());
			stmt.setString(4, decision.getLetter_ref());
			stmt.setDate(5, new java.sql.Date(decision.getReceived_on().getTime()));
			stmt.setInt(6, decision.getReview_authority());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_decision(int did) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from decisions where did=?");
			stmt.setInt(1, did);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_decision(Decision decision) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update decisions set decision_date=?,approving_authority=?,aid=?,letter_ref=?,received_on=?,review_authority=? where did=?");
			stmt.setDate(1, new java.sql.Date(decision.getDecision_date().getTime()));
			stmt.setInt(2, decision.getApproving_authority());
			stmt.setInt(3, decision.getAid());
			stmt.setString(4, decision.getLetter_ref());
			stmt.setDate(5, new java.sql.Date(decision.getReceived_on().getTime()));
			stmt.setInt(6, decision.getReview_authority());
			stmt.setInt(7, decision.getDid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Decision convertRowToDecision(ResultSet rs) throws SQLException {
		
		int did = rs.getInt("did");
		Date decision_date=rs.getDate("decision_date");
		int approving_authority = rs.getInt("approving_authority");
		int aid = rs.getInt("aid");
		String letter_ref = rs.getString("letter_ref");
		Date received_on=rs.getDate("received_on");
		int review_authority = rs.getInt("review_authority");
		
		Decision tempDecision = new Decision(did,decision_date,approving_authority,aid,letter_ref,received_on,review_authority);
				return tempDecision;
	}

}
