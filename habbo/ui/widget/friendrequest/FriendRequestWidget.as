package com.sulake.habbo.ui.widget.friendrequest
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   
   public class FriendRequestWidget extends RoomWidgetBase implements class_31
   {
      
      private var var_59:class_17;
      
      private var var_436:class_55;
      
      public function FriendRequestWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_17)
      {
         super(param1,param2,param3,param4);
         var_59 = param5;
         var_436 = new class_55();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_59)
         {
            var_59.removeUpdateReceiver(this);
            var_59 = null;
         }
         if(var_436)
         {
            for each(var _loc1_ in var_436)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            var_436.dispose();
            var_436 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("RWFRUE_SHOW_FRIEND_REQUEST",eventHandler);
         param1.addEventListener("RWFRUE_HIDE_FRIEND_REQUEST",eventHandler);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWFRUE_SHOW_FRIEND_REQUEST",eventHandler);
         param1.removeEventListener("RWFRUE_HIDE_FRIEND_REQUEST",eventHandler);
      }
      
      private function eventHandler(param1:RoomWidgetFriendRequestUpdateEvent) : void
      {
         if(!param1)
         {
            return;
         }
         switch(param1.type)
         {
            case "RWFRUE_SHOW_FRIEND_REQUEST":
               addRequest(param1.requestId,new FriendRequestDialog(this,param1.requestId,param1.userId,param1.userName));
               break;
            case "RWFRUE_HIDE_FRIEND_REQUEST":
               removeRequest(param1.requestId);
         }
         checkUpdateNeed();
      }
      
      public function checkUpdateNeed() : void
      {
         if(!var_59)
         {
            return;
         }
         if(var_436 && var_436.length > 0)
         {
            var_59.registerUpdateReceiver(this,10);
         }
         else
         {
            var_59.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         if(!var_436)
         {
            return;
         }
         for each(var _loc2_ in var_436)
         {
            if(_loc2_)
            {
               var _loc3_:RoomWidgetUserLocationUpdateEvent = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc2_.userId,1)) as RoomWidgetUserLocationUpdateEvent;
            }
         }
      }
      
      public function acceptRequest(param1:int) : void
      {
         if(!messageListener)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_ACCEPT",param1));
         removeRequest(param1);
      }
      
      public function declineRequest(param1:int) : void
      {
         if(!messageListener)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_DECLINE",param1));
         removeRequest(param1);
      }
      
      public function ignoreRequest(param1:int) : void
      {
         removeRequest(param1);
      }
      
      private function addRequest(param1:int, param2:FriendRequestDialog) : void
      {
         if(!var_436 || !param2)
         {
            return;
         }
         var_436.add(param1,param2);
      }
      
      private function removeRequest(param1:int) : void
      {
         if(!var_436)
         {
            return;
         }
         var _loc2_:FriendRequestDialog = var_436.getValue(param1) as FriendRequestDialog;
         if(!_loc2_)
         {
            return;
         }
         var_436.remove(param1);
         _loc2_.dispose();
         checkUpdateNeed();
      }
      
      public function showProfile(param1:int, param2:String) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",param1,param2));
      }
   }
}

