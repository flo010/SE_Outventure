<%--
  Created by IntelliJ IDEA.
  User: Betül Kulac
  Date: 01.12.23
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
      <title>Login</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
      <link href="../css/login.css" rel="stylesheet">
  </head>
  <body class="login-background">
    <div class="container mt-3">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <div class="card">
            <div class="card-header">
              <h3 class="text-center">Login</h3>
            </div>
            <div class="card-body">
              <form action="login" method="post">
                <div class="mb-3 position-relative">
                  <label for="email" class="form-label">E-Mail</label>
                  <input type="email" class="form-control bi-person-fill" id="email" placeholder="Enter E-Mail" required>
                </div>
                <div class="mb-3 position-relative">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control bi-lock-fill" id="password" placeholder="Enter password" required>
                </div>
                <div class="d-grid gap-2">
                  <button type="submit" class="btn btn-primary">Login</button>
                </div>
              </form>
            </div>
            <div class="card-footer text-center">
              Don't have an account? <a href="#">Register</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
