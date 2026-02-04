package com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_2713;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_2739;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.class_3150;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.class_3756;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import package_97.class_2591;
   
   public class WiredMenuSettingsTab extends WiredMenuDefaultTab
   {
      
      private var MODIFY_PERMISSION_OPTIONS:Array = [1,2,3];
      
      private var READ_PERMISSION_OPTIONS:Array = [0,1,2,3];
      
      private var var_858:int = -1;
      
      private var var_766:int = -1;
      
      private var var_846:String = null;
      
      private var _ignoringCheckboxEvents:Boolean = false;
      
      private var _ignoringTimezoneEvents:Boolean = false;
      
      public function WiredMenuSettingsTab(param1:WiredMenuController, param2:class_1812)
      {
         super(param1,param2);
         addMessageEvent(new class_2591(onWiredSettings));
         updateLoadingState();
         requestData();
         for each(var _loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            var _loc3_:class_1885 = getModifyCheckbox(0);
            null.addEventListener("WE_SELECTED",onPermissionsChanged);
            null.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         for each(_loc4_ in READ_PERMISSION_OPTIONS)
         {
            _loc3_ = getReadCheckbox(0);
            null.addEventListener("WE_SELECTED",onPermissionsChanged);
            null.addEventListener("WE_UNSELECTED",onPermissionsChanged);
         }
         toolbarCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         toolbarCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_SELECTED",onPreferencesChanged);
         wiredInspectButton.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         playtestCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         allNotificationsCheckbox.addEventListener("WE_SELECTED",onPreferencesChanged);
         allNotificationsCheckbox.addEventListener("WE_UNSELECTED",onPreferencesChanged);
         saveReloadButton.addEventListener("WME_CLICK",onClickReload);
         rollbackButton.addEventListener("WME_CLICK",onClickRollback);
         timezoneDropdown.addEventListener("WE_SELECTED",onSelectTimezone);
      }
      
      private function onClickRollback(param1:WindowMouseEvent) : void
      {
         controller.windowManager.confirm("${wiredmenu.settings.room_state.roll_back}","${wiredmenu.settings.room_state.roll_back.warning}",0,onRollbackConfirmed).titleBarColor = 13909337;
      }
      
      private function onRollbackConfirmed(param1:class_1750, param2:class_1758) : void
      {
         if(param2.type == "WE_OK")
         {
            controller.send(new class_2739(true));
         }
         param1.dispose();
      }
      
      private function onClickReload(param1:WindowMouseEvent) : void
      {
         controller.send(new class_2739(false));
      }
      
      private function onWiredSettings(param1:class_2591) : void
      {
         var _loc2_:class_3756 = param1.getParser();
         var_858 = _loc2_.modifyPermissionMask;
         var_766 = _loc2_.readPermissionMask;
         var_846 = _loc2_.timezone;
         updateLoadingState();
      }
      
      override protected function isDataReady() : Boolean
      {
         return var_858 != -1 && var_766 != -1 && var_846 != null;
      }
      
      private function requestData() : void
      {
         controller.send(new class_2713());
      }
      
      override public function permissionsUpdated() : void
      {
         updateButtonsUI();
      }
      
      override protected function initializeInterface() : void
      {
         updatePermissionsUI();
         updatePreferencesUI();
         updateTimezoneUI();
         updateButtonsUI();
      }
      
      private function onPermissionsChanged(param1:class_1758) : void
      {
         if(_ignoringCheckboxEvents)
         {
            return;
         }
         var _loc3_:class_1885 = param1.target as class_1885;
         var _loc2_:int = int(_loc3_.id);
         var _loc5_:* = _loc3_.name.indexOf("modify_") == 0;
         var _loc4_:* = param1.type == "WE_SELECTED";
         if(_loc5_)
         {
            if(_loc4_)
            {
               var_858 |= 1 << _loc2_;
            }
            else
            {
               var_858 &= ~(1 << _loc2_);
            }
         }
         else if(_loc4_)
         {
            var_766 |= 1 << _loc2_;
         }
         else
         {
            var_766 &= ~(1 << _loc2_);
         }
         updatePermissionsUI();
         updateTimezoneUI();
         controller.send(new class_3150(var_858,var_766,var_846));
      }
      
      private function onSelectTimezone(param1:class_1758) : void
      {
         if(_ignoringTimezoneEvents)
         {
            return;
         }
         var _loc2_:int = timezoneDropdown.selection;
         if(_loc2_ < 0 || _loc2_ >= timezoneDropdown.numMenuItems)
         {
            var_846 = "";
         }
         else
         {
            var_846 = timezoneDropdown.enumerateSelection()[_loc2_];
         }
         controller.send(new class_3150(var_858,var_766,var_846));
      }
      
      private function updateButtonsUI() : void
      {
         var _loc1_:Boolean = controller.isRoomOwnerOrStaff();
         var _loc2_:Boolean = controller.hasWritePermission;
         Util.disableSection(saveReloadButton,!_loc2_);
         Util.disableSection(rollbackButton,!_loc1_);
      }
      
      private function updateTimezoneUI() : void
      {
         _ignoringTimezoneEvents = true;
         var _loc2_:class_2261 = timezoneDropdown;
         var _loc3_:String = controller.getProperty("wired.timezones");
         var _loc1_:Array = _loc3_ == null || _loc3_ == "" ? ["UTC"] : _loc3_.split(",");
         var _loc6_:Vector.<String> = new Vector.<String>();
         if(var_846 != "")
         {
            _loc6_.push(var_846);
         }
         var _loc5_:int = 0;
         while(0 < _loc1_.length)
         {
            var _loc4_:String = _loc1_[0];
            if(_loc4_ != var_846)
            {
               _loc6_.push(null);
            }
            _loc5_++;
         }
         _loc2_.populateWithVector(_loc6_);
         if(_loc6_.length > 0)
         {
            _loc2_.selection = 0;
         }
         Util.disableSection(_loc2_,_loc6_.length < 2 || !timezoneContainer.isEnabled());
         _ignoringTimezoneEvents = false;
      }
      
      private function updatePermissionsUI() : void
      {
         _ignoringCheckboxEvents = true;
         selectedModifyMask = var_858;
         selectedReadMask = var_766;
         var _loc2_:Boolean = controller.isRoomOwnerOrStaff();
         Util.disableSection(modifySettingsContainer,!_loc2_);
         Util.disableSection(readSettingsContainer,!_loc2_);
         Util.disableSection(timezoneContainer,!_loc2_);
         if(getModifyCheckbox(2).isSelected)
         {
            getModifyCheckbox(3).select();
            Util.disableSection(getModifyCheckbox(3));
         }
         if(getReadCheckbox(2).isSelected)
         {
            getReadCheckbox(3).select();
            Util.disableSection(getReadCheckbox(3));
         }
         if(getReadCheckbox(0).isSelected)
         {
            for each(var _loc4_ in READ_PERMISSION_OPTIONS)
            {
               if(_loc4_ != 0)
               {
                  var _loc3_:class_1885 = getReadCheckbox(0);
                  null.select();
                  Util.disableSection(null);
               }
            }
         }
         for each(_loc4_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc3_ = getModifyCheckbox(0);
            if(null.isSelected)
            {
               var _loc1_:class_1885 = getReadCheckbox(0);
               null.select();
               Util.disableSection(null);
            }
         }
         _ignoringCheckboxEvents = false;
      }
      
      public function updatePreferencesUI() : void
      {
         _ignoringCheckboxEvents = true;
         Util.select(toolbarCheckbox,controller.wiredMenuButton);
         Util.select(wiredInspectButton,controller.wiredInspectButton);
         Util.select(playtestCheckbox,controller.playTestMode);
         Util.select(allNotificationsCheckbox,controller.showAllNotifications);
         _ignoringCheckboxEvents = false;
      }
      
      private function onPreferencesChanged(param1:class_1758) : void
      {
         if(_ignoringCheckboxEvents)
         {
            return;
         }
         controller.wiredMenuButton = toolbarCheckbox.isSelected;
         controller.wiredInspectButton = wiredInspectButton.isSelected;
         controller.setPlayTestMode(playtestCheckbox.isSelected,true);
         controller.showAllNotifications = allNotificationsCheckbox.isSelected;
         controller.sendPreferences();
      }
      
      private function get modifySettingsContainer() : class_1812
      {
         return container.findChildByName("modify_settings_container") as class_1812;
      }
      
      private function get readSettingsContainer() : class_1812
      {
         return container.findChildByName("read_settings_container") as class_1812;
      }
      
      private function get timezoneContainer() : class_1812
      {
         return container.findChildByName("timezone_container") as class_1812;
      }
      
      private function get toolbarCheckbox() : class_1885
      {
         return container.findChildByName("preference_toolbar_checkbox") as class_1885;
      }
      
      private function get wiredInspectButton() : class_1885
      {
         return container.findChildByName("preference_inspect_button_checkbox") as class_1885;
      }
      
      private function get playtestCheckbox() : class_1885
      {
         return container.findChildByName("preference_playtest_checkbox") as class_1885;
      }
      
      private function get allNotificationsCheckbox() : class_1885
      {
         return container.findChildByName("preference_all_notifications_checkbox") as class_1885;
      }
      
      private function getModifyCheckbox(param1:int) : class_1885
      {
         return container.findChildByName("modify_" + param1 + "_checkbox") as class_1885;
      }
      
      private function getReadCheckbox(param1:int) : class_1885
      {
         return container.findChildByName("read_" + param1 + "_checkbox") as class_1885;
      }
      
      private function get timezoneDropdown() : class_2261
      {
         return container.findChildByName("timezone_picker") as class_2261;
      }
      
      private function get saveReloadButton() : class_1775
      {
         return container.findChildByName("reload_room_btn") as class_1775;
      }
      
      private function get rollbackButton() : class_1775
      {
         return container.findChildByName("roll_back_btn") as class_1775;
      }
      
      private function get selectedModifyMask() : int
      {
         var _loc1_:class_1885 = null;
         for each(var _loc2_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc1_ = getModifyCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               var _loc3_:* = 0 | 1 << _loc2_;
            }
         }
         return 0;
      }
      
      private function get selectedReadMask() : int
      {
         var _loc1_:class_1885 = null;
         for each(var _loc2_ in READ_PERMISSION_OPTIONS)
         {
            _loc1_ = getReadCheckbox(_loc2_);
            if(_loc1_.isSelected)
            {
               var _loc3_:* = 0 | 1 << _loc2_;
            }
         }
         return 0;
      }
      
      private function set selectedModifyMask(param1:int) : void
      {
         var _loc2_:class_1885 = null;
         for each(var _loc3_ in MODIFY_PERMISSION_OPTIONS)
         {
            _loc2_ = getModifyCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
      
      private function set selectedReadMask(param1:int) : void
      {
         var _loc2_:class_1885 = null;
         for each(var _loc3_ in READ_PERMISSION_OPTIONS)
         {
            _loc2_ = getReadCheckbox(_loc3_);
            Util.select(_loc2_,(param1 & 1 << _loc3_) != 0);
         }
      }
   }
}

