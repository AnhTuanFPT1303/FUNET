package filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionCheckFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        String googleURI = "/GoogleValidate";
        String loginURI = "/login";
        String homepageURI = "/home";
        String signupURI = "/signup";
        String gLoginSubmit = "/login-submit";
        String forgotPassword = "/forgotPassword";
        String verify = "/verify";
        String dashBoard = "/dashBoard";
        String contextPath = httpRequest.getContextPath();

        boolean isDashBoard = httpRequest.getRequestURI().endsWith(dashBoard);
        boolean isVerify = httpRequest.getRequestURI().endsWith(verify);
        boolean isResourceRequest = httpRequest.getRequestURI().startsWith(contextPath + "/assets/");
        boolean isLoginRequest = httpRequest.getRequestURI().endsWith(loginURI);
        boolean isSignupRequest = httpRequest.getRequestURI().endsWith(signupURI);
        boolean isGLoginRequest = httpRequest.getRequestURI().endsWith(googleURI);
        boolean isGLoginSubmit = httpRequest.getRequestURI().endsWith(gLoginSubmit);
        boolean isForgotPassword = httpRequest.getRequestURI().endsWith(forgotPassword);
        
        if (session != null && session.getAttribute("user") != null) {
            // User is logged in
            if (isLoginRequest || isSignupRequest || isGLoginRequest || isGLoginSubmit || isForgotPassword)  {
                // Redirect to homepage if trying to access login or signup page
                httpResponse.sendRedirect(contextPath + homepageURI);
            } else {
                // Allow access to other pages
                chain.doFilter(request, response);
            }
        } else {
            // User is not logged in
            if (isDashBoard || isLoginRequest || isSignupRequest || isGLoginRequest || isGLoginSubmit || isResourceRequest || isForgotPassword || isVerify) {
                // Allow access to login, register page
                chain.doFilter(request, response);
            } else {
                // Redirect to login page for all other requests
                httpResponse.sendRedirect(contextPath + loginURI);
            }
        }
    }

    @Override
    public void destroy() {
    }
}
