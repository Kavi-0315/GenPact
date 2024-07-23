package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterCustomerServlet")
public class RegisterCostumerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobileNo");
        String emailId = request.getParameter("emailId");
        String accountType = request.getParameter("accountType");
        double balance = Double.parseDouble(request.getParameter("balance"));
        String dateOfBirth = request.getParameter("dateOfBirth");
        String idProof = request.getParameter("idProof");
        String tempPassword = generateTempPassword();
        int accountNo = generateAccountNo();

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

            String sql = "INSERT INTO Customer (account_no, full_name, address, mobile_no, email_id, account_type, balance, date_of_birth, id_proof, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, accountNo);
            ps.setString(2, fullName);
            ps.setString(3, address);
            ps.setString(4, mobileNo);
            ps.setString(5, emailId);
            ps.setString(6, accountType);
            ps.setDouble(7, balance);
            ps.setString(8, dateOfBirth);
            ps.setString(9, idProof);
            ps.setString(10, tempPassword);
            ps.executeUpdate();

            response.sendRedirect("registerationSuccess.jsp?accountNo=" + accountNo + "&tempPassword=" + tempPassword);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred during registration: " + e.getMessage());
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String generateTempPassword() {
        Random random = new Random();
        int length = 8;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder tempPassword = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            tempPassword.append(characters.charAt(random.nextInt(characters.length())));
        }
        return tempPassword.toString();
    }

    private int generateAccountNo() {
        Random random = new Random();
        return 10000 + random.nextInt(90000); // Generates a number between 10000 and 99999
    }
}
