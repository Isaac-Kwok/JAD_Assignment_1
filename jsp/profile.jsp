<%@ page import="java.sql.ResultSet"%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="books.Member"%>
<%@ include file="../includes/header.jsp"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<link href="../css/style.css" rel="stylesheet">
<link href="../css/colour.css" rel="stylesheet">
<%
Member member = (Member) session.getAttribute("member");
String avatarImage = (String) session.getAttribute("avatarImage"); // Fetch avatar image from session
String errorMessage = (String) request.getAttribute("error");

//Redirect to login.jsp if member is null
if (member == null) {
	response.sendRedirect("login.jsp");
	return; // Ensure no further processing happens
}
%>

<%-- Show error message if no user is found --%>
<%
System.out.println(avatarImage + " Inside the profile.jsp");
if (errorMessage != null) {
%>
<div class="alert alert-danger">
	<%=errorMessage%>
</div>
<%
}
%>

<div class="container">
	<h2>Profile Information</h2>

	<%-- Centralized avatar image --%>
	<div class="text-center my-4">
		<img src="../images/<%=avatarImage%>" alt="Avatar"
			class="img-thumbnail"
			style="width: 150px; height: 150px; object-fit: cover;" />
	</div>

	<%-- Button to change avatar --%>
	<div class="text-center">
		<button class="btn btn-primary text-black mb-4" data-bs-toggle="modal"
			data-bs-target="#avatarModal">Change Avatar</button>

	</div>

	<%-- Display member details --%>
	<table class="table table-bordered">
		<tr>
			<th>Name</th>
			<td><%=member.getName()%></td>
		</tr>
		<tr>
			<th>Email</th>
			<td><%=member.getEmail()%></td>
		</tr>
		<tr>
			<th>Phone</th>
			<td><%=member.getPhone()%></td>
		</tr>
		<tr>
			<th>Address</th>
			<td><%=member.getAddress()%></td>
		</tr>
		<tr>
			<th>Password</th>
			<td>**********</td>
		</tr>
	</table>

	<h3>Update Information</h3>
	<form action="${pageContext.request.contextPath}/ProfileServlet"
		method="post" onsubmit="return validateForm()">
		<input type="hidden" name="member_id"
			value="<%=member.getMemberId()%>" />
		<div class="form-group">
			<label for="name">Name</label> <input type="text"
				class="form-control" id="name" name="name"
				value="<%=member.getName()%>" />
		</div>
		<div class="form-group">
			<label for="email">Email</label> <input type="email"
				class="form-control" id="email" name="email"
				value="<%=member.getEmail()%>" />
		</div>
		<div class="form-group">
			<label for="phone">Phone</label> <input type="text"
				class="form-control" id="phone" name="phone"
				value="<%=member.getPhone()%>" />
		</div>
		<div class="form-group">
			<label for="address">Address</label> <input type="text"
				class="form-control" id="address" name="address"
				value="<%=member.getAddress()%>" />
		</div>
		<div class="form-group">
			<label for="password">Password (Leave Password and Confirm
				Password Blank if not changing password)</label> <input type="password"
				class="form-control" id="password" name="password" />
		</div>
		<div class="form-group">
			<label for="confirmPassword">Confirm Password</label> <input
				type="password" class="form-control" id="confirmPassword"
				name="confirmPassword" />
		</div>
		<div class="form-group">
			<input type="checkbox" id="showPassword" onclick="togglePassword()">
			Show Password
		</div>
		<button type="submit" class="btn btn-primary text-black mb-4">Update</button>
	</form>
</div>

<!-- Modal for avatar selection -->
<div class="modal fade" id="avatarModal" tabindex="-1" role="dialog"
	aria-labelledby="avatarModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title text-black" id="avatarModalLabel">Choose
					Avatar</h5>
				<button type="button" class="close" onclick="closeAvatarModal()"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<%-- Dynamically load avatars from the database --%>
				<%
				Connection conn = null;
				PreparedStatement pst = null;
				ResultSet rs = null;
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					//String connURL = "jdbc:mysql://localhost:3306/jad_assignment1?user=root&password=subeteoshiete4@&serverTimezone=UTC";
					String connURL = "jdbc:mysql://localhost:3306/cleaning_service?user=root&password=henshin111&serverTimezone=UTC";
					conn = DriverManager.getConnection(connURL);

					String sql = "SELECT avatar_id, image_name FROM avatars";
					pst = conn.prepareStatement(sql);
					rs = pst.executeQuery();

					while (rs.next()) {
				%>
				<div class="avatar-option"
					style="display: inline-block; margin: 5px;">
					<img src="../images/<%=rs.getString("image_name")%>"
						class="img-thumbnail"
						style="width: 100px; height: 100px; object-fit: cover; cursor: pointer;"
						onclick="selectAvatar('<%=rs.getString("image_name")%>')" />
				</div>
				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (rs != null)
				rs.close();
				if (pst != null)
				pst.close();
				if (conn != null)
				conn.close();
				}
				%>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					onclick="closeAvatarModal()">Close</button>
				<button type="button" class="btn btn-primary text-black"
					onclick="saveAvatar()">Save</button>
			</div>
		</div>
	</div>
