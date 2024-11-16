<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Register</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
    body {
        font-family: 'Nunito', sans-serif;
        background-color: #F2F2F2;
        margin: 0;
        padding: 0;
    }

    .form-bg {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #F2F2F2;
    }

    .form-container {
        background: #ecf0f3;
        padding: 20px;
        border-radius: 20px;
        box-shadow: 14px 14px 20px #cbced1, -14px -14px 20px white;
    }

    .form-icon {
        color: #ac40ab;
        font-size: 55px;
        text-align: center;
        line-height: 100px;
        width: 100px;
        height: 100px;
        margin: 0 auto 15px;
        border-radius: 50px;
        box-shadow: 7px 7px 10px #cbced1, -7px -7px 10px #fff;
    }

    .title {
        color: #ac40ab;
        font-size: 25px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        text-align: center;
        margin-bottom: 20px;
    }

    .form-horizontal .form-group {
        margin-bottom: 25px;
    }

    .form-horizontal .form-group label {
        font-size: 15px;
        font-weight: 600;
        text-transform: uppercase;
    }

    .form-horizontal .form-control {
        color: #333;
        background: #ecf0f3;
        font-size: 12px;
        height: 40px;
        padding: 12px;
        border: none;
        border-radius: 50px;
        box-shadow: inset 6px 6px 6px #cbced1, inset -6px -6px 6px #fff;
        display: inline-block;
        transition: all 0.3s ease 0s;
    }

    .form-horizontal .form-control:focus {
        box-shadow: inset 6px 6px 6px #cbced1, inset -6px -6px 6px #fff;
        outline: none;
    }

    .form-horizontal .btn {
        color: #000;
        background-color: #ac40ab;
        font-size: 15px;
        font-weight: bold;
        text-transform: uppercase;
        width: 100%;
        padding: 12px 15px 11px;
        border-radius: 20px;
        box-shadow: 6px 6px 6px #cbced1, -6px -6px 6px #fff;
        border: none;
        transition: all 0.5s ease 0s;
    }

    .form-horizontal .btn:hover {
        color: #fff;
        letter-spacing: 3px;
    }

    .form-horizontal .form-control::placeholder {
        color: #808080;
        font-size: 14px;
    }

    .form-horizontal .form-control:hover {
        background-color: #ffffff;
    }

    .text-center {
        color: red;
    }
</style>
</head>
<body>

	<%
	String message = request.getParameter("message");
	%>

    <div class="form-bg">
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="form-container">
                        <div class="form-icon">
                            <i class="fa fa-user-plus"></i>
                        </div>
                        <h3 class="title">Register</h3>
                       <%
                        if (message != null) {
                        %>
                        <p class="text-center">
                            <%=message%>
                        </p>
                        <%
                        }
                        %>
                        <form action="./RegisterSrv" method="post" class="form-horizontal">
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label for="first_name">Name</label>
                                    <input type="text" name="username" class="form-control" placeholder="Enter Name" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label for="email">Email</label>
                                    <input type="email" name="email" class="form-control" placeholder="Enter Email" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="address">Address</label>
                                <textarea name="address" class="form-control" placeholder="Enter Address" required></textarea>
                            </div>

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label for="mobile">Mobile</label>
                                    <input type="number" name="mobile" class="form-control" placeholder="Enter Mobile" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label for="pincode">Pin Code</label>
                                    <input type="number" name="pincode" class="form-control" placeholder="Enter Pin Code" required>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label for="password">Password</label>
                                    <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label for="confirmPassword">Confirm Password</label>
                                    <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
                                </div>
                            </div>

                            <div class="row text-center">
                                <div class="col-md-6">
                                    <button type="reset" class="btn btn-danger">Reset</button>
                                </div>
                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-default">Register</button>
                                </div>
                            </div>
                        </form>
                         <p style="text-align: center; margin-top: 10px;">
                            Already have an account? 
                            <a href="login.jsp" style="color: #ac40ab; font-weight: bold;">Login here</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
