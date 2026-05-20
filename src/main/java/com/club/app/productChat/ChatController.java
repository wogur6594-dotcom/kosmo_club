package com.club.app.productChat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.club.app.member.MemberDTO;
import com.club.app.product.ProductDTO;
import com.club.app.product.ProductService;

@Controller
@RequestMapping("/productChat/*")
public class ChatController {

	@Autowired
	private ChatService chatService;

	@Autowired
	private ProductService productService;
	
	@Autowired
	private com.club.app.file.FileManager fileManager;

	// 채팅방 생성
	@GetMapping("create")
	public String create(ProductDTO productDTO, Authentication auth) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		ProductDTO product = productService.detail(productDTO);

		Long buyerNum = loginUser.getMemberNum();

		Long sellerNum = product.getMemberNum();

		// 자기 상품 채팅 방지
		if (buyerNum.equals(sellerNum)) {

			return "redirect:/product/detail?productNum=" + productDTO.getProductNum();
		}

		ChatRoomDTO dto = new ChatRoomDTO();

		dto.setProductNum(productDTO.getProductNum());

		dto.setBuyerNum(buyerNum);

		dto.setSellerNum(sellerNum);

		ChatRoomDTO room = chatService.findRoom(dto);

		// 채팅방 없으면 생성
		if (room == null) {

			room = chatService.createRoom(dto);
		}

		return "redirect:/productChat/detail?chatroomNum=" + room.getChatroomNum();
	}

	// 내 채팅 목록
	@GetMapping("list")
	public String list(Authentication auth, Model model) throws Exception {

		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		List<ChatRoomDTO> list = chatService.list(loginUser.getMemberNum());

		model.addAttribute("list", list);

		return "productChat/list";
	}

	// 채팅방 상세
	@GetMapping("detail")
	public String detail(@RequestParam("chatroomNum") Long chatroomNum, Model model, Authentication auth,
			RedirectAttributes rttr) throws Exception {

		ChatRoomDTO room = chatService.findById(chatroomNum);

		if (room == null) {
			rttr.addFlashAttribute("msg", "삭제된 채팅방입니다.");
			return "redirect:/productChat/list";
		}

		// 메시지 목록
		List<ChatMessageDTO> messages = chatService.messageList(chatroomNum);

		// 로그인 유저
		MemberDTO loginUser = (MemberDTO) auth.getPrincipal();

		// 상품 정보
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProductNum(room.getProductNum());
		ProductDTO product = productService.detail(productDTO);

		model.addAttribute("messages", messages);
		model.addAttribute("chatroomNum", chatroomNum);
		model.addAttribute("loginUser", loginUser);

		// 🔥 핵심
		model.addAttribute("product", product);

		return "productChat/detail";
	}

	@GetMapping("delete")
	public String delete(@RequestParam("chatroomNum") Long chatroomNum, RedirectAttributes rttr) throws Exception {

		ChatRoomDTO room = chatService.findById(chatroomNum);

		if (room == null) {
			rttr.addFlashAttribute("msg", "이미 삭제된 채팅방입니다.");
			return "redirect:/productChat/list";
		}

		// 🔥 상품 정보 따로 조회 (핵심)
		ProductDTO productDTO = new ProductDTO();
		productDTO.setProductNum(room.getProductNum());
		ProductDTO product = productService.detail(productDTO);

		// 삭제 실행
		chatService.deleteChatRoom(chatroomNum);

		// 🔥 메시지 생성 (상품명 사용)
		String msg = product.getProductTitle() + " 채팅방이 삭제되었습니다.";

		rttr.addFlashAttribute("msg", msg);

		return "redirect:/productChat/list";
	}

	// 사진 업로드
	@org.springframework.web.bind.annotation.PostMapping("uploadImage")
	@org.springframework.web.bind.annotation.ResponseBody
	public String uploadImage(@RequestParam("file") org.springframework.web.multipart.MultipartFile file)
			throws Exception {
		return fileManager.fileSave("chat", file);
	}

	// 거래 상태 변경
	@org.springframework.web.bind.annotation.PostMapping("updateStatus")
	@org.springframework.web.bind.annotation.ResponseBody
	public String updateStatus(ProductDTO productDTO) throws Exception {
		int result = productService.edit(productDTO);
		return result > 0 ? "success" : "fail";
	}
}
