package com.rutong.framework.security.service;

import com.rutong.business.system.entity.SysUser;
import com.rutong.framework.exception.user.UserPasswordNotMatchException;
import com.rutong.framework.security.SecurityUtils;
import com.rutong.framework.security.context.AuthenticationContextHolder;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
public class PasswordService {

    public void validate(SysUser user) {
        Authentication usernamePasswordAuthenticationToken = AuthenticationContextHolder.getContext();
        String password = usernamePasswordAuthenticationToken.getCredentials().toString();
        if (!matches(user, password)) {
            throw new UserPasswordNotMatchException();
        }
    }

    public boolean matches(SysUser user, String rawPassword) {
        return SecurityUtils.matchesPassword(rawPassword, user.getPassword());
    }
}
