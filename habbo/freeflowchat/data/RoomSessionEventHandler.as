package com.sulake.habbo.freeflowchat.data
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   
   public class RoomSessionEventHandler implements class_13
   {
      
      private var var_59:HabboFreeFlowChat;
      
      public function RoomSessionEventHandler(param1:HabboFreeFlowChat)
      {
         super();
         var_59 = param1;
         var_59.roomSessionManager.events.addEventListener("RSE_CREATED",onRoomSessionCreated);
         var_59.roomSessionManager.events.addEventListener("RSE_ENDED",onRoomSessionEnded);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_59)
            {
               var_59.roomSessionManager.events.removeEventListener("RSE_CREATED",onRoomSessionCreated);
               var_59.roomSessionManager.events.removeEventListener("RSE_ENDED",onRoomSessionEnded);
               var_59 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      private function onRoomSessionCreated(param1:RoomSessionEvent) : void
      {
         var_59.roomEntered();
      }
      
      private function onRoomSessionEnded(param1:RoomSessionEvent) : void
      {
         var_59.roomLeft();
      }
   }
}

