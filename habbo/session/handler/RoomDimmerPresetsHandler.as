package com.sulake.habbo.session.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.session.IRoomHandlerListener;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.events.RoomSessionDimmerPresetsEvent;
   import package_100.class_3337;
   import package_100.class_3344;
   import package_91.class_2648;
   
   public class RoomDimmerPresetsHandler extends BaseHandler
   {
      
      public function RoomDimmerPresetsHandler(param1:IConnection, param2:IRoomHandlerListener)
      {
         super(param1,param2);
         if(param1 == null)
         {
            return;
         }
         param1.addMessageEvent(new class_3337(onRoomDimmerPresets));
      }
      
      private function onRoomDimmerPresets(param1:IMessageEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:class_3344 = null;
         var _loc5_:class_3337 = param1 as class_3337;
         if(_loc5_ == null || _loc5_.getParser() == null)
         {
            return;
         }
         var _loc2_:class_2648 = _loc5_.getParser();
         var _loc3_:IRoomSession = listener.getSession(var_56);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc7_:RoomSessionDimmerPresetsEvent = new RoomSessionDimmerPresetsEvent("RSDPE_PRESETS",_loc3_);
         _loc7_.selectedPresetId = _loc2_.selectedPresetId;
         _loc7_.itemId = _loc2_.itemId;
         _loc7_.isOn = _loc2_.isOn;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.presetCount)
         {
            _loc6_ = _loc2_.getPreset(_loc4_);
            if(_loc6_ != null)
            {
               _loc7_.storePreset(_loc6_.id,_loc6_.type,_loc6_.color,_loc6_.light);
            }
            _loc4_++;
         }
         if(listener && listener.events)
         {
            listener.events.dispatchEvent(_loc7_);
         }
      }
   }
}

