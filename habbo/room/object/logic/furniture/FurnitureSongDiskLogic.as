package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class FurnitureSongDiskLogic extends class_1738
   {
      
      public function FurnitureSongDiskLogic()
      {
         super();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         super.processUpdateMessage(param1);
         if(object == null)
         {
            return;
         }
         if(object.getModelController().getNumber("furniture_real_room_object") == 1)
         {
            _loc2_ = object.getModelController().getString("furniture_extras");
            _loc3_ = int(_loc2_);
            object.getModelController().setString("RWEIEP_INFOSTAND_EXTRA_PARAM","RWEIEP_SONGDISK" + _loc3_);
         }
      }
   }
}

