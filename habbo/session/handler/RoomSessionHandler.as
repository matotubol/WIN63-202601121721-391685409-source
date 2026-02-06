package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionQueueEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatAccessDeniedMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomReadyMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.session.class_2305;
   import com.sulake.habbo.communication.messages.parser.room.session.OpenConnectionMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.session.YouAreSpectatorMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.session.FlatAccessibleMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.room.session.RoomQueueStatusMessageEventParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatAccessDeniedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.FlatAccessibleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.YouAreSpectatorMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomQueueStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.OpenConnectionMessageEvent;
   
   public class RoomSessionHandler extends BaseHandler
   {
      
      public static const const_1178:String = "RS_CONNECTED";
      
      public static const const_242:String = "RS_READY";
      
      public static const const_198:String = "RS_DISCONNECTED";
      
      public function RoomSessionHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new OpenConnectionMessageEvent(onRoomConnected));
         param1.addMessageEvent(new FlatAccessibleMessageEvent(onFlatAccessible));
         param1.addMessageEvent(new RoomReadyMessageEvent(onRoomReady));
         param1.addMessageEvent(new CloseConnectionMessageEvent(onRoomDisconnected));
         param1.addMessageEvent(new FlatAccessDeniedMessageEvent(onFlatAccessDenied));
         param1.addMessageEvent(new RoomQueueStatusMessageEvent(onRoomQueueStatus));
         param1.addMessageEvent(new YouAreSpectatorMessageEvent(onYouAreSpectator));
      }
      
      private function onRoomConnected(param1:OpenConnectionMessageEvent) : void
      {
         var _loc2_:OpenConnectionMessageEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(listener)
         {
            listener.sessionUpdate(_loc2_.flatId,"RS_CONNECTED");
         }
      }
      
      private function onFlatAccessible(param1:FlatAccessibleMessageEvent) : void
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:FlatAccessibleMessageEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = _loc2_.userName;
         if(_loc4_ != null && _loc4_.length > 0)
         {
            if(listener && listener.events)
            {
               _loc3_ = listener.getSession(_loc2_.flatId);
               if(_loc3_ != null)
               {
                  listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_ACCEPTED",_loc3_,_loc4_));
               }
            }
         }
      }
      
      private function onRoomReady(param1:RoomReadyMessageEvent) : void
      {
         var _loc2_:RoomReadyMessageEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = _loc2_.roomId;
         ErrorReportStorage.addDebugData("RoomID","Room id: " + _loc3_);
         if(listener)
         {
            listener.sessionReinitialize(_loc3_,_loc3_);
            listener.sessionUpdate(_loc3_,"RS_READY");
         }
      }
      
      private function onFlatAccessDenied(param1:FlatAccessDeniedMessageEvent) : void
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:FlatAccessDeniedMessageEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = _loc2_.userName;
         if(_loc4_ == null || _loc4_.length == 0)
         {
            if(listener)
            {
               listener.sessionUpdate(_loc2_.flatId,"RS_DISCONNECTED");
            }
         }
         else if(listener && listener.events)
         {
            _loc3_ = listener.getSession(_loc2_.flatId);
            if(_loc3_ != null)
            {
               listener.events.dispatchEvent(new RoomSessionDoorbellEvent("RSDE_REJECTED",_loc3_,_loc4_));
            }
         }
      }
      
      private function onRoomDisconnected(param1:IMessageEvent) : void
      {
         var _loc2_:int = var_56;
         ErrorReportStorage.addDebugData("RoomID","");
         if(listener)
         {
            listener.sessionUpdate(_loc2_,"RS_DISCONNECTED");
         }
      }
      
      private function onRoomQueueStatus(param1:RoomQueueStatusMessageEvent) : void
      {
         var _loc5_:class_2305 = null;
         var _loc6_:RoomSessionQueueEvent = null;
         var _loc2_:Array = null;
         if(listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:RoomQueueStatusMessageEventParser = param1.getParser();
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomSession = listener.getSession(_loc3_.flatId);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:Array = _loc3_.getQueueSetTargets();
         var _loc9_:int = _loc3_.activeTarget;
         for each(var _loc10_ in _loc8_)
         {
            _loc5_ = _loc3_.getQueueSet(_loc10_);
            _loc6_ = new RoomSessionQueueEvent(_loc4_,_loc5_.name,_loc5_.target,_loc5_.target == _loc9_);
            _loc2_ = _loc5_.queueTypes;
            for each(var _loc7_ in _loc2_)
            {
               _loc6_.addQueue(_loc7_,_loc5_.getQueueSize(_loc7_));
            }
            listener.events.dispatchEvent(_loc6_);
         }
      }
      
      private function onYouAreSpectator(param1:YouAreSpectatorMessageEvent) : void
      {
         if(listener == null)
         {
            return;
         }
         var _loc2_:YouAreSpectatorMessageEventParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:IRoomSession = listener.getSession(_loc2_.flatId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.isSpectatorMode = true;
      }
   }
}

