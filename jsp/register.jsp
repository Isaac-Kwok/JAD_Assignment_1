<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Custom CSS -->
    <link href="../css/style.css" rel="stylesheet">
    <link href="../css/colour.css" rel="stylesheet">
    
    <script>
        // Validate Password Function
        function validatePassword() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const passwordPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
            
            if (!passwordPattern.test(password)) {
                alert('Password must be at least 8 characters long and include at least one uppercase letter, one lowercase letter, one number, and one special character.');
                return false;
            }
            
            if (password !== confirmPassword) {
                alert('Passwords do not match.');
                return false;
            }
            return true;
        }
        
        // Toggle Password Visibility
        function togglePasswordVisibility() {
            const passwordField = document.getElementById('password');
            const confirmPasswordField = document.getElementById('confirmPassword');
            const toggleButton = document.getElementById('togglePassword');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                confirmPasswordField.type = 'text';
                toggleButton.textContent = 'Hide';
            } else {
                passwordField.type = 'password';
                confirmPasswordField.type = 'password';
                toggleButton.textContent = 'Show';
            }
        }

        // Show Alert for Duplicate Email
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <!-- Alert for Duplicate Email -->
    <%
        String errCode = request.getParameter("errCode");
        if ("duplicateEmail".equals(errCode)) {
    %>
        <script>
            showAlert('Cannot register. Email is already registered!');
        </script>
    <%
        }
    %>

    <div class="container mt-5">
        <h2>Registration Form</h2>
        <form action="${pageContext.request.contextPath}/RegisterUserServlet" method="post" onsubmit="return validatePassword()">
            <div class="mb-3">
                <label for="loginid" class="form-label">Username:</label>
                <input type="text" id="loginid" name="loginid" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required>
            </div>
            <button type="button" id="togglePassword" class="btn btn-outline-secondary mb-3" onclick="togglePasswordVisibility()">Show</button>
            <div>
                <input type="submit" value="Register" class="btn btn-primary text-black">
                <input type="reset" value="Reset" class="btn btn-secondary">
            </div>
        </form>
    </div>

    <!-- Bootstrap JS Bundle (with Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<%@ include file="../includes/footer.html"%>
</html>
