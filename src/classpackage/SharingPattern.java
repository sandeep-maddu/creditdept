package classpackage;

public class SharingPattern {

	private int spid,bid;
	private String bank;
	private Float limit,share_pct;
	
	public SharingPattern() {
	    super();
	}

	public SharingPattern(int spid, int bid, String bank, Float limit, Float share_pct) {
		this.spid = spid;
		this.bid = bid;
		this.bank = bank;
		this.limit = limit;
		this.share_pct = share_pct;
	}

	public int getSpid() {
		return spid;
	}

	public void setSpid(int spid) {
		this.spid = spid;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public Float getLimit() {
		return limit;
	}

	public void setLimit(Float limit) {
		this.limit = limit;
	}

	public Float getShare_pct() {
		return share_pct;
	}

	public void setShare_pct(Float share_pct) {
		this.share_pct = share_pct;
	}
	
		}
