package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewAccountDetailsServlet")
public class AccountDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNoStr = request.getParameter("accountNo");
        int accountNo = Integer.parseInt(accountNoStr);

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

            String sql = "SELECT full_name, address, mobile_no, email_id, account_type, date_of_birth, id_proof, balance FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Retrieve data from ResultSet
                String fullName = rs.getString("full_name");
                String address = rs.getString("address");
                String mobileNo = rs.getString("mobile_no");
                String email = rs.getString("email_id");
                String accountType = rs.getString("account_type");
                String dateOfBirth = rs.getString("date_of_birth");
                String idProof = rs.getString("id_proof");
                double balance = rs.getDouble("balance");

                // Set attributes to forward to viewAccountDetails.jsp
                request.setAttribute("accountNo", accountNo);
                request.setAttribute("fullName", fullName);
                request.setAttribute("address", address);
                request.setAttribute("email", email);
                request.setAttribute("accountType", accountType);
                request.setAttribute("dateOfBirth", dateOfBirth);
                request.setAttribute("idProof", idProof);
                request.setAttribute("balance", balance);

                // Forward to viewAccountDetails.jsp for displaying details
                request.getRequestDispatcher("viewAccountDetails.jsp").forward(request, response);
            } else {
                // If no customer found, redirect back with an alert
                response.setContentType("text/html");
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('No customer found with this account number.');");
                response.getWriter().println("window.location.href='dashboard.jsp';");
                response.getWriter().println("</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving customer details: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
