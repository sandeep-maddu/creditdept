package classpackage;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProposalDao {

private Connection conn=null;
	
	public ProposalDao() throws SQLException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "bankloans", "bankloans");
}
	public List<Proposal> get_all_proposals() throws Exception {
		List<Proposal> list = new ArrayList<>();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try{
			stmt=conn.createStatement();
			rs=stmt.executeQuery("select * from proposal order by pid");
			while (rs.next()) {
				Proposal tempProposal = convertRowToProposal(rs);
				list.add(tempProposal);
				}
			return list;
		}
		finally {
			stmt.close();
			rs.close();
			}
		
		
				
		}
		
		public Proposal get_a_proposal(int pid) throws Exception {
			
			Proposal tempProposal=null;
			PreparedStatement stmt=null;
			ResultSet rs=null;
			
			try{
				
				stmt=conn.prepareStatement("select * from proposal where pid= ? ");
				stmt.setInt(1, pid);
				rs=stmt.executeQuery();
				while (rs.next()) {
					tempProposal = convertRowToProposal(rs);
					
				}
				return tempProposal;
			}
			finally {
				stmt.close();
				rs.close();
				}
						
			}
		
		public void add_proposal(Proposal proposal) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("insert into proposal (pid,internal_number,receipt_date,aid,handling_officer) values (proposal_seq.nextval,?,?,?,?)");
				stmt.setString(1, proposal.getInternal_number());
				stmt.setDate(2, new java.sql.Date(proposal.getReceipt_date().getTime()));
				stmt.setInt(3, proposal.getAid());
				stmt.setInt(4, proposal.getHandling_officer());
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}


		public void delete_proposal(int pid) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("delete from proposal where pid=?");
				stmt.setInt(1, pid);
				
				stmt.execute();
				
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

		
	public void edit_proposal(Proposal proposal) throws Exception {
			
			
			PreparedStatement stmt=null;
			
			
			try{
				
				stmt=conn.prepareStatement("update proposal set internal_number=?,receipt_date=?,aid=?,handling_officer=? where pid=?");
				stmt.setString(1, proposal.getInternal_number());
				stmt.setDate(2, new java.sql.Date(proposal.getReceipt_date().getTime()));
				stmt.setInt(3, proposal.getAid());
				stmt.setInt(4, proposal.getHandling_officer());
				stmt.setInt(5, proposal.getPid());
				stmt.execute();
						}
			finally {
				stmt.close();
				conn.close();
				}
						
			}

	private Proposal convertRowToProposal(ResultSet rs) throws SQLException {
			
			int pid = rs.getInt("pid");
			String internal_number = rs.getString("internal_number");
			Date receipt_date=rs.getDate("receipt_date");
			int aid = rs.getInt("aid");
			int handling_officer = rs.getInt("handling_officer");
					
			Proposal tempProposal = new Proposal(pid,internal_number,receipt_date,aid,handling_officer);
					return tempProposal;
		}
}
