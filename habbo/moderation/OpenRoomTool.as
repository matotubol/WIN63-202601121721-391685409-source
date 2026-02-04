package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   
   public class OpenRoomTool
   {
      
      private var _frame:class_2250;
      
      private var _main:ModerationManager;
      
      private var var_1951:int;
      
      public function OpenRoomTool(param1:class_2250, param2:ModerationManager, param3:class_1741, param4:int)
      {
         super();
         _frame = param1;
         _main = param2;
         var_1951 = param4;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomToolCtrl(_main,var_1951),_frame,false,false,true);
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
   }
}

