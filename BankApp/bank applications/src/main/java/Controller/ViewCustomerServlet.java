package Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/ViewCustomerServlet")
public class ViewCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/details";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Kavi@1503";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accountNo = request.getParameter("accountNo");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch customer details
            String query = "SELECT * FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Set customer details as request attributes
                request.setAttribute("accountNo", rs.getString("account_no"));
                request.setAttribute("fullName", rs.getString("full_name"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("mobileNo", rs.getString("mobile_no"));
                request.setAttribute("emailId", rs.getString("email_id"));
                request.setAttribute("accountType", rs.getString("account_type"));
                request.setAttribute("balance", rs.getDouble("balance"));
                request.setAttribute("dateOfBirth", rs.getString("date_of_birth"));
                request.setAttribute("idProof", rs.getString("id_proof"));

                // Forward to the view customer success page
                RequestDispatcher dispatcher = request.getRequestDispatcher("viewSuccess.jsp");
                dispatcher.forward(request, response);
            } else {
                // Handle case where account number is not found
                response.setContentType("text/html");
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Account number not found. Please try again.');");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("</script>");
            }
        } catch (ClassNotFoundException | SQLException | ServletException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('An error occurred while processing your request. Please try again later.');");
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
