package com.kh.spring.repository.actor;

import java.io.File;
import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorPhotoDto;

@Repository
public class ActorPhotoDaoImpl implements ActorPhotoDao{
	@Autowired
	private SqlSession sqlSession;
	//저장용 폴더
	@Value("${config.rootpath.actor}")
	public String directory;
	
	@Override
	public void save(ActorPhotoDto actorPhotoDto, MultipartFile attach) throws IllegalStateException, IOException {
		int sequence = sqlSession.selectOne("actorPhoto.getSequence");
		
		File target = new File(directory,String.valueOf(sequence));
		attach.transferTo(target);
		
		actorPhotoDto.setActorPhotoNo(sequence);
		actorPhotoDto.setActorPhotoSaveName(String.valueOf(sequence));
		
		sqlSession.insert("actorPhoto.save",actorPhotoDto);
	}

	@Override
	public void update(ActorPhotoDto findPhotoDto, MultipartFile attach) throws IllegalStateException, IOException {
		File target = new File(directory,findPhotoDto.getActorPhotoSaveName());
		attach.transferTo(target);
		sqlSession.insert("actorPhoto.update",findPhotoDto);
	}

	@Override
	public ActorPhotoDto get(int actorPhotoNo) {
		return sqlSession.selectOne("actorPhoto.get",actorPhotoNo);
	}

	@Override
	public ActorPhotoDto getByActor(int actorNo) {
		return sqlSession.selectOne("actorPhoto.getByActor",actorNo);
	}

	@Override
	public void delete(int actorPhotoNo) {
		sqlSession.delete("actorPhoto.delete",actorPhotoNo);
	}
}
