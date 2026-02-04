package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class class_1929 extends FurnitureMultiStateLogic
   {
      
      private static const STATE_UNINITIALIZED:int = -1;
      
      private static const STATE_UNLOCKED:int = 0;
      
      private static const STATE_LOCKED:int = 1;
      
      private var var_61:int = -1;
      
      public function class_1929()
      {
         super();
      }
      
      protected function get engravingDialogType() : int
      {
         return 0;
      }
      
      override public function get contextMenu() : String
      {
         return var_61 == 0 ? "FRIEND_FURNITURE" : "DUMMY";
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_FRIEND_FURNITURE_ENGRAVING"]);
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         object.getModelController().setNumber("furniture_friendfurni_engraving_type",engravingDialogType);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:StringArrayStuffData = null;
         var _loc3_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.data as StringArrayStuffData;
            if(_loc2_ != null)
            {
               var_61 = _loc2_.state;
            }
            else
            {
               var_61 = _loc3_.state;
            }
         }
         super.processUpdateMessage(param1);
      }
      
      override public function useObject() : void
      {
         if(eventDispatcher != null && object != null)
         {
            if(var_61 == 1)
            {
               eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_FRIEND_FURNITURE_ENGRAVING",object));
            }
            else
            {
               super.useObject();
            }
         }
      }
   }
}

