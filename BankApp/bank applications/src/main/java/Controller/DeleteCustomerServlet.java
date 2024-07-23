package Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/details";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Kavi@1503";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountNo") == null) {
            response.sendRedirect("customerLogin.jsp");
            return;
        }

        String accountNo = (String) session.getAttribute("accountNo");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Verify account balance
            String query = "SELECT balance FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");

                if (balance != 0) {
                    response.setContentType("text/html");
                    response.getWriter().println("<script type=\"text/javascript\">");
                    response.getWriter().println("alert('Account balance must be zero to delete the account.');");
                    response.getWriter().println("window.history.back();");
                    response.getWriter().println("</script>");
                    return;
                }

                // Delete customer account
                query = "DELETE FROM Customer WHERE account_no = ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, accountNo);
                ps.executeUpdate();

                // Invalidate session
                session.invalidate();

                // Show alert message and redirect to index page
                response.setContentType("text/html");
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Account deleted successfully.');");
                response.getWriter().println("window.location.href = 'adminDashboard.jsp';");
                response.getWriter().println("</script>");
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Account number not found. Please try again.');");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("</script>");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('An error occurred while processing your request: " + e.getMessage() + "');");
            response.getWriter().println("window.history.back();");
            response.getWriter().println("</script>");
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
