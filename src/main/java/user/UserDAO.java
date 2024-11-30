package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Diary.Diary;

public class UserDAO {

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

//    // 사용자 인증 메서드
//    public boolean authenticate(String username, String password) {
//        String query = "SELECT password FROM users WHERE username = ?";
//        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
//            pstmt.setString(1, username); // 사용자 입력 username 설정
//            ResultSet rs = pstmt.executeQuery();
//            if (rs.next()) {
//                String storedPassword = rs.getString("password"); // DB에 저장된 비밀번호
//                return password.equals(storedPassword); // 입력 비밀번호와 DB 비밀번호 비교
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false; // 인증 실패
//    }
//
//    // 사용자 이름 가져오기 메서드
//    public String getUserName(String username) {
//        String query = "SELECT name FROM users WHERE username = ?";
//        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
//            pstmt.setString(1, username); // 사용자 입력 username 설정
//            ResultSet rs = pstmt.executeQuery();
//            if (rs.next()) {
//                return rs.getString("name"); // 사용자 이름 반환
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null; // 사용자 이름 가져오기 실패
//    }
//
//    // 사용자 등록 메서드
//    public boolean registerUser(String username, String password, String name) {
//        String query = "INSERT INTO users (username, password, name) VALUES (?, ?, ?)";
//        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
//            pstmt.setString(1, username); // 사용자 아이디 설정
//            pstmt.setString(2, password); // 평문 비밀번호 저장
//            pstmt.setString(3, name);     // 사용자 이름 설정
//            pstmt.executeUpdate();
//            return true; // 사용자 등록 성공
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false; // 사용자 등록 실패
//    }
    
 // 회원가입 메서드
 	public void signup(User n) throws SQLException {
 		Connection conn = open();
 		String sql = "insert into user (user_name, password) values(?, ?)";
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		try(conn; pstmt) {
 			pstmt.setString(1, n.getUsername());
 			pstmt.setString(2, n.getPassword());
 			pstmt.executeUpdate();
 		}
 	}

 	// 로그인 메서드
 	public User login(String name, String password) throws SQLException {
 		Connection conn = open();
 		String sql = "SELECT * FROM user WHERE user_name = ? AND password = ?";
 		PreparedStatement pstmt = conn.prepareStatement(sql);
 		
 		try(conn; pstmt) {
 			pstmt.setString(1, name);
 			pstmt.setString(2, password);
 			
 			ResultSet rs = pstmt.executeQuery();
 			if(rs.next()) {
 				User user = new User();
 				user.setUserId(rs.getInt("id"));
 				user.setUsername(rs.getString("user_name"));
 				return user;
 			}
 		}
		return null;
 	}
}
