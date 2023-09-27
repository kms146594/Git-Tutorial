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
			String dbURL = "jdbc:mysql://localhost:3306/BBS";	// mysql ����
			String dbID = "root";								// root ����
			String dbPassword = "msko060201!";							// root ��й�ȣ
			Class.forName("com.mysql.jdbc.Driver");				// mysql ����̹� ã��
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
}
