package com.kh.spring.repository.actor;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorPhotoDto;

public interface ActorPhotoDao {

	void save(ActorPhotoDto actorPhotoDto, MultipartFile attach) throws IllegalStateException, IOException;

	void update(ActorPhotoDto findPhotoDto, MultipartFile attach) throws IllegalStateException, IOException;

	ActorPhotoDto get(int actorPhotoNo);

	ActorPhotoDto getByActor(int actorNo);

	void delete(int actorPhotoNo);

	byte[] load(int actorPhotoNo) throws IOException;

}
