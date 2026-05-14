package com.club.app.member;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
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
	@NotBlank(message = "이름을 입력하세요")
	private String memberName;
	@NotBlank(message = "이메일을 입력하세요")
	private String memberEmail;
	@NotBlank(message = "전화번호를 입력하세요")
	@Pattern(regexp = "^01[016789]-\\d{3,4}-\\d{4}$", message = "전화번호 형식이 올바르지 않습니다")
	private String memberPhone;
	@NotNull(message = "생년월일을 입력하세요")
	private LocalDate memberBirth;
	private Long roleNum;
	@NotBlank(message = "아이디를 입력하세요")
	@Pattern(regexp = "^[a-zA-Z0-9]+$", message = "영어와 숫자만 가능합니다")
	private String memberId;
	@NotBlank(message = "비밀번호를 입력하세요")
//	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])$", message = "비밀번호 형식이 올바르지 않습니다")
	private String memberPw;

	private MemberProfileDTO profile;
	private List<RoleDTO> roles;
}
