package com.sulake.habbo.navigator.mainview
{
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.domain.RoomSessionTags;
   import package_42.class_4003;
   
   public class PromotedRoomsGuestRoomListCtrl extends GuestRoomListCtrl
   {
      
      private var var_191:class_4003;
      
      public function PromotedRoomsGuestRoomListCtrl(param1:HabboNavigator)
      {
         super(param1,-6,false);
      }
      
      public function set category(param1:class_4003) : void
      {
         var_191 = param1;
      }
      
      override public function getRooms() : Array
      {
         return var_191.rooms;
      }
      
      override public function beforeEnterRoom(param1:int) : void
      {
         navigator.data.roomSessionTags = new RoomSessionTags(var_191.code,"" + (param1 + 2));
      }
   }
}

