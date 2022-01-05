package com.kh.spring.repository.store;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.Multipart;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.kh.spring.entity.store.StoreDto;
import com.kh.spring.entity.store.StorePhotoDto;

@Repository
public class StoreDaoImpl implements StoreDao{
	@Autowired
	private SqlSession sqlSession;
	
//	//저장용 폴더
//    @Value("${config.rootpath}")
//    public String directory;
	@Override
	public void insert(StoreDto storeDto) {
		sqlSession.insert("store.insert",storeDto);
	}
//	
//	@Override
//	public void insert(StorePhotoDto storePhotoDto,Multipart photo) {
//		int seqStorePhoto = getSeq();
//		File target = new File(directory,String.valueOf(seqStorePhoto));
//		photo.transferTo(target);
//	}

	@Override
	public boolean changeInformation(StoreDto storeDto) {
		int count = sqlSession.update("store.changeInformation", storeDto);
		return count > 0;
	}

	@Override
	public List<StoreDto> list() {
		List<StoreDto> list = sqlSession.selectList("store.list");
		return list;
	}

	@Override
	public int count(String column, String keyword) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		return sqlSession.selectOne("store.count",param);
	}

	@Override
	public List<StoreDto> search(String column, String keyword, int begin, int end) {
		Map<String,Object> param = new HashMap<>();
		param.put("column",column);
		param.put("keyword",keyword);
		param.put("begin",begin);
		param.put("end",end);
		return sqlSession.selectList("store.search",param);
	}

	@Override
	public StoreDto get(int productNo) {
		
		return sqlSession.selectOne("store.get",productNo);
	}

	@Override
	public boolean delete(int productNo) {
			int result = sqlSession.delete("store.delete",productNo);
			return result>0;
		}

	@Override
	public int getSeq() {
		return sqlSession.selectOne("store.getSeq");
	}


	}