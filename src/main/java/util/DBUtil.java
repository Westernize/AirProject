package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Oracle JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // DB 연결 (본인 환경에 맞게 수정)
            String url = "jdbc:oracle:thin:@localhost:1521:xe"; // xe는 Oracle DB 기본 SID
            String user = "scott";   // 사용자 계정
            String password = "tiger"; // 비밀번호
            
            conn = DriverManager.getConnection(url, user, password);
            System.out.println("DB 연결 성공!");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
