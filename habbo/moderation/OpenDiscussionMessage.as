package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   
   public class OpenDiscussionMessage
   {
      
      private var _main:ModerationManager;
      
      private var _groupId:int;
      
      private var var_2326:int;
      
      private var var_2915:int;
      
      public function OpenDiscussionMessage(param1:ModerationManager, param2:class_1741, param3:int, param4:int, param5:int)
      {
         super();
         _main = param1;
         _groupId = param3;
         var_2326 = param4;
         var_2915 = param5;
         param2.procedure = onClick;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.openThreadMessage(_groupId,var_2326,var_2915);
      }
   }
}