</div>

<%@ include file="../includes/footer.html"%>

<script>

//Script to close the modal manually
function closeAvatarModal() {
    $('#avatarModal').modal('hide'); // Hide the modal
    $('.modal-backdrop').remove();  // Remove the leftover backdrop
    $('body').removeClass('modal-open'); // Remove the 'modal-open' class from the body
}

// Script for Password
function togglePassword() {
    const passwordField = document.getElementById("password");
    const confirmPasswordField = document.getElementById("confirmPassword");
    const type = passwordField.type === "password" ? "text" : "password";
    passwordField.type = type;
    confirmPasswordField.type = type;
}

function validateForm() {
    const password = document.getElementById("password").value.trim();
    const confirmPassword = document.getElementById("confirmPassword").value.trim();

    // Regex for password validation
    const passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    // If both fields are empty, allow the form to proceed
    if (password === "" && confirmPassword === "") {
        return true;
    }

    // If the fields are not empty, validate the password format
    if (!passwordRegex.test(password)) {
        alert("Password must be at least 8 characters long and include a number, an uppercase letter, a lowercase letter, and a special character.");
        return false;
    }

    // Ensure passwords match
    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return false;
    }

    return true;
}



//Script for Avatar
let selectedAvatar = null; // Keep track of the selected avatar image name

// Highlight the selected avatar and update the selectedAvatar variable
function selectAvatar(avatarName) {
    console.log('Selected Avatar:', avatarName); // Debugging line

    // If the clicked avatar is already the selected one, don't change anything
    if (selectedAvatar === avatarName) {
        console.log('Avatar already selected, no change.');
        return; // Do nothing
    }

    // Update the selectedAvatar variable
    selectedAvatar = avatarName;

    // Debug: Log all avatar images and their current src
    document.querySelectorAll('.avatar-option img').forEach(img => {
        console.log('Image src:', img.src); // Debugging line
    });

    // Remove the 'selected' class and reset the border for all images
    document.querySelectorAll('.avatar-option img').forEach(img => {
        img.classList.remove('selected');
        img.style.border = '2px solid #ddd'; // Default border
    });

    // Try to select the clicked image using a more robust approach
    const selectedImg = Array.from(document.querySelectorAll('.avatar-option img')).find(img => 
        img.src.includes(avatarName)
    );

    if (selectedImg) {
        // Add the 'selected' class and change the border
        selectedImg.classList.add('selected');
        selectedImg.style.border = '5px solid #FFCA45'; // Highlight border
        console.log('Image found and updated:', selectedImg.src); // Debugging line
    } else {
        console.error('Error: Could not find the selected image for avatarName:', avatarName);
    }
}

// Save the selected avatar
function saveAvatar() {
    console.log('Save Avatar called with selected avatar:', selectedAvatar); // Debugging line
    if (selectedAvatar !== null) {
        // Update avatar in the session
        $.post("${pageContext.request.contextPath}/ProfileServlet", 
            { 
                "image_name": selectedAvatar, 
                "member_id": "<%=member.getMemberId()%>"
            }, 
            function(response) {
                console.log('Avatar saved successfully'); // Debugging line
                location.reload(); // Reload the page to reflect the changes
            }).fail(function(xhr, status, error) {
                console.error('Error saving avatar:', error); // Debugging line
                console.error('Status:', status);
                console.error('XHR Response:', xhr.responseText);
            });
        $('#avatarModal').modal('hide'); // Close the modal
    } else {
        console.log('No avatar selected'); // Debugging line
        alert('No avatar selected'); // Error feedback message
    }
}
</script>
