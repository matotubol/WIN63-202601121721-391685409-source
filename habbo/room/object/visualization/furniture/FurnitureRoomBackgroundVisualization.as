package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.visualization.data.class_2427;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class FurnitureRoomBackgroundVisualization extends FurnitureRoomBrandingVisualization
   {
      
      private var var_1264:Dictionary;
      
      public function FurnitureRoomBackgroundVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_1264 = null;
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return null;
      }
      
      override protected function imageReady(param1:BitmapData, param2:String) : void
      {
         super.imageReady(param1,param2);
         if(param1 != null)
         {
            var_1264 = new Dictionary();
            var _loc4_:int = 64;
            var _loc3_:int = param1.width;
            var _loc5_:int = param1.height;
            addDirectionalOffsets(0,0,0);
            _loc4_ = 32;
            _loc3_ = 0 / 2;
            _loc5_ = 0 / 2;
            addDirectionalOffsets(0,0,0);
         }
      }
      
      private function addDirectionalOffsets(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:class_2427 = new class_2427();
         _loc4_.setOffset(1,0,-param2);
         _loc4_.setOffset(3,0,0);
         _loc4_.setOffset(5,-param3,0);
         _loc4_.setOffset(7,-param3,-param2);
         _loc4_.setOffset(4,-param3 / 2,-param2 / 2);
         var_1264[param1] = _loc4_;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(var_1264 != null)
         {
            var _loc5_:int = getSize(param1);
            var _loc4_:class_2427 = var_1264[0];
            if(_loc4_ != null)
            {
               return null.getOffsetX(param2,0) + getScaledOffset(var_3031,param1);
            }
         }
         return super.getSpriteXOffset(param1,param2,param3) + getScaledOffset(var_3031,param1);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(var_1264 != null)
         {
            var _loc5_:int = getSize(param1);
            var _loc4_:class_2427 = var_1264[0];
            if(_loc4_ != null)
            {
               return null.getOffsetY(param2,0) + getScaledOffset(var_2852,param1);
            }
         }
         return super.getSpriteYOffset(param1,param2,param3) + getScaledOffset(var_2852,param1);
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         return super.getSpriteZOffset(param1,param2,param3) + var_3531 * -1;
      }
      
      override protected function getSpriteMouseCapture(param1:int, param2:int, param3:int) : Boolean
      {
         return false;
      }
      
      private function getScaledOffset(param1:int, param2:int) : Number
      {
         return param1 * param2 / 64;
      }
   }
}

