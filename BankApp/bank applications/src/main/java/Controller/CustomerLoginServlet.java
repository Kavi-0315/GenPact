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

@WebServlet("/CustomerLoginServlet")
public class CustomerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String accountNo = request.getParameter("accountNo");
        String password = request.getParameter("password");

        if (isValidUser(accountNo, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("accountNo", accountNo);
            System.out.println("Account Number stored in session: " + accountNo);
            response.sendRedirect("customerDashboard.jsp");
        } else {
            response.sendRedirect("customerLogin.jsp");
        }
    }

    private boolean isValidUser(String accountNo, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        boolean isValid = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/details", "root", "Kavi@1503");

            String sql = "SELECT * FROM Customer WHERE account_no = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, accountNo);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                isValid = true;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isValid;
    }
}
