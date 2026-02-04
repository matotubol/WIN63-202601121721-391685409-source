package com.sulake.habbo.util
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.moderation.ModerationManager;
   import package_28.class_2765;
   
   public class VisitUserUtil
   {
      
      private var _main:ModerationManager;
      
      private var var_1270:int;
      
      public function VisitUserUtil(param1:ModerationManager, param2:class_1741, param3:int)
      {
         super();
         _main = param1;
         var_1270 = param3;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.connection.send(new class_2765(var_1270));
      }
   }
}

