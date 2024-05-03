package com.example.demo.repository;

import com.example.demo.entity.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface NotificationRepository extends JpaRepository<Notification, Integer> {
    List<Notification> findByUserId(int userId);
    @Query("SELECT COUNT(n) FROM Notification n WHERE n.user.id = :userId AND n.is_read = false")
    int countUnreadByUserId(@Param("userId") int userId);
    @Query("SELECT n FROM Notification n WHERE n.user.id = :userId AND n.is_read = :isRead ORDER BY n.date_envoi DESC ")
    List<Notification> findByUserIdAndIsRead(@Param("userId") int userId, @Param("isRead") boolean isRead);
    Notification  findById(int notificationId);
    }
