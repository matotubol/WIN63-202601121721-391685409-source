package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.habbo.friendbar.data.class_2307;
   import com.sulake.habbo.friendbar.data.class_3462;
   import com.sulake.habbo.localization.class_27;
   
   public class AchievementToken extends Token
   {
      
      public function AchievementToken(param1:class_3462, param2:class_2307, param3:class_27)
      {
         super(param2);
         var _loc4_:String = param3.getBadgeName(param2.message);
         prepare("${friendbar.notify.achievement}",_loc4_,"message_piece_xml","friend_bar_event_notification_icon");
      }
   }
}

