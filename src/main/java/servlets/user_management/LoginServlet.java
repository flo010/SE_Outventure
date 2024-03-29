package servlets.user_management;

import hibernate.facade.FacadeJPA;
import hibernate.model.Hiker;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    public static FacadeJPA facadeJPA = FacadeJPA.getInstance();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean validHikerCredentials = facadeJPA.checkHikerCredentials(email, password);
        Hiker hiker = facadeJPA.getHikerByEmail(email);

        if (validHikerCredentials) {
            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("hikerID", hiker.getHikerID());
            httpSession.setAttribute("hikerEmail", hiker.getEmail());
            httpSession.setAttribute("hikerUsername", hiker.getUsername());

            response.sendRedirect("/hike/index/index.jsp");
            System.out.println("Login successful");
        } else {
            response.sendRedirect("/user_management/login/login.jsp?error=true");
            System.out.println("Login failed");
        }
    }
}
