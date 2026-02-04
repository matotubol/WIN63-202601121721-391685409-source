package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.session.events.RoomSessionQueueEvent;
   import package_17.class_3447;
   import package_35.class_1854;
   import package_35.class_2305;
   import package_35.class_2386;
   import package_35.class_3242;
   import package_35.class_3365;
   import package_35.class_3632;
   import package_42.class_3544;
   import package_54.class_2039;
   import package_54.class_2169;
   import package_54.class_2634;
   import package_54.class_2917;
   import package_54.class_3428;
   import package_54.class_3653;
   
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
         param1.addMessageEvent(new class_3653(onRoomConnected));
         param1.addMessageEvent(new class_2634(onFlatAccessible));
         param1.addMessageEvent(new class_2169(onRoomReady));
         param1.addMessageEvent(new class_2039(onRoomDisconnected));
         param1.addMessageEvent(new class_3544(onFlatAccessDenied));
         param1.addMessageEvent(new class_3428(onRoomQueueStatus));
         param1.addMessageEvent(new class_2917(onYouAreSpectator));
      }
      
      private function onRoomConnected(param1:class_3653) : void
      {
         var _loc2_:class_2386 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         if(listener)
         {
            listener.sessionUpdate(_loc2_.flatId,"RS_CONNECTED");
         }
      }
      
      private function onFlatAccessible(param1:class_2634) : void
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:class_3365 = param1.getParser();
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
      
      private function onRoomReady(param1:class_2169) : void
      {
         var _loc2_:class_1854 = param1.getParser();
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
      
      private function onFlatAccessDenied(param1:class_3544) : void
      {
         var _loc3_:IRoomSession = null;
         var _loc2_:class_3447 = param1.getParser();
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
      
      private function onRoomQueueStatus(param1:class_3428) : void
      {
         var _loc5_:class_2305 = null;
         var _loc6_:RoomSessionQueueEvent = null;
         var _loc2_:Array = null;
         if(listener == null || listener.events == null)
         {
            return;
         }
         var _loc3_:class_3632 = param1.getParser();
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
      
      private function onYouAreSpectator(param1:class_2917) : void
      {
         if(listener == null)
         {
            return;
         }
         var _loc2_:class_3242 = param1.getParser();
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

