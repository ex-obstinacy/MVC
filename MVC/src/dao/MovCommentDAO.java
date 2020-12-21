package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import static db.JdbcUtil.*;
import vo.MovCommentBean;

public class MovCommentDAO {
	
	// 싱글톤 패턴
	
	private MovCommentDAO() {}
	
	private static MovCommentDAO instance = new MovCommentDAO();

	public static MovCommentDAO getInstance() {
		return instance;
		
	}

	//==================================================================
	
	Connection con;
	
	public void setConnetion(Connection con) {
		this.con = con;
	}
	
	//댓글 추가 작업
	public int insertComment(MovCommentBean movCommentBean){
		
		int insertCount=0;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			String sql2 ="SELECT MAX(num) FROM comment";
			pstmt.executeQuery(sql2);
			
			
			String sql ="INSERT INTO comment VALUES(?,?,?,?,?) ";
			pstmt.setInt(1,movCommentBean.getMovieCd());
			pstmt.setInt(2, movCommentBean.getNum());
			pstmt.setString(3, movCommentBean.getName());
			pstmt.setString(4, movCommentBean.getContent());
			pstmt.setTimestamp(5, movCommentBean.getDate());
			pstmt.setInt(6, movCommentBean.getRating());
			
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("MovieComment() 오류!"+e.getMessage());
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}
	
}
