package com.kh.spring.repository.movie;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.movie.MoviePhotoDto;

@Repository
public class MoviePhotoDaoImpl implements MoviePhotoDao{
	
	@Autowired
	private SqlSession sqlSession;
	//저장용 폴더
	@Value("${config.rootpath.movie}")
	public String directory;
	
	@Override
	public int getPhotoSequence() {
		return sqlSession.selectOne("moviePhoto.getPhotoSequence");
	}

	@Override
	public void insert(MoviePhotoDto moviePhotoDto, MultipartFile photo) throws IllegalStateException, IOException {
		int sequencePhoto = getPhotoSequence();
		
		File target = new File(directory,String.valueOf(sequencePhoto));
		photo.transferTo(target);
		
		moviePhotoDto.setMoviePhotoNo(sequencePhoto);
		moviePhotoDto.setMoviePhotoSaveName(String.valueOf(sequencePhoto));
		sqlSession.insert("moviePhoto.insert",moviePhotoDto);
	}

	@Override
	public List<MoviePhotoDto> list(int movieNo) {
		return sqlSession.selectList("moviePhoto.list",movieNo);
	}

	@Override
	public void delete(int moviePhotoNo) {
		sqlSession.delete("moviePhoto.delete",moviePhotoNo);
	}

	@Override
	public void update(MoviePhotoDto moviePhotoDto, MultipartFile photo) throws IllegalStateException, IOException {

		File target = new File(directory,moviePhotoDto.getMoviePhotoSaveName());
		photo.transferTo(target);
		
		sqlSession.update("moviePhoto.update",moviePhotoDto);
  }
  
  @Override
	public List<MoviePhotoDto> getList(int movieNo) {
		return sqlSession.selectList("moviePhoto.getPhotoList", movieNo);

	}

	@Override
	public MoviePhotoDto get(int moviePhotoNo) {
		return sqlSession.selectOne("moviePhoto.get", moviePhotoNo);
	}

	@Override
	public byte[] load(int moviePhotoNo) throws IOException {
		File target = new File(directory,String.valueOf(moviePhotoNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

}
