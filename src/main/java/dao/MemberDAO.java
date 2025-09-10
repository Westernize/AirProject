package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import servlet.Member;
import util.DBUtil;

public class MemberDAO {
    
    // 회원 가입 메소드
    public void insertMember(String userid, String pwd, String name, String phone, String email) {
        String sql = "INSERT INTO Member(userid, pwd, name, phone, email) VALUES(?, ?, ?, ?, ?)";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userid);
            pstmt.setString(2, pwd);
            pstmt.setString(3, name);
            pstmt.setString(4, phone);
            pstmt.setString(5, email);
            
            int result = pstmt.executeUpdate();
            
            if(result > 0) {
                System.out.println("회원 가입 성공!");
            } else {
                System.out.println("회원 가입 실패!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 로그인 체크 메서드
    public boolean login(String userid, String pwd) {
        String sql = "SELECT COUNT(*) FROM Member WHERE userid=? AND pwd=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userid);
            pstmt.setString(2, pwd);

            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // 1 이상이면 로그인 성공
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // userid로 회원 정보 조회 메서드 (필수!)
    public Member getMember(String userid) {
        String sql = "SELECT userid, pwd, name, phone, email FROM Member WHERE userid = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Member member = new Member();
                member.setUserid(rs.getString("userid"));
                member.setPwd(rs.getString("pwd"));
                member.setName(rs.getString("name"));
                member.setPhone(rs.getString("phone"));
                member.setEmail(rs.getString("email"));
                return member;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 기존 회원정보 수정 메서드 (필드별)
    public boolean updateMember(String userid, String pwd, String name, String phone, String email) {
        String sql;
        boolean isPwdChange = (pwd != null && !pwd.trim().isEmpty());

        if (isPwdChange) {
            sql = "UPDATE Member SET pwd=?, name=?, phone=?, email=? WHERE userid=?";
        } else {
            sql = "UPDATE Member SET name=?, phone=?, email=? WHERE userid=?";
        }

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            if (isPwdChange) {
                pstmt.setString(1, pwd);
                pstmt.setString(2, name);
                pstmt.setString(3, phone);
                pstmt.setString(4, email);
                pstmt.setString(5, userid);
            } else {
                pstmt.setString(1, name);
                pstmt.setString(2, phone);
                pstmt.setString(3, email);
                pstmt.setString(4, userid);
            }

            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // **여기에 새로 추가하는 updateMember(Member member) 메서드**
    public boolean updateMember(Member member) {
        return updateMember(
            member.getUserid(),
            member.getPwd(),
            member.getName(),
            member.getPhone(),
            member.getEmail()
        );
    }

    // 회원 탈퇴 메서드
    public boolean deleteMember(String userid) {
        String sql = "DELETE FROM Member WHERE userid=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, userid);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // userid로 이름만 조회하는 메서드 추가
    public String getNameByUserId(String userid) {
        String sql = "SELECT name FROM Member WHERE userid = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    // 전체 회원 수 조회
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM Member";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
             if (rs.next()) {
                 return rs.getInt(1);
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
         return 0;
    }
    
    // 전체 예약 수 조회
    public int countReservations() {
        String sql = "SELECT COUNT(*) FROM Reservation";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
             
             if (rs.next()) {
                 return rs.getInt(1);
             }
         } catch (Exception e) {
             e.printStackTrace();
         }
         return 0;
    }
}
