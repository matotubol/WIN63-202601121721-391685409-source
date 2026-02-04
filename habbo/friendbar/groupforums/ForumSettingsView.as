package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import package_155.class_3591;
   
   public class ForumSettingsView
   {
      
      private static const const_422:Number = 0.5;
      
      private var var_55:GroupForumController;
      
      private var var_172:GroupForumView;
      
      private var _window:class_2250;
      
      private var var_2550:ISelectorWindow;
      
      private var var_2019:ISelectorWindow;
      
      private var var_2172:ISelectorWindow;
      
      private var var_2601:ISelectorWindow;
      
      private var var_95:class_3591;
      
      private var var_1981:int;
      
      private var var_1911:int;
      
      private var var_3241:int;
      
      private var var_2771:int;
      
      public function ForumSettingsView(param1:GroupForumView, param2:int, param3:int, param4:class_3591)
      {
         super();
         var_172 = param1;
         var_55 = var_172.controller;
         var_95 = param4;
         _window = class_2250(var_55.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_settings_xml())));
         _window.x = param2;
         var _loc5_:int = int(var_55.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc5_)
         {
            _window.x = _loc5_ - _window.width;
         }
         _window.y = param3;
         initControls();
      }
      
      private static function setSelectorState(param1:ISelectorWindow, param2:int, param3:int) : int
      {
         var _loc5_:int = 0;
         var _loc6_:ISelectableWindow = null;
         var _loc4_:class_1741 = null;
         if(param3 < param2)
         {
            param3 = param2;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = param1.getSelectableByName(String(_loc5_));
            if(_loc6_ != null)
            {
               _loc6_.disable();
               _loc6_.blend = 0.5;
               _loc4_ = class_1812(param1.parent).findChildByName("label" + _loc5_);
               if(_loc4_ != null)
               {
                  _loc4_.blend = 0.5;
               }
            }
            _loc5_++;
         }
         _loc5_ = param2;
         while(_loc5_ < 4)
         {
            _loc6_ = param1.getSelectableByName(String(_loc5_));
            if(_loc6_ != null)
            {
               _loc6_.enable();
               _loc6_.blend = 1;
               _loc4_ = class_1812(param1.parent).findChildByName("label" + _loc5_);
               if(_loc4_ != null)
               {
                  _loc4_.blend = 1;
               }
               if(_loc5_ == param3)
               {
                  param1.setSelected(_loc6_);
               }
            }
            _loc5_++;
         }
         return param3;
      }
      
      private static function getSelectorState(param1:ISelectorWindow) : int
      {
         var _loc2_:ISelectableWindow = param1.getSelected();
         if(_loc2_ == null)
         {
            return 0;
         }
         return int(_loc2_.name);
      }
      
      public function focus(param1:class_3591) : void
      {
         if(var_95 != param1)
         {
            var_95 = param1;
            initControls();
         }
         _window.activate();
      }
      
      private function initControls() : void
      {
         var _loc2_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,var_95);
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc1_:class_1741 = _window.findChildByName("cancel_btn");
         _loc1_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc1_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc3_:class_1741 = _window.findChildByName("header_button_close");
         _loc3_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc3_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:class_1741 = _window.findChildByName("ok_btn");
         _loc4_.removeEventListener("WME_CLICK",onPostButtonClick);
         _loc4_.addEventListener("WME_CLICK",onPostButtonClick);
         var_2550 = ISelectorWindow(_window.findChildByName("read_selector"));
         var_2550.addEventListener("WME_OVER",onReadSelectorHover);
         addSelectorListeners(var_2550);
         var_2019 = ISelectorWindow(_window.findChildByName("post_message_selector"));
         var_2019.addEventListener("WME_OVER",onPostMessageSelectorHover);
         addSelectorListeners(var_2019);
         var_2172 = ISelectorWindow(_window.findChildByName("post_thread_selector"));
         var_2172.addEventListener("WME_OVER",onPostThreadSelectorHover);
         addSelectorListeners(var_2172);
         var_2601 = ISelectorWindow(_window.findChildByName("moderate_selector"));
         var_2601.addEventListener("WME_OVER",onModerateSelectorHover);
         addSelectorListeners(var_2601);
         var_1981 = setSelectorState(var_2550,0,var_95.readPermissions);
         var_1911 = setSelectorState(var_2019,var_1981,var_95.postMessagePermissions);
         var_3241 = setSelectorState(var_2172,var_1911,var_95.postThreadPermissions);
         var_2771 = setSelectorState(var_2601,2,var_95.moderatePermissions);
      }
      
      public function dispose() : void
      {
         var_55.forumSettingsView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         var_55.context.createLinkEvent("group/" + var_95.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         var_55.updateForumSettings(var_95.groupId,var_1981,var_1911,var_3241,var_2771);
         dispose();
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function addSelectorListeners(param1:ISelectorWindow) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ISelectableWindow = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numSelectables)
         {
            _loc3_ = param1.getSelectableAt(_loc2_);
            _loc3_.removeEventListener("WE_SELECTED",onSelectionChanged);
            _loc3_.addEventListener("WE_SELECTED",onSelectionChanged);
            _loc2_++;
         }
      }
      
      private function onSelectionChanged(param1:class_1758) : void
      {
         var_1981 = getSelectorState(var_2550);
         var_1911 = setSelectorState(var_2019,var_1981,getSelectorState(var_2019));
         var_3241 = setSelectorState(var_2172,var_1911,getSelectorState(var_2172));
         var_2771 = getSelectorState(var_2601);
      }
      
      private function onReadSelectorHover(param1:WindowMouseEvent) : void
      {
         var_55.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.read.seen");
      }
      
      private function onPostMessageSelectorHover(param1:WindowMouseEvent) : void
      {
         var_55.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.post.seen");
      }
      
      private function onPostThreadSelectorHover(param1:WindowMouseEvent) : void
      {
         var_55.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.start.thread.seen");
      }
      
      private function onModerateSelectorHover(param1:WindowMouseEvent) : void
      {
         var_55.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.moderate.seen");
      }
   }
}

