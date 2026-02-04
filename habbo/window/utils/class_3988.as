package com.sulake.habbo.window.utils
{
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.display.BitmapData;
   
   public class class_3988
   {
      
      public function class_3988()
      {
         super();
      }
      
      public static function categoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return 2;
            }
            if(param2 == 3002)
            {
               return 3;
            }
            if(param2 == 4057)
            {
               return 4;
            }
            return 1;
         }
         return 1;
      }
      
      public static function createChatItemPreview(param1:HabboWindowManagerComponent, param2:int, param3:String = null) : BitmapData
      {
         if(param3 == null)
         {
            param3 = param1.sessionDataManager.userName;
         }
         return param1.freeFlowChat.createPreviewBitmap(param3,param2);
      }
   }
}

