package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   
   public class OpenRoomInSpectatorMode
   {
      
      private var _main:ModerationManager;
      
      private var var_1951:int;
      
      public function OpenRoomInSpectatorMode(param1:ModerationManager, param2:class_1741, param3:int)
      {
         super();
         _main = param1;
         var_1951 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.goToRoom(var_1951);
      }
   }
}

