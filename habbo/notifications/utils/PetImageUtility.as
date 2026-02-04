package com.sulake.habbo.notifications.utils
{
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class PetImageUtility
   {
      
      private static var _roomEngine:IRoomEngine;
      
      public function PetImageUtility(param1:IRoomEngine)
      {
         super();
         _roomEngine = param1;
      }
      
      public function dispose() : void
      {
         _roomEngine = null;
      }
      
      public function getPetImage(param1:int, param2:int, param3:String, param4:int = 3, param5:Boolean = false, param6:int = 32, param7:String = null) : BitmapData
      {
         if(_roomEngine == null)
         {
            class_21.log("Pet Image Utility; Pet image creation failed: Room engine is not defined");
            return null;
         }
         var _loc8_:BitmapData = null;
         if(param1 < 0 || param2 < 0)
         {
            return _loc8_;
         }
         var _loc9_:uint = parseInt(param3,16);
         var _loc11_:class_2198 = _roomEngine.getPetImage(param1,param2,_loc9_,new Vector3d(45 * param4),param6,null,param5,0,null,param7);
         if(_loc11_ != null)
         {
            _loc8_ = _loc11_.data;
         }
         return _loc8_;
      }
   }
}

