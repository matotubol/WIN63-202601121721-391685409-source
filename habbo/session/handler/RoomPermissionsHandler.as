package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreNotControllerMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.permissions.YouAreControllerMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreOwnerMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreNotControllerMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
   
   public class RoomPermissionsHandler extends BaseHandler
   {
      
      public function RoomPermissionsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new YouAreControllerMessageEvent(onYouAreController));
         param1.addMessageEvent(new YouAreNotControllerMessageEvent(onYouAreNotController));
         param1.addMessageEvent(new YouAreOwnerMessageEvent(onYouAreOwner));
      }
      
      private function onYouAreController(param1:IMessageEvent) : void
      {
         var _loc4_:YouAreControllerMessageEvent = param1 as YouAreControllerMessageEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:YouAreControllerMessageEventParser = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = _loc2_.roomControllerLevel;
      }
      
      private function onYouAreNotController(param1:IMessageEvent) : void
      {
         var _loc4_:YouAreNotControllerMessageEvent = param1 as YouAreNotControllerMessageEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:YouAreNotControllerMessageEventParser = _loc4_.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.roomControllerLevel = 0;
      }
      
      private function onYouAreOwner(param1:IMessageEvent) : void
      {
         var _loc3_:YouAreOwnerMessageEvent = param1 as YouAreOwnerMessageEvent;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IRoomSession = listener.getSession(var_56);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.isRoomOwner = true;
      }
   }
}

