package cn.ebuy.service.impl;

import cn.ebuy.dao.IEBuyNewsDao;
import cn.ebuy.domain.EBuyNews;
import cn.ebuy.service.IEBuyNewsService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author ：微笑
 * @date ：Created in 2020/6/25 0:59
 * @modified By：
 */

@Service
@Transactional
public class EBuyNewsServiceImpl implements IEBuyNewsService {

    @Autowired
    private IEBuyNewsDao eBuyNewsDao;

    @Override
    public int delNews(Integer newsId) {
        return eBuyNewsDao.delNews(newsId);
    }

    @Override
    public int updateNews(EBuyNews eBuyNews) {
        return eBuyNewsDao.updateNews(eBuyNews);
    }

    @Override
    public int saveNews(EBuyNews eBuyNews) throws Exception {
        return eBuyNewsDao.saveNews(eBuyNews);
    }

    @Override
    public List<EBuyNews> findAllNews() throws Exception{
        return eBuyNewsDao.findAllNews();
    }

    @Override
    public List<EBuyNews> findNewsPage(Integer page, Integer size) throws Exception {
        PageHelper.startPage(page,size);
        return eBuyNewsDao.findAllNews();
    }

    @Override
    public EBuyNews findByNewsId(Integer id) {
        return eBuyNewsDao.findByNewsId(id);
    }


}
