<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/header_public.html"%>
<!-- Include Header -->

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Form</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- Custom CSS for Typing Effect -->
<style>
.typing-effect {
    font-size: 1.5rem;
    font-weight: bold;
    color: #3F0A74;
    white-space: nowrap;
    overflow: hidden;
    border-right: .15em solid #3F0A74;
    animation: caret 0.75s step-end infinite;
}

.background-box {
    background-color: #ffffff;
    border-radius: 15px;
    padding: 20px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    min-height: 4.75rem; /* Fixed height to prevent resizing */
    max-height: 4.75rem; /* Fixed height to prevent resizing */
}

@keyframes caret {
    50% {
        border-color: transparent;
    }
}

@keyframes typing {
    from {
        width: 0;
    }
    to {
        width: 100%;
    }
}

@keyframes deleting {
    from {
        width: 100%;
    }
    to {
        width: 0;
    }
}
</style>
<link href="../css/style.css" rel="stylesheet">
<link href="../css/colour.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <!-- Randomized Welcome Message -->
        <div class="text-center mb-4 background-box">
            <h2 class="typing-effect" id="welcomeMessage"></h2>
        </div>

        <% String errCode = request.getParameter("errCode"); %>
        <% if ("invalidLogin".equals(errCode)) { %>
        <div class="alert alert-danger text-center" role="alert">
            You have entered an invalid ID/Password
        </div>
        <% } %>

        <!-- Login Form -->
        <div class="card p-4 shadow-sm">
            <form action="${pageContext.request.contextPath}/VerifyUserServletAssignment" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" id="email" name="email" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary text-black">Login</button>
                    <button type="reset" class="btn btn-secondary">Reset</button>
                </div>
            </form>
        </div>
    </div>

    <!-- JavaScript for Typing and Deleting Effect -->
    <script>
        const messages = ["Welcome back!", "Ready to book your next service?", "Good to see you again!", "Let's make your home spotless!",
        		"Gotta Sweep Sweep Sweep", "The Galactic Bacteria Empire shall Fall", "Germ Execution: Underway", "Set the dirt Ablaze"];
        let i = 0;
        let currentMessage = 0;
        const typingEffectElement = document.getElementById('welcomeMessage');

        function typeMessage() {
            if (i < messages[currentMessage].length) {
                typingEffectElement.textContent += messages[currentMessage].charAt(i);
                i++;
                setTimeout(typeMessage, 100);
            } else {
                setTimeout(deleteMessage, 200);
            }
        }

        function deleteMessage() {
            if (i > 0) {
                typingEffectElement.textContent = typingEffectElement.textContent.slice(0, -1);
                i--;
                setTimeout(deleteMessage, 50);
            } else {
                currentMessage = (currentMessage + 1) % messages.length;
                setTimeout(typeMessage, 1000);
            }
        }

        typeMessage();
    </script>

    <!-- Bootstrap JS Bundle (with Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
<%@ include file="../includes/footer.html"%>
<!-- Include Footer -->
</html>
