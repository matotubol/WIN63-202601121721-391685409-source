package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.class_42;
   import com.sulake.habbo.utils.class_2323;
   import com.sulake.habbo.communication.messages.outgoing.room.action.RemoveRightsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.action.AssignRightsMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.class_2565;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class UserListCtrl implements class_13
   {
      
      private static const DISPLAY_LIMIT:int = 200;
      
      protected var _navigator:class_42;
      
      private var var_3571:Boolean;
      
      protected var var_3244:int;
      
      public function UserListCtrl(param1:class_42, param2:Boolean)
      {
         super();
         _navigator = param1;
         var_3571 = param2;
      }
      
      public function dispose() : void
      {
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh(param1:IItemListWindow, param2:Array, param3:String, param4:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = false;
         var _loc8_:Array = [];
         for each(var _loc7_ in param2)
         {
            if(param3 == "" || _loc7_.userName.toLowerCase().indexOf(param3) > -1)
            {
               _loc8_.push(_loc7_);
            }
            if(_loc8_.length >= 200)
            {
               break;
            }
         }
         param1.autoArrangeItems = false;
         _loc6_ = 0;
         while(true)
         {
            _loc5_ = refreshEntry(param1,_loc6_,_loc8_[_loc6_],param4);
            if(_loc5_)
            {
               break;
            }
            _loc6_++;
         }
         param1.autoArrangeItems = true;
         param1.invalidate();
         var_3244 = _loc8_.length;
      }
      
      private function getListEntry(param1:int) : class_1812
      {
         var _loc2_:class_1812 = getRowView();
         var _loc3_:IRegionWindow = IRegionWindow(_loc2_.findChildByName("bg_region"));
         _loc3_.addEventListener("WME_CLICK",onBgMouseClick);
         _loc3_.addEventListener("WME_OVER",onBgMouseOver);
         _loc3_.addEventListener("WME_OUT",onBgMouseOut);
         class_2323.setup(_loc2_,onUserInfoMouseClick);
         _loc2_.id = param1;
         return _loc2_;
      }
      
      protected function getRowView() : class_1812
      {
         return class_1812(_navigator.getXmlWindow(var_3571 ? "ros_friend" : "ros_flat_controller"));
      }
      
      protected function getBgColor(param1:int, param2:Boolean) : uint
      {
         return param2 ? 4290173439 : (param1 % 2 != 0 ? 4294967295 : 4293519841);
      }
      
      private function refreshEntry(param1:IItemListWindow, param2:int, param3:class_2565, param4:int) : Boolean
      {
         var _loc5_:class_1812 = class_1812(param1.getListItemAt(param2));
         if(_loc5_ == null)
         {
            if(param3 == null)
            {
               return true;
            }
            _loc5_ = getListEntry(param2);
            param1.addListItem(_loc5_);
         }
         if(param3 != null)
         {
            _loc5_.color = this.getBgColor(param2,param3.userId == param4);
            refreshEntryDetails(_loc5_,param3);
            _loc5_.visible = true;
            _loc5_.height = 20;
         }
         else
         {
            _loc5_.height = 0;
            _loc5_.visible = false;
         }
         return false;
      }
      
      private function refreshEntryDetails(param1:class_1812, param2:class_2565) : void
      {
         param1.findChildByName("user_name_txt").caption = param2.userName;
         var _loc3_:IRegionWindow = IRegionWindow(param1.findChildByName("bg_region"));
         _loc3_.id = param2.userId;
         param1.findChildByName("user_info_region").id = param2.userId;
         class_2323.setUserInfoState(false,param1);
      }
      
      protected function onBgMouseClick(param1:class_1758) : void
      {
         var _loc2_:Array = null;
         var _loc3_:class_1812 = class_1812(param1.target);
         if(var_3571)
         {
            _navigator.send(new AssignRightsMessageComposer(_loc3_.id));
         }
         else
         {
            _loc2_ = [];
            _loc2_.push(_loc3_.id);
            _navigator.send(new RemoveRightsMessageComposer(_loc2_));
         }
      }
      
      private function onBgMouseOver(param1:class_1758) : void
      {
         var _loc3_:class_1812 = class_1812(param1.target.parent);
         _loc3_.color = getBgColor(-1,true);
         var _loc2_:class_1741 = _loc3_.findChildByName("arrow_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = true;
         }
      }
      
      private function onBgMouseOut(param1:class_1758) : void
      {
         var _loc3_:class_1812 = class_1812(param1.target.parent);
         _loc3_.color = getBgColor(_loc3_.id,false);
         var _loc2_:class_1741 = _loc3_.findChildByName("arrow_icon");
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
      }
      
      public function get userCount() : int
      {
         return var_3244;
      }
      
      private function onUserInfoMouseClick(param1:class_1758) : void
      {
         _navigator.trackGoogle("extendedProfile","navigator_roomSettingsUsersList");
         _navigator.send(new GetExtendedProfileMessageComposer(param1.target.id));
      }
   }
}

