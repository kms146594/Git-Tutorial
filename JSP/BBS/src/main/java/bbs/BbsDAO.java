package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;			// �����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private ResultSet rs;				// ������ ���� �� �ִ� ��ü
	
	
	public BbsDAO() {					// ������
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
	
	
	public String getDate() {			// ���� �ð��� �������� �Լ�
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	//SQL ���� ���� �ܰ�
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);		// ���� �ð� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";						// �����ͺ��̽� ����
	}
	
	public int getNext() {				// �Խù� ��ȣ
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ���� ������ ��ȣ
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;  // ù ��° �Խù��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {		// �Խù� �ۼ�
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";		// ���� ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());			// �ϳ��� ���ڰ� ����
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);		// ���� ���� ����
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ����
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {			// Ư���� �������� ���� �Խñ� 10�� ��ȯ
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		// bbsID�� Ư���� ������ ���� �Խñ� AND �������� �ʾ� Available�� 1�� �Խñ��� bbsID ������������ �ִ� 10�� 
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);	// getNext:�������� �ۼ��� �Խñ� ��ȣ
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();	// bbs�� ���� ��� �Ӽ�
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);		// list�� ��� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;		// �����ͺ��̽� ����
	}
	
	public boolean nextPage(int pageNumber) {		// ������ ó���� ���� �Լ�(
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; // 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;		// ���� �������� �Ѿ �� ����
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;			// ���� �������� ����
	}
	
	public Bbs getBbs(int bbsID) {	// Ư���� bbsID�� �Խñ��� ������
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?"; // 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();	// bbs�� ���� ��� �Ӽ�
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;		// bbs ���� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
