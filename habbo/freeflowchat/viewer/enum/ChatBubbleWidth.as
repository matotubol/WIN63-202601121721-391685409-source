package com.sulake.habbo.freeflowchat.viewer.enum
{
   public class ChatBubbleWidth
   {
      
      public static const NORMAL:int = 350;
      
      public static const THIN:int = 240;
      
      public static const WIDE:int = 2000;
      
      public function ChatBubbleWidth()
      {
         super();
      }
      
      public static function accordingToRoomChatSetting(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 2000;
            case 1:
               return 350;
            case 2:
               return 240;
            default:
               return 350;
         }
      }
   }
}

