package com.sulake.habbo.friendlist.domain
{
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.friendlist.class_1807;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.notifications.class_536;
   
   public interface class_1836
   {
      
      function get view() : class_1807;
      
      function get messenger() : class_46;
      
      function get notifications() : class_536;
      
      function get avatarManager() : class_48;
      
      function get localizations() : class_27;
   }
}

