package com.club.app.restaurant;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.club.app.file.FileManager;
import com.club.app.pager.Pager;
import com.club.app.restaurant.file.RestaurantFileDTO;
import com.club.app.restaurant.like.RestaurantLikeDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestaurantService {

	private final FileManager fileManager;
	private final RestaurantMapper restaurantMapper;

	@Value("${app.upload.restaurant}")
	private String uploadPath;

	public int add(RestaurantDTO restaurantDTO, MultipartFile[] files) throws Exception {

		int result = restaurantMapper.add(restaurantDTO);

		if (files != null) {

			File folder = new File(uploadPath);

			if (!folder.exists()) {
				folder.mkdirs();
			}

			for (MultipartFile file : files) {

				if (file == null || file.isEmpty()) {
					continue;
				}

				String oriName = file.getOriginalFilename();
				String fileName = UUID.randomUUID().toString() + "_" + oriName;

				File saveFile = new File(folder, fileName);

				file.transferTo(saveFile);

				RestaurantFileDTO restaurantFileDTO = new RestaurantFileDTO();
				restaurantFileDTO.setRestaurantNum(restaurantDTO.getRestaurantNum());
				restaurantFileDTO.setFileName(fileName);
				restaurantFileDTO.setOriName(oriName);

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

				String fileName = fileManager.fileSave("restaurant", multipartFile);

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

		return restaurantMapper.delete(restaurantDTO);
	}

	public int deleteFile(RestaurantFileDTO restaurantFileDTO) throws Exception {

		RestaurantFileDTO fileDTO = restaurantMapper.fileDetail(restaurantFileDTO);

		if (fileDTO == null) {
			return 0;
		}

		fileManager.fileDelete("restaurant", fileDTO.getFileName());

		return restaurantMapper.deleteFile(restaurantFileDTO);
	}

	public RestaurantDTO getReviewSummary(RestaurantDTO restaurantDTO) throws Exception {
		return restaurantMapper.getReviewSummary(restaurantDTO);
	}

}