package classpackage;

public class Pending {

	private int pi_id,aid;
	private String pending_issue;
	
	public Pending() {
	    super();
	}
	
	public Pending(int pi_id,String pending_issue,int aid) {
		this.pi_id=pi_id;
		this.aid=aid;
		this.pending_issue=pending_issue;
		
		}

	public int getPi_id() {
		return pi_id;
	}

	public void setPi_id(int pi_id) {
		this.pi_id = pi_id;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getPending_issue() {
		return pending_issue;
	}

	public void setPending_issue(String pending_issue) {
		this.pending_issue = pending_issue;
	}
	
}
