package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.class_2119;
   
   public class FurnitureExternalImageLogic extends FurnitureMultiStateLogic
   {
      
      public function FurnitureExternalImageLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROWRE__STICKIE","ROFCAE_STICKIE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function get widget() : String
      {
         return "RWE_EXTERNAL_IMAGE";
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc2_:String = null;
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc3_:XMLList = param1.mask;
         if(_loc3_.length() > 0)
         {
            _loc4_ = _loc3_[0];
            if(class_2119.checkRequiredAttributes(_loc4_,["type"]))
            {
               _loc2_ = _loc4_.@type;
               object.getModelController().setNumber("furniture_uses_plane_mask",1,true);
               object.getModelController().setString("furniture_plane_mask_type",_loc2_,true);
            }
         }
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc3_:* = param1.type;
         if("doubleClick" !== _loc3_)
         {
            super.mouseEvent(param1,param2);
         }
         else
         {
            useObject();
         }
      }
   }
}

