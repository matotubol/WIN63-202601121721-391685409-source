package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class FurnitureSoundMachineLogic extends FurnitureMultiStateLogic
   {
      
      private var var_2741:Boolean;
      
      private var var_265:Boolean = false;
      
      private var var_1857:int = -1;
      
      public function FurnitureSoundMachineLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFCAE_SOUND_MACHINE_START","ROFCAE_SOUND_MACHINE_STOP","ROFCAE_SOUND_MACHINE_DISPOSE","ROFCAE_SOUND_MACHINE_INIT"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function dispose() : void
      {
         requestDispose();
         super.dispose();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:RoomObjectDataUpdateMessage = null;
         var _loc2_:int = 0;
         super.processUpdateMessage(param1);
         if(object == null)
         {
            return;
         }
         if(object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            if(!var_265)
            {
               requestInitialize();
            }
            _loc3_ = param1 as RoomObjectDataUpdateMessage;
            if(_loc3_ == null)
            {
               return;
            }
            _loc2_ = int(object.getState(0));
            if(_loc2_ != var_1857)
            {
               var_1857 = _loc2_;
               if(_loc2_ == 1)
               {
                  requestPlayList();
               }
               else if(_loc2_ == 0)
               {
                  requestStopPlaying();
               }
            }
         }
      }
      
      private function requestInitialize() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var_2741 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_INIT",object);
         eventDispatcher.dispatchEvent(_loc1_);
         var_265 = true;
      }
      
      private function requestPlayList() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var_2741 = true;
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_START",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestStopPlaying() : void
      {
         if(object == null || eventDispatcher == null)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_STOP",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
      
      private function requestDispose() : void
      {
         if(!var_2741)
         {
            return;
         }
         var _loc1_:RoomObjectFurnitureActionEvent = new RoomObjectFurnitureActionEvent("ROFCAE_SOUND_MACHINE_DISPOSE",object);
         eventDispatcher.dispatchEvent(_loc1_);
      }
   }
}

