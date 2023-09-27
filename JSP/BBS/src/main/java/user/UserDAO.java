package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;			// 데이터베이스에 접근하게 해주는 객체
	private PreparedStatement pstmt;	// 
	private ResultSet rs;				// 정보를 담을 수 있는 객체
	
	
	public UserDAO() {					// 생성자
		try {							// 자동 실행
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	// mysql 서버
			String dbID = "root";								// root 계정
			String dbPassword = "msko060201!";							// root 비밀번호
			Class.forName("com.mysql.jdbc.Driver");				// mysql 드라이버 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // 객체 안에 정보 저장
		} catch (Exception e) {			// 예외 처리
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {		// 실제 로그인 하는 함수
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// 입력할 문장을 미리 지정
		try {
			pstmt = conn.prepareStatement(SQL);					// sql injection 방지	
			pstmt.setString(1, userID);							
			rs = pstmt.executeQuery();							// 객체에 실행 결과 저장
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {				// 예외 처리
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
}
