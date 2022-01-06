package com.kh.spring.repository.actor;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.entity.actor.ActorPhotoDto;

public interface ActorPhotoDao {

	void save(ActorPhotoDto actorPhotoDto, MultipartFile attach) throws IllegalStateException, IOException;

}
