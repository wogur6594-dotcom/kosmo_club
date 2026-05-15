package com.club.app.club.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
				notificationDTO.setNotificationContents("[" + clubName + "] 동호회에 새 가입 신청이 있습니다.");
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

	public List<ClubMemberDTO> waitList(Long clubNum) throws Exception {
		return clubMemberMapper.waitList(clubNum);
	}

	public int approve(ClubMemberDTO clubMemberDTO) throws Exception {

		int result = clubMemberMapper.approve(clubMemberDTO);

		if (result > 0) {

			String clubName = clubMemberMapper.getClubName(clubMemberDTO.getClubNum());

			NotificationDTO notificationDTO = new NotificationDTO();

			notificationDTO.setMemberNum(clubMemberDTO.getMemberNum());

			notificationDTO.setNotificationContents("[" + clubName + "] 동호회 가입이 승인되었습니다.");

			notificationDTO.setNotificationUrl("/club/detail?clubNum=" + clubMemberDTO.getClubNum());

			notificationService.add(notificationDTO);

		}

		return result;
	}

	public int checkWaitingMember(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.checkWaitingMember(clubMemberDTO);
	}

	public Long getRoleNum(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.getRoleNum(clubMemberDTO);
	}

	public int kickMember(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.kickMember(clubMemberDTO);
	}

	public List<ClubMemberDTO> memberList(Long clubNum) throws Exception {
		return clubMemberMapper.memberList(clubNum);
	}

	public int leave(ClubMemberDTO clubMemberDTO) throws Exception {
		return clubMemberMapper.leave(clubMemberDTO);
	}

	@Transactional
	public void delegateOwner(ClubMemberDTO clubMemberDTO) throws Exception {

		clubMemberMapper.downgradeOwner(clubMemberDTO);

		clubMemberMapper.delegateOwnerToMember(clubMemberDTO);

	}

}