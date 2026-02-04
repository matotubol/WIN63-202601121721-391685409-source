package com.sulake.habbo.friendbar.view.tabs.tokens
{
   import com.sulake.habbo.friendbar.data.class_2307;
   import com.sulake.habbo.friendbar.data.class_3462;
   
   public class MessengerToken extends Token
   {
      
      public function MessengerToken(param1:class_3462, param2:class_2307)
      {
         super(param2);
         prepare("${friendbar.notify.messenger}",param2.message,"message_piece_xml","messenger_notification_icon");
      }
   }
}

