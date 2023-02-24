package com.kh.board.model.service;

import static com.kh.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.model.vo.PageInfo;

public class BoardService {
    
    public int selectListCount() {
        
        Connection conn = getConnection();
        int listCount = new BoardDao().selectListCount(conn);
        
        close();
        
        return listCount;
    }
    
    public ArrayList<Board> selectList(PageInfo pi){
        Connection conn = getConnection();
        
        ArrayList<Board> list = new BoardDao().selectList(conn , pi);
        
        close();
        
        return list;
    }
    
    public int increaseCount(int boardNo) {
        Connection conn = getConnection();
        
        int result = new BoardDao().increaseCount(conn , boardNo);
        
        commitAndRollback(conn , result);
        
        return result;
    }
    
    public Board selectBoard(int boardNo) {
        Connection conn = getConnection();
        
        Board b = new BoardDao().selectBoard(conn , boardNo);
        
        close();
        
        return b;
                
    }
    
    public Attachment selectAttachment(int boardNo) {
        Connection conn = getConnection();
        
        Attachment at = new BoardDao().selectAttachment(conn , boardNo);
        
        close();
        
        return at;
    }
    
    public void commitAndRollback(Connection conn , int result) {
        
        if(result > 0) {
            commit(conn);
        }else {
            rollback(conn);
        }
        close();
    }
    
    public ArrayList<Category> selectCategoryList(){
        Connection conn = getConnection();
        
        ArrayList<Category> list = new BoardDao().selectCategoryList(conn);
        
        close();
        
        return list;
        
    } 
    
    public int insertBoard(Board b , Attachment at) {
        Connection conn = getConnection();
        
        int result1 = new BoardDao().insertBoard(b , conn);
        
        int result2 = 1;
        
        if(at != null) {
            result2 = new BoardDao().insertAttachment(at , conn);
        }
        
        // 트랜잭션 처리
        if(result1 > 0 && result2 > 0) {
            // 첨부파일이 없는경우, insert가 성공했을때도 result2는 여전히 0이라 rollback처리가 될수 있으므로
            // result2 = 1로 초기화시켜둠.
            commit(conn);
        }else {
            rollback(conn);
        }
        close();
        
        return result1 * result2;
        // 혹시라도 하나라도 실패하여 0이될 경우 아예 실패값을 반환받기위해 곱셈결과를 리턴.
    }
    
    public int updateBoard(Board b , Attachment at) {
        Connection conn = getConnection();
        
        int result1 = new BoardDao().updateBoard(conn , b);
        int result2 = 1;
        
        // 새롭게 첨부된 파일이 있는경우
        if(at != null) {
            
            // 기존에 첨부파일이 있었을경우 => update문 실행
            if(at.getFileNo() != 0) {
                result2 = new BoardDao().updateAttachment(at , conn);
                
            }else { // 기존에 첨부파일이 없었을경우 => insert문 실행
                result2 = new BoardDao().insertNewAttachment(at, conn);
            }
        }
        
        if(result1 > 0 && result2 > 0) {
            commit(conn);
        }else {
            rollback(conn);
        }
        close();
        
        return result1*result1;
    }
    
    public int deleteBoard(int boardNo) {
        Connection conn = getConnection();
        
        int result = new BoardDao().deleteBoard(boardNo , conn);
        
        new BoardDao().deleteAttachment(boardNo , conn);
        
        if(result > 0) {
            commit(conn);
        }else {
            rollback(conn);
        }
        close();
        
        return result;
    }
    
    public ArrayList<Board> selectThumbnailList(){
        Connection conn = getConnection();
        
        ArrayList<Board> list = new BoardDao().selectThumnailList(conn);
        
        close();
        
        return list;
    }
    
    public int insertThumbnailBoard(Board b , ArrayList<Attachment> list) {
        Connection conn = getConnection();
        
        int result1 = new BoardDao().insertThumbnailBoard(conn , b);
        
        int result2 = new BoardDao().insertAttachmentList(conn , list);
        
        if(result1 > 0 && result2 > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close();
        
        return result1 * result2;
    }
    
    public ArrayList<Attachment> selectAttachmentList(int boardNo){
        Connection conn = getConnection();
        
        ArrayList<Attachment> list = new BoardDao().selectAttachmentList(conn , boardNo);
        
        close();
        
        return list;
        
    }
    
    public ArrayList<Board> searchList(String searchType , String keyword){
    	Connection conn = getConnection();
    	
    	ArrayList<Board> list = new BoardDao().searchList(conn , searchType , keyword);
    	
    	close();
    	
    	return list;
    }

}
