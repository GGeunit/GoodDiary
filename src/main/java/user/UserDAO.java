package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private Connection conn;

    // 데이터베이스 연결 설정
    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://43.203.31.41:3309/GoodDiary"; // 데이터베이스 URL
            String dbUser = "GoodDiary"; // 데이터베이스 사용자
            String dbPassword = "goodgood1234"; // 데이터베이스 비밀번호
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 사용자 인증 메서드
    public boolean authenticate(String username, String password) {
        String query = "SELECT password FROM users WHERE username = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username); // 사용자 입력 username 설정
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password"); // DB에 저장된 비밀번호
                return password.equals(storedPassword); // 입력 비밀번호와 DB 비밀번호 비교
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 인증 실패
    }

    // 사용자 이름 가져오기 메서드
    public String getUserName(String username) {
        String query = "SELECT name FROM users WHERE username = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username); // 사용자 입력 username 설정
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name"); // 사용자 이름 반환
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // 사용자 이름 가져오기 실패
    }

    // 사용자 등록 메서드
    public boolean registerUser(String username, String password, String name) {
        String query = "INSERT INTO users (username, password, name) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, username); // 사용자 아이디 설정
            pstmt.setString(2, password); // 평문 비밀번호 저장
            pstmt.setString(3, name);     // 사용자 이름 설정
            pstmt.executeUpdate();
            return true; // 사용자 등록 성공
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // 사용자 등록 실패
    }
}
