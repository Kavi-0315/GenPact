package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/ChangePasswordServlet")
public class ChangePassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

            String sql = "SELECT password FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                String currentPassword = rs.getString("password");

                if (currentPassword.equals(oldPassword)) {
                    sql = "UPDATE Customer SET password = ? WHERE account_no = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, newPassword);
                    ps.setString(2, accountNo);

                    int updateCount = ps.executeUpdate();
                    if (updateCount > 0) {
                        response.setContentType("text/html");
                        PrintWriter out = response.getWriter();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Password successfully updated!');");
                        out.println("window.location.href='customerDashboard.jsp';");
                        out.println("</script>");
                    } else {
                        response.setContentType("text/html");
                        PrintWriter out = response.getWriter();
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('Failed to update password. Please try again.');");
                        out.println("window.location.href='changePassword.jsp';");
                        out.println("</script>");
                    }
                } else {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('Old password is incorrect.');");
                    out.println("window.location.href='changePassword.jsp';");
                    out.println("</script>");
                }
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Account number not found.');");
                out.println("window.location.href='changePassword.jsp';");
                out.println("</script>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating the password: " + e.getMessage());
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
