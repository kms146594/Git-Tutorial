package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;			// 데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;				// 정보를 담을 수 있는 객체
	
	
	public BbsDAO() {					// 생성자
		try {							// 자동 실행
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";	// mysql 서버
			String dbID = "root";								// root 계정
			String dbPassword = "msko060201!";							// root 비밀번호
			Class.forName("com.mysql.cj.jdbc.Driver");				// mysql 드라이버 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 객체 안에 정보 저장
		} catch (Exception e) {			// 예외 처리
			e.printStackTrace();
		}
	}
	
	
	public String getDate() {			// 현재 시간을 가져오는 함수
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	//SQL 문장 실행 단계
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);		// 현재 시간 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";						// 데이터베이스 오류
	}
	
	public int getNext() {				// 게시물 번호
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // 가장 마지막 번호
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;  // 첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {		// 게시물 작성
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";		// 실제 인자 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());			// 하나씩 인자값 저장
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);		// 삭제 되지 않음
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {			// 특정한 페이지에 따른 게시글 10개 반환
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		// bbsID가 특정한 수보다 작은 게시글 AND 삭제되지 않아 Available이 1인 게시글을 bbsID 내림차순으로 최대 10개 
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);	// getNext:다음으로 작성될 게시글 번호
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();	// bbs에 담을 모든 속성
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);		// list에 담아 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;		// 데이터베이스 오류
	}
	
	public boolean nextPage(int pageNumber) {		// 페이지 처리를 위한 함수(
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; // 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;		// 다음 페이지로 넘어갈 수 있음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;			// 다음 페이지가 없음
	}
	
	public Bbs getBbs(int bbsID) {	// 특정한 bbsID의 게시글을 가져옴
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; // 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();	// bbs에 담을 모든 속성
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;		// bbs 내용 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
