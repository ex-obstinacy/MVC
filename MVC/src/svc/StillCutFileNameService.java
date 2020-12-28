package svc;

public class StillCutFileNameService {

	public String[] replace(String stillCut) {
		System.out.println("StillCutFileNameService - replace()");
		
		String[] stillCutFileName = stillCut.split("&");
		
		return stillCutFileName;
		
	}

}
