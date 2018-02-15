package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class InsuranceDao {

	private Connection conn=null;
	
	public InsuranceDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
		
	}
	
	
	public List<Insurance> get_all_insurances() throws Exception {
	List<Insurance> list = new ArrayList<>();
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=conn.createStatement();
		rs=stmt.executeQuery("select * from insurance order by aid,policyid");
		while (rs.next()) {
			Insurance tempInsurance = convertRowToInsurance(rs);
			list.add(tempInsurance);
			}
		return list;
	}
	finally {
		stmt.close();
		rs.close();
		}
	
	
			
	}
	
	public Insurance get_a_insurance(String policyid) throws Exception {
		
		Insurance tempInsurance=null;
		PreparedStatement stmt=null;
		ResultSet rs=null;
		
		try{
			
			stmt=conn.prepareStatement("select * from insurance where policycid= ? ");
			stmt.setString(1, policyid);
			rs=stmt.executeQuery();
			while (rs.next()) {
				tempInsurance = convertRowToInsurance(rs);
				
			}
			return tempInsurance;
		}
		finally {
			stmt.close();
			rs.close();
			}
					
		}
	
	public void add_insurance(Insurance insurance) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("insert into insurance (policyid,agency, sum_assured,policy_duedate,aid) values (?,?,?,?,?)");
			stmt.setString(1, insurance.getPolicyid());
			stmt.setString(2, insurance.getAgency());
			stmt.setFloat(3, insurance.getSum_assured());
			stmt.setDate(4, new java.sql.Date(insurance.getPolicy_duedate().getTime()));
			stmt.setInt(5, insurance.getAid());
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}


	public void delete_insurance(String policyid) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("delete from insurance where policyid=?");
			stmt.setString(1, policyid);
			
			stmt.execute();
			
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

	
public void edit_insurance(Insurance insurance) throws Exception {
		
		
		PreparedStatement stmt=null;
		
		
		try{
			
			stmt=conn.prepareStatement("update insurance set policyid=?,agency=?,sum_assured=?,policy_duedate=?,aid=? where policyid=?");
			stmt.setString(1, insurance.getPolicyid());
			stmt.setString(2, insurance.getAgency());
			stmt.setFloat(3, insurance.getSum_assured());
			stmt.setDate(4, new java.sql.Date(insurance.getPolicy_duedate().getTime()));
			stmt.setInt(5, insurance.getAid());
			stmt.setString(6, insurance.getPolicyid());
			
			stmt.execute();
					}
		finally {
			stmt.close();
			conn.close();
			}
					
		}

private Insurance convertRowToInsurance(ResultSet rs) throws SQLException {
		
		String policyid = rs.getString("policyid");
		String agency = rs.getString("agency");
		float sum_assured = rs.getFloat("sum_assured");
		Date policy_duedate=rs.getDate("policy_duedate");
		int aid = rs.getInt("aid");
				
		Insurance tempInsurance = new Insurance(policyid,agency, sum_assured,policy_duedate,aid);
				return tempInsurance;
	}

}
