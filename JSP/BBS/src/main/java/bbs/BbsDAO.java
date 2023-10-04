package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	
}
