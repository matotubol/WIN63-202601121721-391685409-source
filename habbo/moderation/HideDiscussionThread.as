package com.sulake.habbo.moderation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import package_92.class_3542;
   
   public class HideDiscussionThread
   {
      
      private var _main:ModerationManager;
      
      private var _popup:ChatlogCtrl;
      
      private var _groupId:int;
      
      private var var_2326:int;
      
      public function HideDiscussionThread(param1:ModerationManager, param2:ChatlogCtrl, param3:class_1741, param4:int, param5:int)
      {
         super();
         _main = param1;
         _popup = param2;
         _groupId = param4;
         var_2326 = param5;
         param3.procedure = onClick;
      }
      
      private function onClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _popup.dispose();
         _main.connection.send(new class_3542(_groupId,var_2326,20));
      }
   }
}

