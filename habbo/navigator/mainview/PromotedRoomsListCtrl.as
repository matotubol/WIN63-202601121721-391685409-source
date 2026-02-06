package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.*;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import com.sulake.habbo.window.widgets.class_2478;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_4003;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   
   public class PromotedRoomsListCtrl implements class_13
   {
      
      private static const CATEGORY_SPACING:int = 5;
      
      private var _navigator:HabboNavigator;
      
      private var var_1577:UserCountRenderer;
      
      private var var_1474:PromotedRoomsGuestRoomListCtrl;
      
      public function PromotedRoomsListCtrl(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
         var_1577 = new UserCountRenderer(_navigator);
         var_1474 = new PromotedRoomsGuestRoomListCtrl(_navigator);
      }
      
      public function dispose() : void
      {
         _navigator = null;
         if(var_1577)
         {
            var_1577.dispose();
            var_1577 = null;
         }
         if(var_1474)
         {
            var_1474.dispose();
            var_1474 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      private function getCategoryContainer(param1:class_1812, param2:int) : class_1812
      {
         return class_1812(param1.getChildByID(param2));
      }
      
      public function refresh(param1:class_1812, param2:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:class_1812 = null;
         Util.hideChildren(param1);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = getCategoryContainer(param1,_loc4_);
            if(_loc5_ == null)
            {
               _loc5_ = createEntry(_loc4_);
               _loc5_.id = _loc4_;
               param1.addChild(_loc5_);
            }
            refreshEntry(_loc5_,param2[_loc4_]);
            _loc5_.y = _loc3_;
            _loc3_ += _loc5_.height + 5;
            _loc5_.visible = true;
            _loc4_++;
         }
         param1.height = Util.getLowestPoint(param1) > 0 ? Util.getLowestPoint(param1) + 5 : 0;
      }
      
      public function createEntry(param1:int) : class_1812
      {
         var _loc2_:class_1812 = class_1812(_navigator.getXmlWindow("grs_promoted_room_category"));
         setProcedureAndId(_loc2_,param1,"enter_room_button",onEnterRoomButton);
         setProcedureAndId(_loc2_,param1,"leader_region",onLeaderRegion);
         setProcedureAndId(_loc2_,param1,"toggle_open_region",onToggleOpenRegion);
         _navigator.refreshButton(_loc2_,"navi_room_icon",true,null,0);
         return _loc2_;
      }
      
      private function getLocationAfter(param1:class_1812, param2:String, param3:int = 3) : int
      {
         var _loc4_:class_1741 = param1.findChildByName(param2);
         return _loc4_.x + _loc4_.width + param3;
      }
      
      private function setProcedureAndId(param1:class_1812, param2:int, param3:String, param4:Function) : void
      {
         param1.findChildByName(param3).procedure = param4;
         param1.findChildByName(param3).id = param2;
      }
      
      public function refreshEntry(param1:class_1812, param2:class_4003) : void
      {
         var _loc4_:String = _navigator.getText("promotedroomcategory." + param2.code);
         param1.findChildByName("category_name_txt").caption = _loc4_;
         param1.findChildByName("category_header").width = param1.findChildByName("category_name_txt").width + 13;
         _navigator.registerParameter("navigator.promotedrooms.hidetopten","category",_loc4_);
         _navigator.registerParameter("navigator.promotedrooms.viewtopten","category",_loc4_);
         param1.findChildByName("open_txt").caption = _navigator.getText("navigator.promotedrooms.viewtopten");
         param1.findChildByName("close_txt").caption = _navigator.getText("navigator.promotedrooms.hidetopten");
         param1.findChildByName("room_name_txt").caption = param2.bestRoom.roomName;
         var _loc3_:class_1741 = param1.findChildByName("leader_name_txt");
         _loc3_.caption = param2.bestRoom.showOwner ? param2.bestRoom.ownerName : "";
         _loc3_.x = getLocationAfter(param1,"leader_name_caption_txt",0);
         param1.findChildByName("arrow_down_icon").visible = param2.open;
         param1.findChildByName("arrow_right_icon").visible = !param2.open;
         param1.findChildByName("close_txt").visible = param2.open;
         param1.findChildByName("open_txt").visible = !param2.open;
         param1.findChildByName("arrow_down_icon").x = getLocationAfter(param1,"close_txt");
         param1.findChildByName("arrow_right_icon").x = getLocationAfter(param1,"open_txt");
         var_1577.refreshUserCount(param2.bestRoom.maxUserCount,class_1812(param1.findChildByName("enter_room_button")),param2.bestRoom.userCount,"${navigator.usercounttooltip.users}",222,35);
         refreshAvatarImage(param1,param2);
         param1.findChildByName("item_list").visible = param2.open;
         if(param2.open)
         {
            param1.findChildByName("item_list").height = param2.rooms.length * 17;
            var_1474.content = param1;
            var_1474.category = param2;
            var_1474.refresh();
         }
         param1.height = param2.open ? Util.getLowestPoint(param1) + 3 : 90;
      }
      
      private function onEnterRoomButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:class_4003 = findCategory(param2);
            _navigator.data.roomSessionTags = new RoomSessionTags(null.code,"1");
            _navigator.goToPrivateRoom(null.bestRoom.flatId);
            _navigator.closeNavigator();
         }
      }
      
      private function onLeaderRegion(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:class_4003 = findCategory(param2);
            _navigator.trackGoogle("extendedProfile","navigator_promotedRoom");
            _navigator.send(new GetExtendedProfileMessageComposer(null.bestRoom.ownerId));
         }
      }
      
      private function onToggleOpenRegion(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc5_:class_4003 = null;
         if(param1.type == "WME_CLICK")
         {
            while(_loc4_ < _navigator.data.promotedRooms.entries.length)
            {
               _loc5_ = _navigator.data.promotedRooms.entries[_loc4_];
               if(param2.id != _loc4_)
               {
                  _loc5_.open = false;
               }
               _loc4_++;
            }
            var _loc3_:class_4003 = findCategory(param2);
            null.toggleOpen();
            _navigator.mainViewCtrl.refresh();
         }
      }
      
      private function findCategory(param1:class_1741) : class_4003
      {
         return _navigator.data.promotedRooms.entries[param1.id];
      }
      
      private function refreshAvatarImage(param1:class_1812, param2:class_4003) : void
      {
         var _loc3_:class_2010 = class_2010(param1.findChildByName("avatar_image_widget"));
         var _loc4_:class_2478 = class_2478(_loc3_.widget);
         _loc4_.figure = param2.leaderFigure;
      }
   }
}

