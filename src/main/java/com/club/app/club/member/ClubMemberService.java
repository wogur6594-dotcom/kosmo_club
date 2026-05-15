package com.club.app.club.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.club.app.notification.NotificationDTO;
import com.club.app.notification.NotificationService;

@Service
public class ClubMemberService {

	@Autowired
	private ClubMemberMapper clubMemberMapper;

	@Autowired
	private NotificationService notificationService;

	public int join(ClubMemberDTO clubMemberDTO) throws Exception {

		int check = clubMemberMapper.checkJoin(clubMemberDTO);

		if (check > 0) {
			return 0;
		}

		Long currentMember = clubMemberMapper.getCurrentMember(clubMemberDTO.getClubNum());
		Long clubMax = clubMemberMapper.getClubMax(clubMemberDTO.getClubNum());

		if (currentMember >= clubMax) {
			return -1;
		}

		int result = clubMemberMapper.join(clubMemberDTO);

		if (result > 0) {

			Long ownerMemberNum = clubMemberMapper.getClubOwnerMemberNum(clubMemberDTO.getClubNum());

			String clubName = clubMemberMapper.getClubName(clubMemberDTO.getClubNum());

			if (ownerMemberNum != null && !ownerMemberNum.equals(clubMemberDTO.getMemberNum())) {

				NotificationDTO notificationDTO = new NotificationDTO();

				notificationDTO.setMemberNum(ownerMemberNum);
				notificationDTO.setNotificationContents("[" + clubName + "] 동호회에 새 회원이 가입했습니다.");
				notificationDTO.setNotificationUrl("/club/detail?clubNum=" + clubMemberDTO.getClubNum());

				notificationService.add(notificationDTO);

			}

		}

		return result;
	}

	public int checkJoin(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.checkJoin(clubMemberDTO);
	}

	public int checkApprovedMember(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.checkApprovedMember(clubMemberDTO);
	}

}