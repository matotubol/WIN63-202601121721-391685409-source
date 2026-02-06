package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.users.class_1846;
   
   public class DetailsWindowCtrl implements class_13
   {
      
      private var var_52:HabboGroupsManager;
      
      private var _window:class_2250;
      
      private var var_1867:GroupDetailsCtrl;
      
      private var _groupId:int;
      
      public function DetailsWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         var_52 = param1;
         var_1867 = new GroupDetailsCtrl(param1,true);
      }
      
      public function dispose() : void
      {
         var_52 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_1867)
         {
            var_1867.dispose();
            var_1867 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_52 == null;
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && Boolean(_window.visible) && param1 == _groupId;
      }
      
      public function onGroupDetails(param1:class_1846) : void
      {
         if(_window != null && Boolean(_window.visible) && param1.groupId == _groupId || param1.openDetails)
         {
            _groupId = param1.groupId;
            prepareWindow();
            var_1867.onGroupDetails(class_1812(_window.findChildByName("group_cont")),param1);
            if(param1.openDetails)
            {
               _window.visible = true;
               _window.activate();
            }
         }
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = class_2250(var_52.getXmlWindow("group_info_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _groupId = 0;
            _window.visible = false;
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(_groupId == param1)
         {
            close();
         }
      }
   }
}

