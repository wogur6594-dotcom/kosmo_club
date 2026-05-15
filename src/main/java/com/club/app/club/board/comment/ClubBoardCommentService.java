package com.club.app.club.board.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.club.app.club.board.ClubBoardMapper;
import com.club.app.notification.NotificationDTO;
import com.club.app.notification.NotificationService;

@Service
public class ClubBoardCommentService {

	@Autowired
	private ClubBoardCommentMapper clubBoardCommentMapper;

	@Autowired
	private ClubBoardMapper clubBoardMapper;

	@Autowired
	private NotificationService notificationService;

	public List<ClubBoardCommentDTO> list(Long boardNum) throws Exception {

		return clubBoardCommentMapper.list(boardNum);

	}

	public int add(ClubBoardCommentDTO clubBoardCommentDTO, Long clubNum) throws Exception {

		int result = clubBoardCommentMapper.add(clubBoardCommentDTO);

		if (result > 0) {

			Long writerMemberNum = clubBoardMapper.getWriterMemberNum(clubBoardCommentDTO.getBoardNum());

			if (writerMemberNum != null && !writerMemberNum.equals(clubBoardCommentDTO.getMemberNum())) {

				NotificationDTO notificationDTO = new NotificationDTO();

				notificationDTO.setMemberNum(writerMemberNum);
				notificationDTO.setNotificationContents("내 게시글에 새 댓글이 달렸습니다.");
				notificationDTO.setNotificationUrl(
						"/clubboard/detail?boardNum=" + clubBoardCommentDTO.getBoardNum() + "&clubNum=" + clubNum);

				notificationService.add(notificationDTO);
			}
		}

		return result;

	}

	public int delete(Long commentNum) throws Exception {

		return clubBoardCommentMapper.delete(commentNum);

	}

}