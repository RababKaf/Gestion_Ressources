package com.example.demo.service;

import java.util.List;

import com.example.demo.entity.Notification;

public interface NotificationService {
	    int getUnreadNotificationsCount(int userId);
	    List<Notification> getReadNotificationsForUser(int userId);
	    List<Notification> getUnreadNotificationsForUser(int userId);
		void markNotificationAsRead(int notificationId);
		void saveNot(Notification not);
		
		 void EnvoyerNotification(Notification notif);
		 
		 
			
			public void EnvoyerMotifLN(Notification notification ) ;

}
