package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.RoomSessionChatEvent;
   import package_143.class_2894;
   import package_143.class_3484;
   import package_3.class_2334;
   import package_3.class_2405;
   import package_3.class_3009;
   import package_3.class_3234;
   import package_61.class_2390;
   import package_61.class_2655;
   import package_61.class_2790;
   import package_61.class_3394;
   import package_61.class_3619;
   import package_8.class_2615;
   import package_8.class_2929;
   
   public class RoomChatHandler extends BaseHandler
   {
      
      public function RoomChatHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_2390(onRoomChat));
         param1.addMessageEvent(new class_2655(onRoomWhisper));
         param1.addMessageEvent(new class_2790(onRoomShout));
         param1.addMessageEvent(new class_3234(onRespectNotification));
         param1.addMessageEvent(new class_2334(onPetRespectNotification));
         param1.addMessageEvent(new class_3009(onPetSupplementedNotification));
         param1.addMessageEvent(new class_3394(onFloodControl));
         param1.addMessageEvent(new class_2405(onHandItemNotification));
         param1.addMessageEvent(new class_3619(onRemainingMutePeriod));
      }
      
      private function onRoomChat(param1:IMessageEvent) : void
      {
         var _loc2_:class_2390 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_2894 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_2390;
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
         var _loc2_:class_3234 = param1 as class_3234;
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
      
      private function onPetRespectNotification(param1:class_2334) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:class_2615 = param1.getParser();
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
      
      private function onPetSupplementedNotification(param1:class_3009) : void
      {
         if(param1 == null || listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:class_2929 = param1.getParser();
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
      
      private function onHandItemNotification(param1:class_2405) : void
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
      
      private function onRemainingMutePeriod(param1:class_3619) : void
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
         var _loc2_:class_2655 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_2894 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_2655;
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
         var _loc2_:class_2790 = null;
         var _loc4_:IRoomSession = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc3_:class_2894 = null;
         if(listener && listener.events)
         {
            _loc2_ = param1 as class_2790;
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
         var _loc3_:class_3484 = null;
         var _loc4_:IRoomSession = null;
         var _loc2_:int = 0;
         if(listener && listener.events)
         {
            _loc3_ = (param1 as class_3394).getParser();
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

