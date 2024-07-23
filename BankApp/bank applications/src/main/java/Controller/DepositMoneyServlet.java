package Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/DepositMoneyServlet")
public class DepositMoneyServlet extends HttpServlet {
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
        System.out.println("Account Number from session: " + accountNo); // Debugging output
        double amount = Double.parseDouble(request.getParameter("amount"));

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Connect to database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check current balance
            String query = "SELECT balance FROM Customer WHERE account_no = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, accountNo);
            rs = ps.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");

                // Update balance
                double newBalance = currentBalance + amount;
                query = "UPDATE Customer SET balance = ? WHERE account_no = ?";
                ps = conn.prepareStatement(query);
                ps.setDouble(1, newBalance);
                ps.setString(2, accountNo);
                ps.executeUpdate();

                // Insert transaction
                query = "INSERT INTO TransactionHistory (account_no, action, amount, balance_after) VALUES (?, 'deposit', ?, ?)";
                ps = conn.prepareStatement(query);
                ps.setString(1, accountNo);
                ps.setDouble(2, amount);
                ps.setDouble(3, newBalance);
                ps.executeUpdate();

                // Delete oldest transaction if more than 10
                query = "DELETE FROM TransactionHistory WHERE transaction_id NOT IN (SELECT transaction_id FROM (SELECT transaction_id FROM TransactionHistory WHERE account_no = ? ORDER BY date DESC LIMIT 10) temp)";
                ps = conn.prepareStatement(query);
                ps.setString(1, accountNo);
                ps.executeUpdate();

                // Forward to success page with amount and new balance
                request.setAttribute("amount", amount);
                request.setAttribute("balance", newBalance);
                RequestDispatcher dispatcher = request.getRequestDispatcher("depositSuccess.jsp");
                dispatcher.forward(request, response);
                return;
            } else {
                response.setContentType("text/html");
                response.getWriter().println("<script type=\"text/javascript\">");
                response.getWriter().println("alert('Account number not found. Please try again.');");
                response.getWriter().println("window.history.back();");
                response.getWriter().println("</script>");
                return;
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Class not found exception: " + e.getMessage() + "');");
            response.getWriter().println("window.history.back();");
            response.getWriter().println("</script>");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('SQL exception: " + e.getMessage() + "');");
            response.getWriter().println("window.history.back();");
            response.getWriter().println("</script>");
        } catch (ServletException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Servlet exception: " + e.getMessage() + "');");
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

        response.setContentType("text/html");
        response.getWriter().println("<script type=\"text/javascript\">");
        response.getWriter().println("alert('Deposit failed. Please check your account number and try again.');");
        response.getWriter().println("window.history.back();");
        response.getWriter().println("</script>");
    }
}
