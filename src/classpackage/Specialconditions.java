package classpackage;

public class Specialconditions {

	private int cid,sid;
	private String condition;
	
	public Specialconditions() {
	    super();
	}
	
	public Specialconditions(int cid,String condition,int sid) {
		this.cid=cid;
		this.sid=sid;
		this.condition=condition;
		
		}

	public int getCid() {
		return cid;
	}

	public void setCid(int cid) {
		this.cid = cid;
	}

	public int getSid() {
		return sid;
	}

	public void setSid(int sid) {
		this.sid = sid;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	}
