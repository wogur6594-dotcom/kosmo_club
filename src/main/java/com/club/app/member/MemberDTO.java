package com.club.app.member;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO implements UserDetails {
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> ar = new ArrayList<>();
		for (RoleDTO roleDTO : roles) {
			GrantedAuthority g = new SimpleGrantedAuthority(roleDTO.getRoleName());
			ar.add(g);
			System.out.println(roles);
		}
			return ar;
	}
	
	private boolean accountNonExpired;
	private boolean accountNonLocked;
	private boolean credentialsNonExpired;
	private boolean enabled;
	
	@Override
	public String getUsername() {
	    return this.memberId;
	}

	@Override
	public String getPassword() {
	    return this.memberPw;
	}
	
	
	private Long memberNum;
	private String memberName;
	private String memberEmail;
	private String memberPhone;
	private LocalDate memberBirth;
	private Long roleNum;
	private String memberId;
	private String memberPw;
	
	private MemberProfileDTO profile;
	private List<RoleDTO> roles;
}
