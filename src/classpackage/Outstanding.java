package classpackage;
import java.util.Date;

public class Outstanding {
	
	private int oid,lid;
	private float os ;
	private Date os_date;
	
	public Outstanding() {
	    super();
	}

	public Outstanding(int oid, int lid, float os, Date os_date) {
		this.oid = oid;
		this.lid = lid;
		this.os = os;
		this.os_date = os_date;
	}

	public int getOid() {
		return oid;
	}

	public void setOid(int oid) {
		this.oid = oid;
	}

	public int getLid() {
		return lid;
	}

	public void setLid(int lid) {
		this.lid = lid;
	}

	public float getOs() {
		return os;
	}

	public void setOs(float os) {
		this.os = os;
	}

	public Date getOs_date() {
		return os_date;
	}

	public void setOs_date(Date os_date) {
		this.os_date = os_date;
	}


}
