package Diary;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DiaryDAO {
	final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	final String JDBC_URL = "jdbc:mysql://43.203.31.41:3309/GoodDiary";

	// DB 연결을 가져오는 메서드
	public Connection open() {
		Connection conn = null;
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL,"GoodDiary","goodgood1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// 일기 목록 전체를 가져오는 메서드
	public List<Diary> getAll() throws Exception {
		Connection conn = open();
		List<Diary> newsList = new ArrayList<>();
	
		String sql = "select aid, title, DATE_FORMAT(date, '%Y-%m-%d %H:%i:%s') as cdate from Diary";

		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		try(conn; pstmt; rs) {
			while(rs.next()) {
				Diary n = new Diary();
				n.setAid(rs.getInt("aid"));
				n.setTitle(rs.getString("title"));
				n.setDate(rs.getString("cdate"));
				newsList.add(n);
			}
			return newsList;
		}
	}
	
	// 일기 한 개를 클릭했을 때 세부 내용을 보여주는 메서드
	public Diary getDiary(int aid) throws SQLException {
		Connection conn = open();
		Diary n = new Diary();
		String sql = "select aid, title, img, DATE_FORMAT(date, '%Y-%m-%d %H:%i:%s') as cdate, content from Diary where aid=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, aid);//1은 ?의 위치 / 위치 정보는 1부터 시작
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		try(conn; pstmt; rs) {
			n.setAid(rs.getInt("aid"));
			n.setTitle(rs.getString("title"));
			n.setDate(rs.getString("cdate"));
			n.setContent(rs.getString("content"));
			pstmt.executeQuery();
			return n;
		}
	}

	
	// 일기 추가 메서드
	public void addDiary(Diary n) throws Exception {
		Connection conn = open();
		String sql = "insert into Diary(title,img,date,content) values(?,?,CURRENT_TIMESTAMP(),?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {//try 블록이 종료 될때 conn과 pstmt는 자동으로 닫히는 리소스로 간주
			pstmt.setString(1, n.getTitle());
			pstmt.setString(3, n.getContent());
			pstmt.executeUpdate();
		}
	}
	
	// 일기 삭제 메서드
	public void delDiary(int aid) throws SQLException {
		Connection conn = open();
		String sql = "delete from Diary where aid=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {
			pstmt.setInt(1, aid);
			// 삭제된 일기가 없을 경우
			if(pstmt.executeUpdate() == 0) {
				throw new SQLException("DB에러");
			}
		}
	}
	
	// 일기 수정 메서드
	public void editDiary(Diary n) throws Exception {
		Connection conn = open();
		String sql = "UPDATE Diary SET title = ?, img = ?, date = CURRENT_TIMESTAMP(), content = ? WHERE aid = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		try(conn; pstmt) {
			pstmt.setString(1, n.getTitle());
			pstmt.setString(3, n.getContent());
			pstmt.setInt(4, n.getAid());
			pstmt.executeUpdate();
		}
	}
	
}