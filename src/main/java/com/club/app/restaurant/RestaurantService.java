package com.club.app.restaurant;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.S3Service;
import com.club.app.pager.Pager;
import com.club.app.restaurant.file.RestaurantFileDTO;
import com.club.app.restaurant.like.RestaurantLikeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestaurantService {

	private final S3Service s3Service;
	private final RestaurantMapper restaurantMapper;

	public int add(RestaurantDTO restaurantDTO, MultipartFile[] files) throws Exception {

		int result = restaurantMapper.add(restaurantDTO);

		if (files != null) {
			for (MultipartFile file : files) {
				if (file == null || file.isEmpty()) {
					continue;
				}

				String fileName = s3Service.upload(file, "restaurant");

				RestaurantFileDTO restaurantFileDTO = new RestaurantFileDTO();
				restaurantFileDTO.setRestaurantNum(restaurantDTO.getRestaurantNum());
				restaurantFileDTO.setFileName(fileName);
				restaurantFileDTO.setOriName(file.getOriginalFilename());

				restaurantMapper.addFile(restaurantFileDTO);
			}
		}

		return result;
	}

	public List<RestaurantDTO> list(Pager pager) throws Exception {

		Long totalCount = restaurantMapper.getCount(pager);

		pager.makePageNum(totalCount);
		pager.makeStartNum();

		return restaurantMapper.list(pager);
	}

	public RestaurantDTO detail(RestaurantDTO restaurantDTO) throws Exception {

		restaurantMapper.updateHit(restaurantDTO);

		return restaurantMapper.detail(restaurantDTO);
	}

	public int like(RestaurantLikeDTO restaurantLikeDTO) throws Exception {

		int check = restaurantMapper.checkLike(restaurantLikeDTO);

		if (check > 0) {
			return restaurantMapper.deleteLike(restaurantLikeDTO);
		}

		return restaurantMapper.addLike(restaurantLikeDTO);
	}

	public int checkLike(RestaurantLikeDTO restaurantLikeDTO) throws Exception {
		return restaurantMapper.checkLike(restaurantLikeDTO);
	}

	public Long getLikeCount(RestaurantDTO restaurantDTO) throws Exception {
		return restaurantMapper.getLikeCount(restaurantDTO);
	}

	public List<RestaurantDTO> popularList() throws Exception {
		return restaurantMapper.popularList();
	}

	public int update(RestaurantDTO restaurantDTO, MultipartFile[] files, List<Long> deleteFileNums) throws Exception {

		if (deleteFileNums != null) {
			for (Long fileNum : deleteFileNums) {
				RestaurantFileDTO restaurantFileDTO = new RestaurantFileDTO();
				restaurantFileDTO.setFileNum(fileNum);

				this.deleteFile(restaurantFileDTO);
			}
		}

		int result = restaurantMapper.update(restaurantDTO);

		if (files != null) {
			for (MultipartFile multipartFile : files) {
				if (multipartFile == null || multipartFile.isEmpty()) {
					continue;
				}

				String fileName = s3Service.upload(multipartFile, "restaurant");

				RestaurantFileDTO restaurantFileDTO = new RestaurantFileDTO();
				restaurantFileDTO.setRestaurantNum(restaurantDTO.getRestaurantNum());
				restaurantFileDTO.setFileName(fileName);
				restaurantFileDTO.setOriName(multipartFile.getOriginalFilename());

				restaurantMapper.addFile(restaurantFileDTO);
			}
		}

		return result;
	}

	public int delete(RestaurantDTO restaurantDTO) throws Exception {
		// S3 파일 삭제를 위해 상세 정보 가져오기
		RestaurantDTO detail = restaurantMapper.detail(restaurantDTO);
		if(detail != null && detail.getFileDTOs() != null){
			for(RestaurantFileDTO file : detail.getFileDTOs()){
				s3Service.delete(file.getFileName());
			}
		}
		return restaurantMapper.delete(restaurantDTO);
	}

	public int deleteFile(RestaurantFileDTO restaurantFileDTO) throws Exception {
		RestaurantFileDTO fileDTO = restaurantMapper.fileDetail(restaurantFileDTO);
		if (fileDTO == null) {
			return 0;
		}

		s3Service.delete(fileDTO.getFileName());

		return restaurantMapper.deleteFile(restaurantFileDTO);
	}

	public RestaurantDTO getReviewSummary(RestaurantDTO restaurantDTO) throws Exception {
		return restaurantMapper.getReviewSummary(restaurantDTO);
	}

}