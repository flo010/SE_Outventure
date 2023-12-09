package servlets;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hiker;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        FacadeJPA facadeJPA = FacadeJPA.getInstance();

        boolean validHikerCredentials = facadeJPA.checkHikerCredentials(email, password);
        Hiker hiker = facadeJPA.getByEmail(email);

        if (validHikerCredentials) {
            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("hikerID", hiker.getHikerID());
            httpSession.setAttribute("hikerEmail", hiker.getEmail());
            httpSession.setAttribute("hikerUsername", hiker.getUsername());
            response.sendRedirect("/index/index.jsp");
            System.out.println("Login successful");
        } else {
            response.sendRedirect("/login/login.jsp?error=true");
            System.out.println("Login failed");
        }
    }
}
