<!DOCTYPE html>
<html>
<head>
    <title>Register Customer</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Register New Customer</h1>
    <form action="RegisterCustomerServlet" method="post">
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" required><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>
        <label for="mobileNo">Mobile No:</label>
        <input type="text" id="mobileNo" name="mobileNo" required><br>
        <label for="emailId">Email ID:</label>
        <input type="email" id="emailId" name="emailId" required><br>
        <label for="accountType">Account Type:</label>
        <select id="accountType" name="accountType" required>
            <option value="Saving">Saving Account</option>
            <option value="Current">Current Account</option>
        </select><br>
        <label for="initialBalance">Initial Balance:</label>
        <input type="number" id="initialBalance" name="initialBalance" min="1000" required><br>
        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required><br>
        <label for="idProof">ID Proof:</label>
        <input type="text" id="idProof" name="idProof" required><br>
        <button type="submit">Register Customer</button>
    </form>
</body>
</html>

