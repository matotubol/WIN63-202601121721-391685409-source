package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectPlaySoundIdEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class FurnitureCuckooClockLogic extends FurnitureMultiStateLogic
   {
      
      private var var_61:int = -1;
      
      private var var_190:IVector3d;
      
      public function FurnitureCuckooClockLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROPSIE_PLAY_SOUND_AT_PITCH"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc2_ != null)
         {
            if(var_61 != -1 && _loc2_.state != var_61)
            {
               playSoundAt(var_190.z);
            }
            var_61 = _loc2_.state;
         }
         else
         {
            var_190 = param1.loc;
         }
      }
      
      private function playSoundAt(param1:Number) : void
      {
         var _loc2_:Number = Math.pow(2,param1 - 1.2);
         eventDispatcher.dispatchEvent(new RoomObjectPlaySoundIdEvent("ROPSIE_PLAY_SOUND_AT_PITCH",object,"FURNITURE_cuckoo_clock",_loc2_));
      }
   }
}

