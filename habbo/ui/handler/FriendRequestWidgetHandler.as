package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   import com.sulake.habbo.session.events.RoomSessionFriendRequestEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class FriendRequestWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function FriendRequestWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_POLL";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWFRM_ACCEPT");
         _loc1_.push("RWFRM_DECLINE");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetFriendRequestMessage = null;
         if(!param1 || !_container)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWFRM_ACCEPT":
               _loc2_ = param1 as RoomWidgetFriendRequestMessage;
               if(!_loc2_ || !_container.friendList)
               {
                  return null;
               }
               _container.friendList.acceptFriendRequest(_loc2_.requestId);
               break;
            case "RWFRM_DECLINE":
               var _loc3_:RoomWidgetFriendRequestMessage = param1 as RoomWidgetFriendRequestMessage;
               return null;
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RSFRE_FRIEND_REQUEST");
         _loc1_.push("FRE_ACCEPTED");
         _loc1_.push("FRE_DECLINED");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:RoomWidgetFriendRequestUpdateEvent = null;
         var _loc5_:String = null;
         var _loc2_:RoomSessionFriendRequestEvent = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSFRE_FRIEND_REQUEST":
               _loc2_ = param1 as RoomSessionFriendRequestEvent;
               if(!_loc2_)
               {
                  return;
               }
               _loc5_ = "RWFRUE_SHOW_FRIEND_REQUEST";
               _loc3_ = new RoomWidgetFriendRequestUpdateEvent(_loc5_,_loc2_.requestId,_loc2_.userId,_loc2_.userName);
               break;
            case "FRE_ACCEPTED":
            case "FRE_DECLINED":
               var _loc4_:FriendRequestEvent = param1 as FriendRequestEvent;
               if(!_loc4_)
               {
                  return;
               }
               _loc5_ = "RWFRUE_HIDE_FRIEND_REQUEST";
               _loc3_ = new RoomWidgetFriendRequestUpdateEvent(_loc5_,null.requestId);
         }
         if(_loc3_)
         {
            _container.events.dispatchEvent(_loc3_);
         }
      }
      
      public function update() : void
      {
      }
   }
}

