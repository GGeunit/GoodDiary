package Diary;

import java.sql.*;
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
            conn = DriverManager.getConnection(JDBC_URL, "GoodDiary", "goodgood1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    // CREATE: 새로운 다이어리 추가
    public void addDiary(Diary diary) throws SQLException {
        String query = "INSERT INTO emotionRecord (user_id, title, date, emotion, content) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
        	pstmt.setInt(1, diary.getAid());
            pstmt.setString(2, diary.getTitle());
            pstmt.setString(3, diary.getDate());
            pstmt.setString(4, diary.getEmotion());
            pstmt.setString(5, diary.getContent());
            pstmt.executeUpdate();
        }
    }

    // READ ALL: 모든 다이어리 조회
    public List<Diary> getAllDiaries() throws SQLException {
        List<Diary> diaries = new ArrayList<>();
        String query = "SELECT * FROM emotionRecord";
        try (Connection conn = open(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Diary diary = new Diary();
                diary.setAid(rs.getInt("record_id"));
                diary.setTitle(rs.getString("title"));
                diary.setDate(rs.getDate("date").toString());
                diary.setEmotion(rs.getString("emotion"));
                diary.setContent(rs.getString("content"));
                diaries.add(diary);
            }
        }
        return diaries;
    }

    // READ ONE: 특정 다이어리 조회
    public Diary getDiaryById(int aid) throws SQLException {
        String query = "SELECT * FROM emotionRecord WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, aid);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Diary diary = new Diary();
                diary.setAid(rs.getInt("record_id"));
                diary.setTitle(rs.getString("title"));
                diary.setDate(rs.getDate("date").toString());
                diary.setEmotion(rs.getString("emotion"));
                diary.setContent(rs.getString("content"));
                return diary;
            }
        }
        return null; // 해당 ID의 다이어리가 없으면 null 반환
    }

    // UPDATE: 다이어리 수정
    public void updateDiary(Diary diary) throws SQLException {
        String query = "UPDATE emotionRecord SET title = ?, date = ?, emotion = ?, content = ? WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, diary.getTitle());
            pstmt.setString(2, diary.getDate());
            pstmt.setString(3, diary.getEmotion());
            pstmt.setString(4, diary.getContent());
            pstmt.setInt(5, diary.getAid());
            pstmt.executeUpdate();
        }
    }

    // DELETE: 다이어리 삭제
    public void deleteDiary(int aid) throws SQLException {
        String query = "DELETE FROM emotionRecord WHERE record_id = ?";
        try (Connection conn = open(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, aid);
            pstmt.executeUpdate();
        }
    }
}