package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.*;
   import com.sulake.core.window.components.*;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.*;
   import flash.geom.Point;
   import com.sulake.habbo.communication.messages.outgoing.navigator.AddFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.navigator.DeleteFavouriteRoomMessageComposer;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_1945;
   
   public class GuestRoomListCtrl implements IViewCtrl
   {
      
      protected var _navigator:HabboNavigator;
      
      private var _content:class_1812;
      
      private var var_121:IItemListWindow;
      
      private var var_557:RoomPopupCtrl;
      
      private var var_818:IScrollbarWindow;
      
      protected var var_1577:UserCountRenderer;
      
      private var var_2604:class_1812;
      
      private var var_4171:int;
      
      private var var_4842:Boolean;
      
      private var var_4236:int;
      
      private var _showRoomNumbers:Boolean;
      
      public function GuestRoomListCtrl(param1:HabboNavigator, param2:int, param3:Boolean)
      {
         super();
         _navigator = param1;
         var_4236 = param2;
         _showRoomNumbers = param3;
         var_557 = new RoomPopupCtrl(_navigator,5,-5);
         var_1577 = new UserCountRenderer(_navigator);
      }
      
      public function dispose() : void
      {
         if(var_557)
         {
            var_557.dispose();
            var_557 = null;
         }
         if(var_1577)
         {
            var_1577.dispose();
            var_1577 = null;
         }
      }
      
      public function set content(param1:class_1812) : void
      {
         _content = param1;
         var_121 = _content ? IItemListWindow(_content.findChildByName("item_list")) : null;
         var_818 = _content ? IScrollbarWindow(_content.findChildByName("scroller")) : null;
         if(param1 == null && var_557)
         {
            var_557.closePopup();
         }
      }
      
      public function get content() : class_1812
      {
         return _content;
      }
      
      public function refresh() : void
      {
         var _loc4_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:Array = getRooms();
         var _loc1_:int = getVisibleEntryCount();
         var_121.autoArrangeItems = false;
         _loc4_ = 0;
         while(true)
         {
            if(_loc4_ < _loc3_.length)
            {
               refreshEntry(true,_loc4_,_loc3_[_loc4_]);
            }
            else
            {
               _loc2_ = refreshEntry(false,_loc4_,null);
               if(_loc2_)
               {
                  break;
               }
            }
            _loc4_++;
         }
         var_121.autoArrangeItems = true;
         if(var_818 != null && getVisibleEntryCount() != _loc1_)
         {
            var_818.scrollV = 0;
         }
         if(_content.findChildByName("no_rooms_found"))
         {
            _content.findChildByName("no_rooms_found").visible = _loc3_.length < 1;
         }
      }
      
      private function getVisibleEntryCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < var_121.numListItems)
         {
            if(var_121.getListItemAt(_loc2_).visible)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      protected function getListEntry(param1:int) : class_1812
      {
         var _loc3_:int = 0;
         var _loc2_:class_1812 = class_1812(_navigator.getXmlWindow("grs_guest_room_details_phase_one"));
         _loc2_.background = true;
         _loc2_.addEventListener("WME_MOVE",onMouseMove);
         _loc2_.addEventListener("WME_OVER",onMouseOver);
         _loc2_.addEventListener("WME_OUT",onMouseOut);
         _loc2_.addEventListener("WME_CLICK",onMouseClick);
         _loc2_.setParamFlag(1,true);
         _loc2_.setParamFlag(128,true);
         _loc2_.color = getBgColor(param1);
         _loc2_.tags.push(param1);
         if(_showRoomNumbers)
         {
            _loc3_ = 20;
            _loc2_.findChildByName("roomname").x = _loc2_.findChildByName("roomname").x + _loc3_;
            _loc2_.findChildByName("roomname").width = _loc2_.findChildByName("roomname").width - _loc3_;
         }
         return _loc2_;
      }
      
      protected function getBgColor(param1:int) : uint
      {
         return param1 % 2 != 0 ? 4294967295 : 4292797682;
      }
      
      private function refreshEntry(param1:Boolean, param2:int, param3:class_1945) : Boolean
      {
         var _loc4_:class_1812 = class_1812(var_121.getListItemAt(param2));
         if(_loc4_ == null)
         {
            if(!param1)
            {
               return true;
            }
            _loc4_ = getListEntry(param2);
            var_121.addListItem(_loc4_);
            var _loc5_:Boolean = true;
         }
         Util.hideChildren(_loc4_);
         if(param1)
         {
            refreshEntryDetails(_loc4_,param3);
            _loc4_.visible = true;
            _loc4_.height = 17;
         }
         else
         {
            _loc4_.height = 0;
            _loc4_.visible = false;
         }
         return false;
      }
      
      protected function refreshEntryDetails(param1:class_1812, param2:class_1945) : void
      {
         param1.visible = true;
         Util.hideChildren(param1);
         refreshFavouriteIcon(param1,param2);
         var _loc3_:String = param2.doorMode == 1 || param2.doorMode == 2 || param2.doorMode == 3 ? "group_base_icon" : "group_base_icon_no_doormode";
         _navigator.refreshButton(param1,_loc3_,param2.habboGroupId > 0,null,0,"group_base_icon");
         _navigator.refreshButton(param1,"home",isHome(param2),null,0);
         _navigator.refreshButton(param1,"doormode_doorbell_small",param2.doorMode == 1,null,0);
         _navigator.refreshButton(param1,"doormode_password_small",param2.doorMode == 2,null,0);
         _navigator.refreshButton(param1,"doormode_invisible_small",param2.doorMode == 3,null,0);
         if(_showRoomNumbers)
         {
            param1.findChildByName("room_number").visible = true;
            param1.findChildByName("room_number").caption = param1.tags[0] + 2 + ".";
         }
         refreshRoomName(param1,param2);
         var_1577.refreshUserCount(param2.maxUserCount,param1,param2.userCount,"${navigator.usercounttooltip.users}",308,2);
         param1.name = "guestroom_" + param2.ownerName + "_" + param2.roomName;
      }
      
      private function refreshRoomName(param1:class_1812, param2:class_1945) : void
      {
         var _loc4_:ITextWindow = ITextWindow(param1.getChildByName("roomname"));
         _loc4_.visible = true;
         var _loc3_:Boolean = param1.findChildByName("home").visible || Boolean(param1.findChildByName("favourite").visible) || Boolean(param1.findChildByName("make_favourite").visible);
         Util.cutTextToWidth(_loc4_,param2.roomName,_loc3_ ? _loc4_.width - 20 : _loc4_.width);
      }
      
      protected function onMouseMove(param1:class_1758) : void
      {
         this.checkFastHorizontalMove(param1);
      }
      
      protected function onMouseOver(param1:class_1758) : void
      {
         var _loc3_:class_1741 = param1.target;
         if(var_557.visible && var_4842)
         {
            return;
         }
         hilite(class_1812(_loc3_));
         var _loc2_:int = int(_loc3_.tags[0]);
         var _loc4_:class_1945 = getRoomAt(_loc2_);
         if(_loc4_ == null)
         {
            return;
         }
         var_557.room = _loc4_;
         var_557.showPopup(_loc3_);
      }
      
      public function getRooms() : Array
      {
         return _navigator == null || _navigator.data == null || _navigator.data.guestRoomSearchResults == null || _navigator.data.guestRoomSearchResults.rooms == null ? [] : _navigator.data.guestRoomSearchResults.rooms;
      }
      
      private function getRoomAt(param1:int) : class_1945
      {
         return getRooms()[param1];
      }
      
      protected function onMouseOut(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.target;
         if(Util.containsMouse(_loc2_))
         {
            return;
         }
         var _loc3_:int = int(_loc2_.tags[0]);
         _loc2_.color = getBgColor(_loc3_);
         var_557.closePopup();
      }
      
      protected function onMouseClick(param1:class_1758) : void
      {
         var _loc5_:class_1741 = param1.target;
         var _loc4_:int = int(_loc5_.tags[0]);
         var _loc2_:class_1945 = getRoomAt(_loc4_);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.ownerName != _navigator.sessionData.userName)
         {
            if(_loc2_.habboGroupId != 0)
            {
               _navigator.goToPrivateRoom(_loc2_.flatId);
               return;
            }
            var _loc3_:Point = new Point((param1 as WindowMouseEvent).stageX,(param1 as WindowMouseEvent).stageY);
            switch(_loc2_.doorMode - 1)
            {
               case 0:
                  _navigator.doorbell.show(_loc2_,null);
                  return;
               case 1:
                  _navigator.passwordInput.show(_loc2_,null);
                  return;
            }
         }
         beforeEnterRoom(_loc4_);
         _navigator.goToRoom(_loc2_.flatId,true,"",_loc4_);
         var_557.hideInstantly();
      }
      
      public function beforeEnterRoom(param1:int) : void
      {
      }
      
      private function refreshFavouriteIcon(param1:class_1812, param2:class_1945) : void
      {
         var _loc4_:Boolean = _navigator.data.isRoomFavourite(param2.flatId);
         var _loc3_:Boolean = isHome(param2);
         refreshRegion(param1,"make_favourite",!_loc4_ && !_loc3_,onAddFavouriteClick);
         refreshRegion(param1,"favourite",_loc4_ && !_loc3_,onRemoveFavouriteClick);
      }
      
      private function isHome(param1:class_1945) : Boolean
      {
         return param1.flatId == _navigator.data.homeRoomId;
      }
      
      private function refreshRegion(param1:class_1812, param2:String, param3:Boolean, param4:Function) : void
      {
         var _loc5_:IRegionWindow = param1.findChildByName(param2) as IRegionWindow;
         if(!_loc5_)
         {
            return;
         }
         if(!param3)
         {
            _loc5_.visible = false;
            if(_loc5_.hasEventListener("WME_CLICK"))
            {
               _loc5_.removeEventListener("WME_CLICK",param4);
            }
         }
         else
         {
            _loc5_.addEventListener("WME_CLICK",param4);
            _loc5_.visible = true;
            _navigator.refreshButton(_loc5_,param2,param3,null,0);
         }
      }
      
      private function onRemoveFavouriteClick(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1741 = param1.target;
         if(_loc3_ == null || _loc3_.parent == null)
         {
            return;
         }
         var _loc2_:class_1945 = getRoomAt(_loc3_.parent.tags[0]);
         if(_loc2_ == null)
         {
            return;
         }
         _navigator.send(new DeleteFavouriteRoomMessageComposer(_loc2_.flatId));
      }
      
      private function onAddFavouriteClick(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1741 = param1.target;
         if(_loc3_ == null || _loc3_.parent == null)
         {
            return;
         }
         var _loc2_:class_1945 = getRoomAt(int(_loc3_.parent.tags[0]));
         if(_loc2_ == null)
         {
            return;
         }
         _navigator.send(new AddFavouriteRoomMessageComposer(_loc2_.flatId));
      }
      
      private function hilite(param1:class_1812) : void
      {
         var _loc2_:int = 0;
         if(var_2604 != null && !var_2604.disposed)
         {
            _loc2_ = int(var_2604.tags[0]);
            var_2604.color = getBgColor(_loc2_);
         }
         var_2604 = param1;
         param1.color = 4288861930;
      }
      
      private function checkFastHorizontalMove(param1:class_1758) : void
      {
         var _loc3_:WindowMouseEvent = WindowMouseEvent(param1);
         var _loc2_:int = Math.abs(var_4171 - _loc3_.stageX);
         var_4171 = _loc3_.stageX;
         var_4842 = _loc2_ > 2;
      }
      
      public function get roomPopupCtrl() : RoomPopupCtrl
      {
         return var_557;
      }
      
      public function get navigator() : HabboNavigator
      {
         return _navigator;
      }
   }
}

