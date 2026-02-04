package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectSamplePlaybackEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class class_2033 extends FurnitureMultiStateLogic
   {
      
      private static const const_193:int = 12;
      
      private static const const_1182:int = -12;
      
      private static const STATE_UNINITIALIZED:int = -1;
      
      private var var_61:int = -1;
      
      private var var_2677:int = -1;
      
      private var var_4739:Boolean = false;
      
      private var var_2837:Number = 0;
      
      public function class_2033()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(var_61 != -1)
         {
            eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_ROOM_OBJECT_DISPOSED",object,var_2677));
         }
         super.dispose();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROPSPE_PLAY_SAMPLE","ROPSPE_ROOM_OBJECT_DISPOSED","ROPSPE_ROOM_OBJECT_INITIALIZED"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.sound;
         if(_loc2_.length() == 0)
         {
            return;
         }
         var _loc3_:XMLList = param1.sound.sample;
         if(_loc3_.length() == 0)
         {
            return;
         }
         var_2677 = int(_loc3_.@id);
         var_4739 = _loc3_.@nopitch == "true";
         object.getModelController().setNumber("furniture_soundblock_relative_animation_speed",1);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         super.processUpdateMessage(param1);
         var _loc2_:IVector3d = object.getLocation();
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            if(var_61 == -1 && object.getModelController().getNumber("furniture_real_room_object") == 1)
            {
               var_2837 = _loc2_.z;
               eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_ROOM_OBJECT_INITIALIZED",object,var_2677,getPitchForHeight(_loc2_.z)));
            }
            if(var_61 != -1 && _loc2_ != null)
            {
               if(var_2837 != _loc2_.z)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_CHANGE_PITCH",object,var_2677,getPitchForHeight(_loc2_.z)));
                  var_2837 = _loc2_.z;
               }
            }
            if(var_61 != -1 && _loc3_.state != var_61 && _loc2_ != null)
            {
               playSoundAt(_loc2_.z);
            }
            var_61 = _loc3_.state;
         }
      }
      
      private function playSoundAt(param1:Number) : void
      {
         var _loc2_:Number = getPitchForHeight(param1);
         object.getModelController().setNumber("furniture_soundblock_relative_animation_speed",_loc2_);
         eventDispatcher.dispatchEvent(new RoomObjectSamplePlaybackEvent("ROPSPE_PLAY_SAMPLE",object,var_2677,_loc2_));
      }
      
      private function getPitchForHeight(param1:Number) : Number
      {
         var _loc2_:int = param1 * 2;
         if(_loc2_ > 12)
         {
            _loc2_ = Math.min(0,-12 + (_loc2_ - 12 - 1));
         }
         return var_4739 ? 1 : Math.pow(2,_loc2_ / 12);
      }
   }
}

