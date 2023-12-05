package servlets;

import hibernate.facade.FacadeJPA;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        FacadeJPA facadeJPA = FacadeJPA.getInstance();

        boolean validHikerCredentials = facadeJPA.checkHikerCredentials(email, password);
        if(validHikerCredentials){
            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("loggedInUser", email);
            response.sendRedirect("index.jsp");
            System.out.println("Valid email and password");
        } else {
            response.sendRedirect("login.jsp?error=true");
            System.out.println("Invalid email and password");
        }
    }
}
