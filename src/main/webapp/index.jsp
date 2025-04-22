<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart phone information system</title>
    <!-- Import global styles -->
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: bg-animation 10s infinite alternate;
        }

        @keyframes bg-animation {
            0% {
                background: linear-gradient(135deg, #1e3c72, #2a5298);
            }
            50% {
                background: linear-gradient(135deg, #2a5298, #1e3c72);
            }
            100% {
                background: linear-gradient(135deg, #1e3c72, #2a5298);
            }
        }

        .cover-card {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 40px;
            text-align: center;
            width: 350px;
        }

        h1 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 20px;
        }

        .btn {
            text-decoration: none;
            background: #1e3c72;
            color: #fff;
            padding: 10px 20px;
            margin: 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
            display: inline-block;
        }

        .btn:hover {
            background: #2a5298;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<div class="cover-card">
    <!-- System Name -->
    <h1>Smart phone information system</h1>

    <!-- Login Button -->
    <a class="btn" href="login.jsp">Login</a>
    <!-- Register Button -->
    <a class="btn" href="register.jsp">Register</a>
</div>
</body>
</html>

