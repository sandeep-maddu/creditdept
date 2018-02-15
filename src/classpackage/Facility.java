package classpackage;

public class Facility {

	private String facility_name,fb_or_nfb,wc_or_tl;

	public Facility() {
	    super();
	}
	
	public Facility(String facility_name,String fb_or_nfb,String wc_or_tl) {
	this.facility_name=facility_name;
	this.fb_or_nfb=fb_or_nfb;
	this.wc_or_tl=wc_or_tl;
	}

	public String getFacility_name() {
		return facility_name;
	}

	public void setFacility_name(String facility_name) {
		this.facility_name = facility_name;
	}

	public String getFb_or_nfb() {
		return fb_or_nfb;
	}

	public void setFb_or_nfb(String fb_or_nfb) {
		this.fb_or_nfb = fb_or_nfb;
	}

	public String getWc_or_tl() {
		return wc_or_tl;
	}

	public void setWc_or_tl(String wc_or_tl) {
		this.wc_or_tl = wc_or_tl;
	}
	
}