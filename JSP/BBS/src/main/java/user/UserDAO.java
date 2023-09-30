package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;			// �����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private PreparedStatement pstmt;	// 
	private ResultSet rs;				// ������ ���� �� �ִ� ��ü
	
	
	public UserDAO() {					// ������
		try {							// �ڵ� ����
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";	// mysql ����
			String dbID = "root";								// root ����
			String dbPassword = "msko060201!";							// root ��й�ȣ
			Class.forName("com.mysql.cj.jdbc.Driver");				// mysql ����̹� ã��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // ��ü �ȿ� ���� ����
		} catch (Exception e) {			// ���� ó��
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {		// ���� �α��� �ϴ� �Լ�
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";	// �Է��� ������ �̸� ����
		try {
			pstmt = conn.prepareStatement(SQL);					// sql injection ����	
			pstmt.setString(1, userID);							
			rs = pstmt.executeQuery();							// ��ü�� ���� ��� ����
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // �α��� ����
				}
				else
					return 0; // ��й�ȣ ����ġ
			}
			return -1; // ���̵� ����
		} catch (Exception e) {				// ���� ó��
			e.printStackTrace();
		}
		return -2; // �����ͺ��̽� ����
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";  // ������� 5���� �� ����
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  user.getUserID());		// �Ű������� �Ѿ�� �� ����
			pstmt.setString(2,  user.getUserPassword());
			pstmt.setString(3,  user.getUserName());
			pstmt.setString(4,  user.getUserGender());
			pstmt.setString(5,  user.getUserEmail());
			return pstmt.executeUpdate();		// ������ ��� , ���� �� 0 �̻��� ���� ��ȯ
		} catch(Exception e) {		// ���� ó��
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
