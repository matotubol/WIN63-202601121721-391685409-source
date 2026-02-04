package com.sulake.habbo.help.cfh.registry.chat
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.freeflowchat.viewer.visualization.style.ChatStyle;
   import com.sulake.habbo.help.HabboHelp;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import package_42.class_1945;
   
   public class ChatEventHandler implements class_13
   {
      
      private var var_59:HabboHelp;
      
      public function ChatEventHandler(param1:HabboHelp)
      {
         super();
         var_59 = param1;
         var_59.roomSessionManager.events.addEventListener("RSCE_CHAT_EVENT",onRoomChat);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_59)
            {
               var_59.roomSessionManager.events.removeEventListener("RSCE_CHAT_EVENT",onRoomChat);
               var_59 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      private function onRoomChat(param1:RoomSessionChatEvent) : void
      {
         var _loc2_:class_2146 = var_59.roomSessionManager.getSession(param1.session.roomId).userDataManager.getUserDataByIndex(param1.userId);
         var _loc3_:class_1945 = var_59.navigator.enteredGuestRoomData;
         if(!_loc2_ || _loc2_.type != 1 || !_loc3_)
         {
            return;
         }
         if(var_59.sessionDataManager.isBlocked(_loc2_.webID))
         {
            return;
         }
         var _loc4_:String = _loc3_ ? _loc3_.roomName : "Unknown Room";
         var _loc5_:ChatStyle = var_59.freeFlowChat.chatStyleLibrary.getStyle(param1.style) as ChatStyle;
         if(!_loc5_.isNotification)
         {
            var_59.chatRegistry.addItem(param1.session.roomId,_loc4_,_loc2_.webID,_loc2_.name,param1.text);
         }
      }
   }
}

