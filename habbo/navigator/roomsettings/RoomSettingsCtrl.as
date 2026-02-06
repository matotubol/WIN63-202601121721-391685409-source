package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.navigator.*;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.SaveRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.class_3235;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.DeleteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetFlatControllersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetBannedUsersFromRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.GetRoomSettingsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveAllRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.UnbanUserFromRoomMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_1841;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2565;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3362;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_3550;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3364;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3464;
   
   public class RoomSettingsCtrl implements class_13, ILinkEventTracker
   {
      
      private static const TAB_BASIC:int = 1;
      
      private static const TAB_ACCESS_RIGHTS:int = 2;
      
      private static const TAB_ROOM_RIGHTS:int = 3;
      
      private static const TAB_CLUB_AND_CHAT:int = 4;
      
      private static const TAB_MODERATION:int = 5;
      
      private static const HC_MAXIMUM_ROOM_VISITORS:int = 75;
      
      private static const MAXIMUM_ROOM_VISITORS:int = 50;
      
      private var _flatId:int;
      
      private var _groupId:int;
      
      private var _navigator:class_42;
      
      private var _originalData:class_1841;
      
      private var _savedFlatId:int;
      
      private var _window:class_2250;
      
      private var _currentTab:int = 1;
      
      private var _populating:Boolean;
      
      private var _usersWithRightsListCtrl:UserListCtrl;
      
      private var _friendsListCtrl:UserListCtrl;
      
      private var _confirmDialog:ConfirmDialogView;
      
      private var _nameInput:TextFieldManager;
      
      private var _descInput:TextFieldManager;
      
      private var _tag1Input:TextFieldManager;
      
      private var _tag2Input:TextFieldManager;
      
      private var _passwordInput:TextFieldManager;
      
      private var _passwordConfirmInput:TextFieldManager;
      
      private var _allowPetsCheckBox:class_1885;
      
      private var _allowFoodConsumeCheckBox:class_1885;
      
      private var _allowWalkThroughCheckBox:class_1885;
      
      private var _allowDynCatsCheckBox:class_1885;
      
      private var _hideWallsCheckBox:class_1885;
      
      private var _hideWallsText:ITextWindow;
      
      private var _wallThicknessDropMenu:class_2261;
      
      private var _floorThicknessDropMenu:class_2261;
      
      private var _tabContext:ITabContextWindow;
      
      private var _chatModeDropMenu:class_2261;
      
      private var _chatBubbleWidthDropMenu:class_2261;
      
      private var _chatScrollSpeedDropMenu:class_2261;
      
      private var _floodFilterDropMenu:class_2261;
      
      private var _chatSettingsTitleText:ITextWindow;
      
      private var _chatSettingsInfoText:ITextWindow;
      
      private var _chatFullHearRangeInput:TextFieldManager;
      
      private var _chatFullHearRangeTextField:ITextFieldWindow;
      
      private var _bannedUsersListCtrl:BanListCtrl;
      
      private var _useUnifiedWindow:Boolean;
      
      private var _removeTabsForNavigatorView:Boolean = false;
      
      private var roomModerationMuteSettings:Array;
      
      private var roomModerationBanSettings:Array;
      
      private var roomModerationKickSettings:Array;
      
      public function RoomSettingsCtrl(param1:class_42)
      {
         super();
         _navigator = param1;
         _usersWithRightsListCtrl = new UserListCtrl(_navigator,false);
         _friendsListCtrl = new UserListCtrl(_navigator,true);
         _bannedUsersListCtrl = new BanListCtrl(_navigator);
      }
      
      private static function get useHashTags() : Boolean
      {
         return true;
      }
      
      private static function setTag(param1:TextFieldManager, param2:String) : void
      {
         param1.setText(param2 == null ? "" : (useHashTags ? "#" : "") + param2);
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _originalData = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(_usersWithRightsListCtrl)
         {
            _usersWithRightsListCtrl.dispose();
            _usersWithRightsListCtrl = null;
         }
         if(_friendsListCtrl)
         {
            _friendsListCtrl.dispose();
            _friendsListCtrl = null;
         }
         if(_bannedUsersListCtrl)
         {
            _bannedUsersListCtrl.dispose();
            _bannedUsersListCtrl = null;
         }
         if(_confirmDialog)
         {
            _confirmDialog.dispose();
            _confirmDialog = null;
         }
         _nameInput = null;
         _descInput = null;
         _tag1Input = null;
         _tag2Input = null;
         _passwordInput = null;
         _passwordConfirmInput = null;
         _allowPetsCheckBox = null;
         _allowFoodConsumeCheckBox = null;
         if(_allowWalkThroughCheckBox)
         {
            _allowWalkThroughCheckBox.removeEventListener("WME_OVER",onWalkThroughMouseOver);
            _allowWalkThroughCheckBox = null;
         }
         if(_chatBubbleWidthDropMenu)
         {
            _chatBubbleWidthDropMenu.removeEventListener("WME_OVER",onBubbleWidthMouseOver);
            _chatBubbleWidthDropMenu = null;
         }
         if(_floodFilterDropMenu)
         {
            _floodFilterDropMenu.removeEventListener("WME_OVER",onFloodFilterMouseOver);
            _floodFilterDropMenu = null;
         }
         if(_chatFullHearRangeTextField)
         {
            _chatFullHearRangeTextField.removeEventListener("WME_OVER",onFullHearRangeMouseOver);
            _chatFullHearRangeTextField = null;
         }
         _allowDynCatsCheckBox = null;
         _hideWallsCheckBox = null;
         _hideWallsText = null;
         _wallThicknessDropMenu = null;
         _floorThicknessDropMenu = null;
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function startRoomSettingsEdit(param1:int) : void
      {
         close();
         this._flatId = param1;
         this._groupId = _navigator.data.enteredGuestRoom.habboGroupId;
         _navigator.send(new GetRoomSettingsMessageComposer(_flatId));
         _navigator.tracking.trackEventLogOncePerSession("Tutorial","interaction","viewed.room.settings");
         _navigator.events.dispatchEvent(new Event("HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT"));
      }
      
      public function startRoomSettingsEditFromNavigator(param1:int, param2:int) : void
      {
         close();
         this._flatId = param1;
         this._groupId = param2;
         _navigator.send(new GetRoomSettingsMessageComposer(_flatId));
         _navigator.tracking.trackEventLogOncePerSession("Tutorial","interaction","viewed.room.settings");
         _navigator.events.dispatchEvent(new Event("HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT"));
      }
      
      public function onRoomSettings(param1:class_1841) : void
      {
         if(param1.roomId != this._flatId)
         {
            return;
         }
         _originalData = param1;
         refresh();
         populateForm();
         _window.visible = true;
         _window.invalidate();
         _window.activate();
      }
      
      public function onFlatControllers(param1:int, param2:Array) : void
      {
         if(isAcceptFlatControllerUpdate(param1))
         {
            for each(var _loc3_ in param2)
            {
               _originalData.setFlatController(_loc3_.userId,_loc3_);
            }
            checkFlatControllerRefresh();
         }
      }
      
      public function onFlatControllerAdded(param1:int, param2:class_3362) : void
      {
         if(isAcceptFlatControllerUpdate(param1))
         {
            _originalData.setFlatController(param2.userId,param2);
            checkFlatControllerRefresh();
         }
      }
      
      public function onFlatControllerRemoved(param1:int, param2:int) : void
      {
         if(isAcceptFlatControllerUpdate(param1))
         {
            _originalData.setFlatController(param2,null);
            checkFlatControllerRefresh();
         }
      }
      
      public function onBannedUsersFromRoom(param1:int, param2:Array) : void
      {
         if(isAcceptBannedUsersFromRoomUpdate(param1))
         {
            for each(var _loc3_ in param2)
            {
               _originalData.setBannedUser(_loc3_.userId,_loc3_);
            }
            checkBannedUsersFromRoomRefresh();
         }
      }
      
      public function onUserUnbannedFromRoom(param1:int, param2:int) : void
      {
         if(isAcceptBannedUsersFromRoomUpdate(param1))
         {
            _originalData.setBannedUser(param2,null);
            checkBannedUsersFromRoomRefresh();
         }
      }
      
      public function onFriendListUpdate() : void
      {
         checkFlatControllerRefresh();
      }
      
      private function isAcceptFlatControllerUpdate(param1:int) : Boolean
      {
         return param1 == this._flatId && _originalData != null;
      }
      
      private function isAcceptBannedUsersFromRoomUpdate(param1:int) : Boolean
      {
         return param1 == this._flatId && _originalData != null;
      }
      
      private function checkFlatControllerRefresh() : void
      {
         if(_window != null && Boolean(_window.visible) && isContentVisible(3))
         {
            refresh();
         }
      }
      
      private function checkBannedUsersFromRoomRefresh() : void
      {
         if(_window != null && Boolean(_window.visible) && isContentVisible(5))
         {
            refresh();
         }
      }
      
      public function onRoomSettingsSaveError(param1:int, param2:int, param3:String) : void
      {
         if(param1 != this._flatId || _savedFlatId < 1)
         {
            return;
         }
         _savedFlatId = 0;
         if(param2 == 7)
         {
            switchToTab(1);
            this._nameInput.displayError("${navigator.roomsettings.roomnameismandatory}");
         }
         else if(param2 == 8)
         {
            switchToTab(1);
            this._nameInput.displayError("${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == 10)
         {
            switchToTab(1);
            this._descInput.displayError("${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == 11)
         {
            switchToTab(1);
            setTagError(this._tag1Input,param3,"${navigator.roomsettings.unacceptablewords}");
            setTagError(this._tag2Input,param3,"${navigator.roomsettings.unacceptablewords}");
         }
         else if(param2 == 12)
         {
            switchToTab(1);
            setTagError(this._tag1Input,param3,"${navigator.roomsettings.nonuserchoosabletag}");
            setTagError(this._tag2Input,param3,"${navigator.roomsettings.nonuserchoosabletag}");
         }
         else if(param2 == 5)
         {
            switchToTab(2);
            this._passwordInput.displayError("${navigator.roomsettings.passwordismandatory}");
         }
         else if(param2 == 13)
         {
            switchToTab(1);
            setTagError(this._tag1Input,param3,"${navigator.roomsettings.toomanycharacters}");
            setTagError(this._tag2Input,param3,"${navigator.roomsettings.toomanycharacters}");
         }
         else
         {
            switchToTab(1);
            this._nameInput.displayError("Update failed: error " + param2);
         }
         refresh();
      }
      
      private function switchToTab(param1:int) : void
      {
         _currentTab = param1;
         _tabContext.selector.setSelected(ISelectableWindow(_window.findChildByName("tab_" + param1)));
         _window.helpPage = getHelpPageWithTab(_currentTab);
      }
      
      private function isContentVisible(param1:int) : Boolean
      {
         return _useUnifiedWindow || _currentTab == param1;
      }
      
      private function setTagError(param1:TextFieldManager, param2:String, param3:String) : void
      {
         if(param2 == param1.getText().toLowerCase())
         {
            param1.displayError(param3);
         }
      }
      
      public function close() : void
      {
         this._flatId = 0;
         this._groupId = 0;
         this._originalData = null;
         this._savedFlatId = 0;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_confirmDialog != null)
         {
            _confirmDialog.dispose();
            _confirmDialog = null;
         }
      }
      
      private function clearErrors() : void
      {
         this._nameInput.clearErrors();
         this._descInput.clearErrors();
         this._tag1Input.clearErrors();
         this._tag2Input.clearErrors();
         this._passwordInput.clearErrors();
         this._passwordConfirmInput.clearErrors();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         if(_window == null)
         {
            _window = class_2250(_navigator.getXmlWindow("ros_room_settings"));
         }
         if(!_useUnifiedWindow)
         {
            _window.findChildByName("tab_1").procedure = onTab;
            _window.findChildByName("tab_2").procedure = onTab;
            _window.findChildByName("tab_3").procedure = onTab;
            _window.findChildByName("tab_4").procedure = onTab;
            _window.findChildByName("tab_5").procedure = onTab;
         }
         _window.findChildByName("builders_faq_button").procedure = onBuildersClubFaqButtonClick;
         showDeleteButton();
         var _loc2_:IRadioButtonWindow = _window.findChildByName("doormode_password") as IRadioButtonWindow;
         _loc2_.addEventListener("WE_SELECT",onDoorModePasswordSelect);
         _loc2_.addEventListener("WE_UNSELECT",onDoorModePasswordUnselect);
         _window.findChildByTag("close").addEventListener("WME_CLICK",onClose);
         getRemoveAllFlatCtrlsButton().addEventListener("WME_CLICK",onRemoveAllFlatCtrlsClick);
         _window.findChildByName("filter_users_input").addEventListener("WE_CHANGE",onUserFilterChange);
         _removeTabsForNavigatorView = !_navigator.data.enteredGuestRoom || _navigator.data.enteredGuestRoom.flatId != _originalData.roomId;
         if(_removeTabsForNavigatorView)
         {
            _window.findChildByName("remove_link_region").visible = false;
         }
         else
         {
            _window.findChildByName("remove_link_region").procedure = onDeleteButtonClick;
         }
         _nameInput = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("room_name")),60);
         _descInput = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("description")),255);
         _tag1Input = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("tag1")),30);
         _tag2Input = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("tag2")),30);
         _passwordInput = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("password")),30);
         _passwordConfirmInput = new TextFieldManager(_navigator,ITextFieldWindow(_window.findChildByName("password_confirm")),30);
         _allowPetsCheckBox = class_1885(_window.findChildByName("allow_pets_checkbox"));
         _allowFoodConsumeCheckBox = class_1885(_window.findChildByName("allow_foodconsume_checkbox"));
         _allowWalkThroughCheckBox = class_1885(_window.findChildByName("allow_walk_through_checkbox"));
         _allowWalkThroughCheckBox.addEventListener("WME_OVER",onWalkThroughMouseOver);
         _allowDynCatsCheckBox = class_1885(_window.findChildByName("allow_dyncats_checkbox"));
         _allowDynCatsCheckBox.visible = true;
         _window.findChildByName("allow_dyncats_text").visible = true;
         _hideWallsCheckBox = class_1885(_window.findChildByName("hide_walls_checkbox"));
         _hideWallsText = _window.findChildByName("hide_walls_text") as ITextWindow;
         _wallThicknessDropMenu = class_2261(_window.findChildByName("wall_thickness"));
         _floorThicknessDropMenu = class_2261(_window.findChildByName("floor_thickness"));
         _tabContext = ITabContextWindow(_window.findChildByName("tab_context"));
         _chatModeDropMenu = class_2261(_window.findChildByName("chat_mode"));
         _chatBubbleWidthDropMenu = class_2261(_window.findChildByName("chat_bubbles_width"));
         _chatBubbleWidthDropMenu.addEventListener("WME_OVER",onBubbleWidthMouseOver);
         _chatScrollSpeedDropMenu = class_2261(_window.findChildByName("chat_scroll_speed"));
         _chatScrollSpeedDropMenu.addEventListener("WME_OVER",onChatScrollSpeedMouseOver);
         _floodFilterDropMenu = class_2261(_window.findChildByName("chat_flood_sensitivity"));
         _floodFilterDropMenu.addEventListener("WME_OVER",onFloodFilterMouseOver);
         _chatSettingsTitleText = ITextWindow(_window.findChildByName("chat_settings_text"));
         _chatSettingsInfoText = ITextWindow(_window.findChildByName("chat_settings_info"));
         _chatFullHearRangeTextField = ITextFieldWindow(_window.findChildByName("chat_settings_hearing_distance"));
         _chatFullHearRangeTextField.addEventListener("WME_OVER",onFullHearRangeMouseOver);
         _chatFullHearRangeInput = new TextFieldManager(_navigator,_chatFullHearRangeTextField,2);
         var _loc5_:Array = [_nameInput,_descInput,_tag1Input,_tag2Input,_passwordInput,_passwordConfirmInput,_chatFullHearRangeInput];
         for each(var _loc4_ in _loc5_)
         {
            _loc4_.input.addEventListener("WE_UNFOCUSED",onUnfocus);
         }
         var _loc7_:Array = [_window.findChildByName("categories"),_window.findChildByName("maxvisitors"),_window.findChildByName("tradesettings"),_allowPetsCheckBox,_allowFoodConsumeCheckBox,_allowWalkThroughCheckBox,_allowDynCatsCheckBox,_hideWallsCheckBox,_wallThicknessDropMenu,_floorThicknessDropMenu,_chatBubbleWidthDropMenu,_chatModeDropMenu,_chatScrollSpeedDropMenu,_floodFilterDropMenu];
         for each(var _loc6_ in _loc7_)
         {
            _loc6_.addEventListener("WE_SELECTED",onUnfocus);
            _loc6_.addEventListener("WE_UNSELECTED",onUnfocus);
         }
         _window.findChildByName("doormode_open").addEventListener("WE_SELECTED",onUnfocus);
         _window.findChildByName("doormode_doorbell").addEventListener("WE_SELECTED",onUnfocus);
         _window.findChildByName("doormode_password").addEventListener("WE_SELECTED",onUnfocus);
         _window.findChildByName("doormode_invisible").addEventListener("WE_SELECTED",onUnfocus);
         var _loc1_:Array = [_window.findChildByName("moderation_mute_none"),_window.findChildByName("moderation_mute_rights"),_window.findChildByName("moderation_kick_none"),_window.findChildByName("moderation_kick_rights"),_window.findChildByName("moderation_kick_all"),_window.findChildByName("moderation_ban_none"),_window.findChildByName("moderation_ban_rights")];
         for each(var _loc3_ in _loc1_)
         {
            _loc3_.addEventListener("WE_SELECT",onUnfocus);
         }
         getPasswordContainer().visible = false;
         _window.findChildByName("remove_icon").x = _window.findChildByName("remove_link").x - 15;
         _window.findChildByName("tradesettings_label").visible = true;
         _window.findChildByName("tradesettings").visible = true;
         _window.findChildByName("moderation_unban_btn").addEventListener("WME_CLICK",onUnbanClick);
         _window.center();
         switchToTab(1);
      }
      
      private function onBubbleWidthMouseOver(param1:WindowMouseEvent) : void
      {
      }
      
      private function refreshNavigatorTabs() : void
      {
         _tabContext = ITabContextWindow(_window.findChildByName("tab_context"));
         var _loc3_:int = 0;
         while(0 < _tabContext.numTabItems)
         {
            var _loc1_:ITabButtonWindow = _tabContext.getTabItemAt(0);
            var _loc2_:Boolean = _removeTabsForNavigatorView && (null.id == 2 || null.id == 3);
            null.visible = true;
            _loc3_++;
         }
         _tabContext.selector.setSelected(ISelectableWindow(_window.findChildByName("tab_" + _currentTab)));
      }
      
      private function resizeTabs() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:ITabButtonWindow = null;
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _tabContext.numTabItems)
         {
            if(_tabContext.getTabItemAt(_loc5_).visible)
            {
               _loc6_++;
            }
            _loc5_++;
         }
         var _loc1_:int = _window.width / _loc6_;
         _loc1_ -= 1;
         _loc4_ = 0;
         while(_loc4_ < _tabContext.numTabItems)
         {
            _loc2_ = _tabContext.getTabItemAt(_loc4_);
            _loc3_ = _removeTabsForNavigatorView && (_loc2_.id == 2 || _loc2_.id == 3);
            _loc2_.width = _loc3_ ? 0 : _loc1_;
            _loc4_++;
         }
      }
      
      private function showDeleteButton() : void
      {
         if(_navigator.sessionData.isAccountSafetyLocked())
         {
            _window.findChildByName("remove_link_region").disable();
            _window.findChildByName("remove_link").blend = 0.5;
            _window.findChildByName("remove_icon").blend = 0.5;
         }
         else
         {
            _window.findChildByName("remove_link_region").enable();
            _window.findChildByName("remove_link").blend = 1;
            _window.findChildByName("remove_icon").blend = 1;
         }
      }
      
      private function getPasswordContainer() : class_1812
      {
         return class_1812(_window.findChildByName("password_container"));
      }
      
      private function getRemoveAllFlatCtrlsButton() : class_1775
      {
         return class_1775(_window.findChildByName("remove_all_flat_ctrls"));
      }
      
      private function getRemoveFlatCtrlsButton() : class_1775
      {
         return class_1775(_window.findChildByName("remove_flat_ctrl"));
      }
      
      public function refresh() : void
      {
         prepareWindow();
         if(!_useUnifiedWindow)
         {
            Util.hideChildren(class_1812(_window.findChildByName("content_container")));
            getTabContainer(_currentTab).visible = true;
         }
         refreshNavigatorTabs();
         resizeTabs();
         _window.helpPage = getHelpPageWithTab(_currentTab);
         refreshFlatControllers();
         refreshBannedUsers();
         refreshGroupMemberDisclaimer();
         showDeleteButton();
         _window.invalidate();
      }
      
      private function getTabContainer(param1:int) : class_1812
      {
         return class_1812(_window.findChildByName("tab_container_" + param1));
      }
      
      private function disableWindow(param1:class_1741) : void
      {
         if(param1 != null)
         {
            param1.disable();
            param1.blend = 0.5;
         }
      }
      
      private function enableWindow(param1:class_1741) : void
      {
         if(param1 != null)
         {
            param1.enable();
            param1.blend = 1;
         }
      }
      
      private function getThicknessSelectionIndex(param1:int) : int
      {
         switch(param1 - -2)
         {
            case 0:
               return 0;
            case 1:
               return 1;
            case 3:
               return 3;
            default:
               return 2;
         }
      }
      
      private function populateForm() : void
      {
         _populating = true;
         var _loc2_:class_1841 = _originalData;
         _nameInput.setText(_loc2_.name);
         _descInput.setText(_loc2_.description);
         _passwordInput.setText("");
         _passwordConfirmInput.setText("");
         var _loc4_:ISelectorWindow = _window.findChildByName("doormode") as ISelectorWindow;
         if(_navigator.data.enteredGuestRoom)
         {
            _window.findChildByName("doormode_override_info").visible = _loc2_.hiddenByBc && !_navigator.sessionData.hasSecurity(4);
            switch(_loc2_.doorMode - 1)
            {
               case 0:
                  var _loc3_:IRadioButtonWindow = _window.findChildByName("doormode_doorbell") as IRadioButtonWindow;
                  _loc4_.setSelected(null);
                  break;
               case 1:
                  var _loc1_:IRadioButtonWindow = _window.findChildByName("doormode_password") as IRadioButtonWindow;
                  _loc4_.setSelected(null);
                  break;
               case 2:
                  var _loc5_:IRadioButtonWindow = _window.findChildByName("doormode_invisible") as IRadioButtonWindow;
                  _loc4_.setSelected(null);
                  break;
               default:
                  var _loc6_:IRadioButtonWindow = _window.findChildByName("doormode_open") as IRadioButtonWindow;
                  _loc4_.setSelected(null);
                  break;
               case 3:
            }
            changePasswordField(_loc2_.doorMode == 2);
         }
         class_21.log("CATEGORY ID: " + _loc2_.categoryId);
         setCategorySelection(_loc2_.categoryId);
         setTradeModeSelection(_loc2_.tradeMode);
         refreshMaxVisitors(_loc2_);
         setTag(_tag1Input,_loc2_.tags[0]);
         setTag(_tag2Input,_loc2_.tags[1]);
         if(_allowPetsCheckBox)
         {
            if(_loc2_.allowPets)
            {
               this._allowPetsCheckBox.select();
            }
            else
            {
               this._allowPetsCheckBox.unselect();
            }
         }
         if(_allowFoodConsumeCheckBox)
         {
            if(_loc2_.allowFoodConsume)
            {
               _allowFoodConsumeCheckBox.select();
            }
            else
            {
               _allowFoodConsumeCheckBox.unselect();
            }
         }
         if(_allowWalkThroughCheckBox)
         {
            if(_loc2_.allowWalkThrough)
            {
               _allowWalkThroughCheckBox.select();
            }
            else
            {
               _allowWalkThroughCheckBox.unselect();
            }
         }
         if(_allowDynCatsCheckBox)
         {
            if(_loc2_.allowNavigatorDynamicCats)
            {
               _allowDynCatsCheckBox.select();
            }
            else
            {
               _allowDynCatsCheckBox.unselect();
            }
         }
         if(!VIPFeaturesAllowed())
         {
            disableWindow(_hideWallsCheckBox);
            disableWindow(_wallThicknessDropMenu);
            disableWindow(_floorThicknessDropMenu);
            disableWindow(_hideWallsText);
         }
         else
         {
            enableWindow(_hideWallsCheckBox);
            enableWindow(_wallThicknessDropMenu);
            enableWindow(_floorThicknessDropMenu);
            enableWindow(_hideWallsText);
         }
         if(_hideWallsCheckBox)
         {
            if(_loc2_.hideWalls)
            {
               _hideWallsCheckBox.select();
            }
            else
            {
               _hideWallsCheckBox.unselect();
            }
         }
         _chatModeDropMenu.selection = _loc2_.chatSettings.mode;
         _chatBubbleWidthDropMenu.selection = _loc2_.chatSettings.bubbleWidth;
         _chatScrollSpeedDropMenu.selection = _loc2_.chatSettings.scrollSpeed;
         _chatFullHearRangeInput.setText(_loc2_.chatSettings.fullHearRange.toString());
         _floodFilterDropMenu.selection = _loc2_.chatSettings.floodSensitivity;
         if(_wallThicknessDropMenu)
         {
            _wallThicknessDropMenu.selection = getThicknessSelectionIndex(_loc2_.wallThickness);
         }
         if(_floorThicknessDropMenu)
         {
            _floorThicknessDropMenu.selection = getThicknessSelectionIndex(_loc2_.floorThickness);
         }
         populateRoomModerationSettings(_loc2_);
         this.clearErrors();
         _populating = false;
      }
      
      private function populateRoomModerationSettings(param1:class_1841) : void
      {
         var _loc4_:* = _groupId > 0;
         roomModerationMuteSettings = _loc4_ ? [0,1,4,5] : [0,1];
         roomModerationBanSettings = _loc4_ ? [0,1,4,5] : [0,1];
         roomModerationKickSettings = _loc4_ ? [0,1,2,4,5] : [0,1,2];
         var _loc2_:class_2261 = class_2261(_window.findChildByName("moderation_mute_dropdown"));
         _loc2_.populate(localizeItems(roomModerationMuteSettings));
         _loc2_.selection = normalizeSelection(roomModerationMuteSettings,param1.roomModerationSettings.whoCanMute);
         var _loc3_:class_2261 = class_2261(_window.findChildByName("moderation_ban_dropdown"));
         _loc3_.populate(localizeItems(roomModerationBanSettings));
         _loc3_.selection = normalizeSelection(roomModerationBanSettings,param1.roomModerationSettings.whoCanBan);
         var _loc6_:class_2261 = class_2261(_window.findChildByName("moderation_kick_dropdown"));
         _loc6_.populate(localizeItems(roomModerationKickSettings));
         _loc6_.selection = normalizeSelection(roomModerationKickSettings,param1.roomModerationSettings.whoCanKick);
         for each(var _loc5_ in [_loc2_,_loc3_,_loc6_])
         {
            _loc5_.addEventListener("WE_SELECTED",onUnfocus);
            _loc5_.addEventListener("WE_UNSELECTED",onUnfocus);
         }
      }
      
      private function normalizeSelection(param1:Array, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function localizeItems(param1:Array) : *
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            switch(_loc3_)
            {
               case 0:
                  _loc2_.push("${navigator.roomsettings.moderation.none}");
                  break;
               case 1:
                  _loc2_.push("${navigator.roomsettings.moderation.rights}");
                  break;
               case 2:
                  _loc2_.push("${navigator.roomsettings.moderation.all}");
                  break;
               case 4:
                  _loc2_.push("${navigator.roomsettings.moderation.group_admins}");
                  break;
               case 5:
                  _loc2_.push("${navigator.roomsettings.moderation.group_admins_and_rights}");
            }
         }
         return _loc2_;
      }
      
      private function VIPFeaturesAllowed() : Boolean
      {
         return _navigator.sessionData.hasVip;
      }
      
      private function refreshMaxVisitors(param1:class_1841) : void
      {
         var _loc3_:int = 0;
         var _loc5_:Array = [];
         var _loc6_:* = -1;
         var _loc4_:int = 0;
         var _loc2_:int = VIPFeaturesAllowed() ? 75 : 50;
         _loc3_ = 10;
         while(_loc3_ <= _loc2_)
         {
            _loc5_.push("" + _loc3_);
            if(_loc3_ == param1.maximumVisitors)
            {
               _loc6_ = _loc4_;
            }
            _loc4_++;
            _loc3_ += 5;
         }
         if(param1.maximumVisitors > _loc2_)
         {
            _loc5_.push("" + _loc2_);
            _loc6_ = _loc4_;
         }
         var _loc7_:class_2261 = _window.findChildByName("maxvisitors") as class_2261;
         _loc7_.populate(_loc5_);
         _loc7_.selection = _loc6_ > -1 ? _loc6_ : 0;
      }
      
      private function setCategorySelection(param1:int) : void
      {
         var _loc2_:class_2261 = _window.findChildByName("categories") as class_2261;
         var _loc4_:Array = [];
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc5_ in _navigator.data.allCategories)
         {
            if((_loc5_.visible || param1 == _loc5_.nodeId) && !_loc5_.automatic)
            {
               _loc4_.push(_loc5_.visibleName);
               if(param1 == _loc5_.nodeId)
               {
                  _loc6_ = _loc3_;
               }
               _loc3_++;
            }
         }
         _loc2_.populate(_loc4_);
         _loc2_.selection = _loc6_;
      }
      
      private function setTradeModeSelection(param1:int) : void
      {
         var _loc2_:class_2261 = _window.findChildByName("tradesettings") as class_2261;
         var _loc3_:Array = [];
         _loc3_.push("${navigator.roomsettings.trade_not_allowed}");
         _loc3_.push("${navigator.roomsettings.trade_not_with_Controller}");
         _loc3_.push("${navigator.roomsettings.trade_allowed}");
         _loc2_.populate(_loc3_);
         _loc2_.selection = param1;
      }
      
      private function getFlatCategoryByIndex(param1:int, param2:int) : class_3364
      {
         var _loc3_:int = 0;
         for each(var _loc4_ in _navigator.data.allCategories)
         {
            if((_loc4_.visible || param1 == _loc4_.nodeId) && !_loc4_.automatic)
            {
               if(param2 == _loc3_)
               {
                  return _loc4_;
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         close();
      }
      
      private function onUnfocus(param1:class_1758) : void
      {
         if(!_populating)
         {
            save();
         }
      }
      
      private function save() : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(_originalData == null || _window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:class_3235 = new class_3235();
         _loc3_.roomId = _originalData.roomId;
         _loc3_.name = _nameInput.getText();
         _loc3_.description = _descInput.getText();
         var _loc6_:ISelectorWindow = _window.findChildByName("doormode") as ISelectorWindow;
         var _loc5_:class_1741 = _loc6_.getSelected();
         if(_loc5_ == null)
         {
            _loc3_.doorMode = _originalData.doorMode;
         }
         else
         {
            switch(_loc5_.name)
            {
               case "doormode_doorbell":
                  _loc3_.doorMode = 1;
                  break;
               case "doormode_password":
                  _loc3_.doorMode = 2;
                  break;
               case "doormode_invisible":
                  _loc3_.doorMode = 3;
                  break;
               default:
                  _loc3_.doorMode = 0;
            }
         }
         if(_loc3_.doorMode == 2)
         {
            _loc2_ = _passwordInput.getText();
            _loc4_ = _passwordConfirmInput.getText();
            if(_loc2_ != _loc4_)
            {
               this._passwordInput.clearErrors();
               this.switchToTab(2);
               this._passwordConfirmInput.displayError("${navigator.roomsettings.invalidconfirm}");
               return;
            }
            if(_loc2_ != "")
            {
               _loc3_.password = _loc2_;
            }
         }
         var _loc7_:class_2261 = _window.findChildByName("categories") as class_2261;
         var _loc8_:class_3364 = getFlatCategoryByIndex(_originalData.categoryId,_loc7_.selection);
         _loc3_.categoryId = _loc8_.nodeId;
         var _loc1_:class_2261 = _window.findChildByName("tradesettings") as class_2261;
         _loc3_.tradeMode = _loc1_.selection;
         var _loc9_:class_2261 = _window.findChildByName("maxvisitors") as class_2261;
         _loc3_.maximumVisitors = _loc9_.enumerateSelection()[_loc9_.selection];
         _loc3_.allowPets = _allowPetsCheckBox.isSelected;
         _loc3_.allowFoodConsume = _allowFoodConsumeCheckBox.isSelected;
         _loc3_.allowWalkThrough = _allowWalkThroughCheckBox.isSelected;
         _loc3_.allowNavigatorDynCats = _allowDynCatsCheckBox.isSelected;
         _loc3_.hideWalls = _hideWallsCheckBox.isSelected;
         _loc3_.wallThickness = _wallThicknessDropMenu.selection - 2;
         _loc3_.floorThickness = _floorThicknessDropMenu.selection - 2;
         _loc3_.tags = [];
         addTag(_tag1Input,_loc3_.tags);
         addTag(_tag2Input,_loc3_.tags);
         setModeratorSettings(_loc3_);
         _loc3_.chatMode = _chatModeDropMenu.selection;
         _loc3_.chatBubbleSize = _chatBubbleWidthDropMenu.selection;
         _loc3_.chatScrollUpFrequency = _chatScrollSpeedDropMenu.selection;
         _loc3_.chatFullHearRange = int(_chatFullHearRangeInput.getText());
         _loc3_.chatFloodSensitivity = _floodFilterDropMenu.selection;
         this.clearErrors();
         this._savedFlatId = _loc3_.roomId;
         _navigator.send(new SaveRoomSettingsMessageComposer(_loc3_));
      }
      
      private function addTag(param1:TextFieldManager, param2:Array) : void
      {
         var _loc3_:String = null;
         if(param1.getText() != "")
         {
            _loc3_ = param1.getText();
            if(useHashTags && _loc3_.charAt(0) == "#")
            {
               _loc3_ = _loc3_.substr(1,_loc3_.length - 1);
            }
            param2.push(_loc3_);
         }
      }
      
      private function setModeratorSettings(param1:class_3235) : void
      {
         var _loc2_:class_2261 = class_2261(_window.findChildByName("moderation_mute_dropdown"));
         param1.whoCanMute = roomModerationMuteSettings[_loc2_.selection];
         var _loc3_:class_2261 = class_2261(_window.findChildByName("moderation_ban_dropdown"));
         param1.whoCanBan = roomModerationBanSettings[_loc3_.selection];
         var _loc4_:class_2261 = class_2261(_window.findChildByName("moderation_kick_dropdown"));
         param1.whoCanKick = roomModerationKickSettings[_loc4_.selection];
      }
      
      private function onDeleteButtonClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_flatId == _navigator.homeRoomId)
         {
            _navigator.windowManager.alert("${navigator.delete.homeroom.title}","${navigator.delete.homeroom.body}",0,onAlertClose);
            return;
         }
         if(_groupId > 0)
         {
            _navigator.windowManager.alert("${group.deletebase.title}","${group.deletebase.body}",0,onAlertClose);
            return;
         }
         class_21.log("[RoomSettingsCtrl.onDeleteButtonClick] " + _flatId);
         if(_originalData == null)
         {
            return;
         }
         if(_confirmDialog != null)
         {
            _confirmDialog.dispose();
         }
         _navigator.registerParameter("navigator.roomsettings.deleteroom.confirm.message","room_name",_originalData.name);
         _confirmDialog = new ConfirmDialogView(_navigator,onConfirmRoomDelete,"${navigator.roomsettings}","${navigator.roomsettings.deleteroom.confirm.message}");
      }
      
      private function onBuildersClubFaqButtonClick(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_navigator.windowManager != null)
         {
            (_navigator.windowManager as class_17).context.createLinkEvent("habbopages/builders-club/faq");
         }
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function onConfirmRoomDelete() : void
      {
         var _loc1_:class_3464 = null;
         _navigator.send(new DeleteRoomMessageComposer(_originalData.roomId));
         close();
         if(_navigator.data.guestRoomSearchResults != null)
         {
            _loc1_ = _navigator.data.guestRoomSearchResults;
            _navigator.mainViewCtrl.startSearch(_navigator.tabs.getSelected().id,_loc1_.searchType,_loc1_.searchParam);
         }
      }
      
      private function onDoorModePasswordSelect(param1:class_1758) : void
      {
         changePasswordField(true);
      }
      
      private function onDoorModePasswordUnselect(param1:class_1758) : void
      {
         changePasswordField(false);
      }
      
      private function changePasswordField(param1:Boolean) : void
      {
         getPasswordContainer().visible = param1;
      }
      
      private function refreshGroupMemberDisclaimer() : void
      {
         if(!isContentVisible(2))
         {
            return;
         }
         if(!_navigator.data.enteredGuestRoom)
         {
            return;
         }
         var _loc1_:* = _navigator.data.enteredGuestRoom.habboGroupId > 0;
         _window.findChildByName("guild_access_disclaimer").visible = _loc1_;
      }
      
      private function refreshFlatControllers() : void
      {
         var _loc2_:Array = null;
         if(!isContentVisible(3))
         {
            return;
         }
         if(!_navigator.data.enteredGuestRoom)
         {
            return;
         }
         if(_originalData.controllersById == null)
         {
            _originalData.controllersById = new Dictionary();
            _navigator.send(new GetFlatControllersMessageComposer(_originalData.roomId));
            _loc2_ = [];
         }
         else
         {
            _loc2_ = _originalData.controllerList;
         }
         var _loc1_:String = ITextWindow(_window.findChildByName("filter_users_input")).text.toLowerCase();
         var _loc3_:Array = getFriendsWithNoRights();
         _usersWithRightsListCtrl.refresh(IItemListWindow(_window.findChildByName("users_with_rights_item_list")),_loc2_,_loc1_,_originalData.highlightedUserId);
         _friendsListCtrl.refresh(IItemListWindow(_window.findChildByName("friends_item_list")),_loc3_,_loc1_,_originalData.highlightedUserId);
         _navigator.registerParameter("navigator.flatctrls.userswithrights","displayed","" + _usersWithRightsListCtrl.userCount);
         _navigator.registerParameter("navigator.flatctrls.friends","displayed","" + _friendsListCtrl.userCount);
         _navigator.registerParameter("navigator.flatctrls.userswithrights","total","" + _loc2_.length);
         _navigator.registerParameter("navigator.flatctrls.friends","total","" + _loc3_.length);
      }
      
      private function refreshBannedUsers() : void
      {
         var _loc1_:Array = null;
         if(_currentTab != 5)
         {
            return;
         }
         if(_originalData.bannedUsersById == null)
         {
            _navigator.send(new GetBannedUsersFromRoomMessageComposer(_originalData.roomId));
            _loc1_ = [];
         }
         else
         {
            _loc1_ = _originalData.bannedUsersList;
         }
         _bannedUsersListCtrl.refresh(IItemListWindow(_window.findChildByName("moderation_banned_users")),_loc1_,"",0);
      }
      
      private function getFriendsWithNoRights() : Array
      {
         var _loc1_:Dictionary = _originalData.controllersById;
         var _loc3_:Array = [];
         if(_loc1_.length == 0)
         {
            return _loc3_;
         }
         for each(var _loc2_ in _navigator.data.friendList.list)
         {
            if(_loc1_[_loc2_.userId] == null)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function onRemoveAllFlatCtrlsClick(param1:class_1758) : void
      {
         class_21.log("Remove all clicked: ");
         if(_confirmDialog != null)
         {
            _confirmDialog.dispose();
         }
         _confirmDialog = new ConfirmDialogView(_navigator,onRemoveAllFlatCtrlsConfirm,"${navigator.flatctrls.removeconfirm.title}","${navigator.flatctrls.removeconfirm.info}");
      }
      
      private function onRemoveAllFlatCtrlsConfirm() : void
      {
         _navigator.send(new RemoveAllRightsMessageComposer(this._flatId));
      }
      
      private function onTab(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _currentTab = param2.id;
         refresh();
         if(_currentTab == 2)
         {
            _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer","select","room.settings.doormode.seen");
         }
      }
      
      private function onUserFilterChange(param1:class_1758) : void
      {
         refreshFlatControllers();
      }
      
      private function onUnbanClick(param1:WindowMouseEvent) : void
      {
         if(_bannedUsersListCtrl.selectedRow < 0)
         {
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("moderation_banned_users") as IItemListWindow;
         var _loc2_:class_1741 = class_1812(_loc3_.getListItemAt(_bannedUsersListCtrl.selectedRow)).findChildByName("user_info_region");
         var _loc4_:int = _loc2_.id;
         _navigator.send(new UnbanUserFromRoomMessageComposer(_loc4_,_flatId));
      }
      
      private function getHelpPageWithTab(param1:int) : String
      {
         if(param1 == 4)
         {
            return "chat/options";
         }
         return "";
      }
      
      public function get linkPattern() : String
      {
         return "roomsettings/";
      }
      
      public function linkReceived(param1:String) : void
      {
      }
      
      private function onWalkThroughMouseOver(param1:WindowMouseEvent) : void
      {
         _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","room.settings.walkthrough.seen");
      }
      
      private function onChatScrollSpeedMouseOver(param1:WindowMouseEvent) : void
      {
         _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","room.settings.chat.scrollspeed.seen");
      }
      
      private function onFloodFilterMouseOver(param1:WindowMouseEvent) : void
      {
         _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","room.settings.chat.floodfilter.seen");
      }
      
      private function onFullHearRangeMouseOver(param1:WindowMouseEvent) : void
      {
         _navigator.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","room.settings.chat.hearrange.seen");
      }
   }
}

