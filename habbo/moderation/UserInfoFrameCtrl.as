package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.parser.moderation.class_3291;
   
   public class UserInfoFrameCtrl implements class_13, ITrackedWindow
   {
      
      private var _main:ModerationManager;
      
      private var var_1270:int;
      
      private var _frame:class_2250;
      
      private var _disposed:Boolean;
      
      private var var_2077:UserInfoCtrl;
      
      private var var_2726:class_3291;
      
      public function UserInfoFrameCtrl(param1:ModerationManager, param2:int, param3:class_3291 = null)
      {
         super();
         _main = param1;
         var_1270 = param2;
         var_2726 = param3;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = class_2250(_main.getXmlWindow("user_info_frame"));
         _frame.caption = "User Info";
         var _loc1_:class_1741 = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         var_2077 = new UserInfoCtrl(_frame,_main,var_2726,null,true);
         var_2077.load(_frame.content,var_1270);
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 1;
      }
      
      public function getId() : String
      {
         return "" + var_1270;
      }
      
      public function getFrame() : class_2250
      {
         return _frame;
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(var_2077 != null)
         {
            var_2077.dispose();
            var_2077 = null;
         }
         var_2726 = null;
         _main = null;
      }
   }
}

