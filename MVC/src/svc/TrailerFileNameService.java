package svc;

public class TrailerFileNameService {

	public String[] replace(String trailer) {
		System.out.println("TrailerFileNameService - replace()");
		
		String[] trailerFileName = trailer.split("\n");
		
		return trailerFileName;
		
	}

}
