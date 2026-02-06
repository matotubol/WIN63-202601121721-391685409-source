package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.users.PetRespectNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HandItemReceivedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.PetSupplementedNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.users.RespectNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ChatMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.ShoutMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.FloodControlMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.RemainingMutePeriodEvent;
   import com.sulake.habbo.communication.messages.parser.users.PetRespectNotificationEventParser;
   import com.sulake.habbo.communication.messages.parser.users.PetSupplementedNotificationEventParser;
   
   public class RoomChatHandler extends BaseHandler
   {
      
      public function RoomChatHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new ChatMessageEvent(onRoomChat));
         param1.addMessageEvent(new WhisperMessageEvent(onRoomWhisper));
         param1.addMessageEvent(new ShoutMessageEvent(onRoomShout));
         param1.addMessageEvent(new RespectNotificationMessageEvent(onRespectNotification));
         param1.addMessageEvent(new PetRespectNotificationEvent(onPetRespectNotification));
         param1.addMessageEvent(new PetSupplementedNotificationEvent(onPetSupplementedNotification));
         param1.addMessageEvent(new FloodControlMessageEvent(onFloodControl));
         param1.addMessageEvent(new HandItemReceivedMessageEvent(onHandItemNotification));
         param1.addMessageEvent(new RemainingMutePeriodEvent(onRemainingMutePeriod));
      }
      
      private function onRoomChat(param1:IMessageEvent) : void
      {
         var _loc2_:ChatMessageEvent = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:ChatMessageEventParser = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as ChatMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc4_ = listener.getSession(var_56);
               if(_loc4_ == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 0;
               _loc3_ = _loc2_.getParser();
               if(_loc3_.trackingId != -1)
               {
                  _loc4_.receivedChatWithTrackingId(_loc3_.trackingId);
               }
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onRespectNotification(param1:IMessageEvent) : void
      {
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc7_:int = 0;
         var _loc3_:class_2146 = null;
         var _loc6_:String = null;
         var _loc2_:RespectNotificationMessageEvent = param1 as RespectNotificationMessageEvent;
         if(listener && listener.events)
         {
            _loc4_ = listener.getSession(var_56);
            if(_loc4_ == null)
            {
               return;
            }
            _loc5_ = "RSCE_CHAT_EVENT";
            _loc7_ = 3;
            _loc3_ = _loc4_.userDataManager.getUserData(_loc2_.userId);
            if(_loc3_ == null)
            {
               return;
            }
            _loc6_ = "";
            listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.roomObjectId,_loc6_,_loc7_,1));
         }
      }
      
      private function onPetRespectNotification(param1:PetRespectNotificationEvent) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:PetRespectNotificationEventParser = param1.getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc6_:int = 4;
         if(_loc3_.isTreat())
         {
            _loc6_ = 6;
         }
         var _loc2_:class_2146 = _loc4_.userDataManager.getPetUserData(_loc3_.petData.id);
         if(_loc2_ == null)
         {
            return;
         }
         listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc4_,_loc2_.roomObjectId,"",_loc6_,1));
      }
      
      private function onPetSupplementedNotification(param1:PetSupplementedNotificationEvent) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:PetSupplementedNotificationEventParser = param1.getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomSession = listener.getSession(var_56);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:int = 7;
         switch(_loc3_.supplementType - 2)
         {
            case 0:
               _loc8_ = 7;
               break;
            case 1:
               _loc8_ = 8;
               break;
            case 2:
               _loc8_ = 9;
         }
         var _loc2_:class_2146 = _loc4_.userDataManager.getPetUserData(_loc3_.petId);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc6_:int = -1;
         var _loc5_:class_2146 = _loc4_.userDataManager.getUserData(_loc3_.userId);
         if(_loc5_ != null)
         {
            _loc6_ = _loc5_.roomObjectId;
         }
         listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc4_,_loc2_.roomObjectId,"",_loc8_,1,null,_loc6_));
      }
      
      private function onHandItemNotification(param1:HandItemReceivedMessageEvent) : void
      {
         var _loc2_:IRoomSession = null;
         if(listener && listener.events)
         {
            _loc2_ = listener.getSession(var_56);
            if(_loc2_)
            {
               listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc2_,param1.giverUserId,"",5,1,null,param1.handItemType));
            }
         }
      }
      
      private function onRemainingMutePeriod(param1:RemainingMutePeriodEvent) : void
      {
         var _loc2_:IRoomSession = null;
         if(listener && listener.events)
         {
            _loc2_ = listener.getSession(var_56);
            if(_loc2_)
            {
               listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_CHAT_EVENT",_loc2_,_loc2_.ownUserRoomId,"",10,1,null,param1.secondsRemaining));
            }
         }
      }
      
      private function onRoomWhisper(param1:IMessageEvent) : void
      {
         var _loc2_:WhisperMessageEvent = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:ChatMessageEventParser = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as WhisperMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc4_ = listener.getSession(var_56);
               if(_loc4_ == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 1;
               _loc3_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onRoomShout(param1:IMessageEvent) : void
      {
         var _loc2_:ShoutMessageEvent = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:ChatMessageEventParser = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as ShoutMessageEvent;
            if(_loc2_ && _loc2_.getParser())
            {
               _loc4_ = listener.getSession(var_56);
               if(_loc4_ == null)
               {
                  return;
               }
               _loc5_ = "RSCE_CHAT_EVENT";
               _loc6_ = 2;
               _loc3_ = _loc2_.getParser();
               listener.events.dispatchEvent(new RoomSessionChatEvent(_loc5_,_loc4_,_loc3_.userId,_loc3_.text,_loc6_,_loc3_.styleId,_loc3_.links));
            }
         }
      }
      
      private function onFloodControl(param1:IMessageEvent) : void
      {
         var _loc3_:FloodControlMessageEventParser = null;
         var _loc4_:IRoomSession = null;
         var _loc2_:int = 0;
         if(listener && listener.events)
         {
            _loc3_ = (param1 as FloodControlMessageEvent).getParser();
            _loc4_ = listener.getSession(var_56);
            if(_loc4_ == null)
            {
               return;
            }
            _loc2_ = _loc3_.seconds;
            class_21.log("received flood control event for " + _loc2_ + " seconds");
            listener.events.dispatchEvent(new RoomSessionChatEvent("RSCE_FLOOD_EVENT",_loc4_,-1,"" + _loc2_,0,0,null));
         }
      }
   }
}

