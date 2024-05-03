package com.example.demo.serviceImplement;

import com.example.demo.repository.NotificationRepository;
import com.example.demo.service.NotificationService;

import jakarta.transaction.Transactional;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.entity.*;
@Service
public class NotificationServiceImplement implements NotificationService{
	private final NotificationRepository notificationRepository;

    @Autowired
    public NotificationServiceImplement(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }




	@Override
    public int getUnreadNotificationsCount(int userId) {
        return notificationRepository.countUnreadByUserId(userId);
    }
    
    @Override
    public List<Notification> getReadNotificationsForUser(int userId) {
    	 return notificationRepository.findByUserIdAndIsRead(userId,true);
    }

    @Override
    public List<Notification> getUnreadNotificationsForUser(int userId) {
    	return notificationRepository.findByUserIdAndIsRead(userId, false);
    }
    
    @Override
    public void markNotificationAsRead(int notificationId) {
        Notification notification = notificationRepository.findById(notificationId);
        notification.setIs_read(true);
        notificationRepository.save(notification);
    }




	@Override
	public void saveNot(Notification not) {
        notificationRepository.save(not);
		
	}
	
	
	@Override
	public void EnvoyerNotification(Notification notif) {
		// TODO Auto-generated method stub
		notificationRepository.save(notif);
	}
	
	@Override
	public void EnvoyerMotifLN(Notification notification) {
		notificationRepository.save(notification) ;
		
		
	}
}
