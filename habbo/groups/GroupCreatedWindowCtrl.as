package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import package_9.class_1796;
   
   public class GroupCreatedWindowCtrl implements class_13
   {
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_2250;
      
      private var _groupId:int;
      
      public function GroupCreatedWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
      }
      
      public function dispose() : void
      {
         var_52 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      public function show(param1:int) : void
      {
         _groupId = param1;
         prepareWindow();
         _window.visible = true;
         _window.activate();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_2250(var_52.getXmlWindow("group_created_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("ok_button").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
            var_52.send(new class_1796(_groupId,false));
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}

