<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="outventure" tagdir="/WEB-INF/tags"%>
<html>
  <head>
      <title>Login</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
      <link href="../../css/login.css" rel="stylesheet">
      <link href="../../css/style.css" rel="stylesheet">
  </head>
  <body class="login-overall-background">
    <header>
      <outventure:navbar/>
    </header>
    <div class="container mt-3">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <div class="card">
            <div class="card-header">
              <h3 class="text-center">Login</h3>
            </div>
            <div class="card-body">
              <form action="../../login" method="post">
                <div class="mb-3 position-relative">
                  <label for="email" class="form-label">E-Mail</label>
                  <input type="email" class="form-control bi-person-fill" id="email" placeholder="Enter E-Mail" name="email" required>
                </div>
                <div class="mb-3 position-relative">
                  <label for="password" class="form-label">Password</label>
                  <input type="password" class="form-control bi-lock-fill" id="password" placeholder="Enter password" name="password" required>
                </div>
                <div class="d-grid gap-2">
                  <button type="submit" class="btn btn-success">Login</button>
                </div>
              </form>
            </div>
            <%
              String errorParam = request.getParameter("error");
              if ("true".equals(errorParam)) {
            %>
            <div class="alert alert-danger" role="alert">
              Login failed. Please check your credentials.
            </div>
            <%
              }
            %>
            <div class="card-footer text-center">
              Don't have an account? <a href="#" class="register-link">Register</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="../../global_java_script/navbar.js"></script>
    <script src="../../global_java_script/toasts.js"></script>
  </body>
</html>
