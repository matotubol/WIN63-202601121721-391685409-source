package com.sulake.habbo.room.object.visualization.data
{
   public class DirectionData
   {
      
      public static const USE_DEFAULT_DIRECTION:int = -1;
      
      private var _layers:Array = [];
      
      public function DirectionData(param1:int)
      {
         super();
         var _loc2_:int = 0;
         while(0 < param1)
         {
            var _loc3_:class_3474 = new class_3474();
            _layers.push(null);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         _layers = null;
      }
      
      public function get layerCount() : int
      {
         return _layers.length;
      }
      
      private function getLayer(param1:int) : class_3474
      {
         if(param1 < 0 || param1 >= layerCount)
         {
            return null;
         }
         return _layers[param1];
      }
      
      public function getTag(param1:int) : String
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.tag;
         }
         return "";
      }
      
      public function setTag(param1:int, param2:String) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.tag = param2;
         }
      }
      
      public function getInk(param1:int) : int
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.ink;
         }
         return 0;
      }
      
      public function setInk(param1:int, param2:int) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.ink = param2;
         }
      }
      
      public function getAlpha(param1:int) : int
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.alpha;
         }
         return 255;
      }
      
      public function setAlpha(param1:int, param2:int) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.alpha = param2;
         }
      }
      
      public function getIgnoreMouse(param1:int) : Boolean
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.ignoreMouse;
         }
         return false;
      }
      
      public function setIgnoreMouse(param1:int, param2:Boolean) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.ignoreMouse = param2;
         }
      }
      
      public function getXOffset(param1:int) : int
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.xOffset;
         }
         return 0;
      }
      
      public function setXOffset(param1:int, param2:int) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.xOffset = param2;
         }
      }
      
      public function getYOffset(param1:int) : int
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.yOffset;
         }
         return 0;
      }
      
      public function setYOffset(param1:int, param2:int) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.yOffset = param2;
         }
      }
      
      public function getZOffset(param1:int) : Number
      {
         var _loc2_:class_3474 = getLayer(param1);
         if(_loc2_ != null)
         {
            return _loc2_.zOffset;
         }
         return 0;
      }
      
      public function setZOffset(param1:int, param2:Number) : void
      {
         var _loc3_:class_3474 = getLayer(param1);
         if(_loc3_ != null)
         {
            _loc3_.zOffset = param2;
         }
      }
      
      public function copyValues(param1:DirectionData) : void
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(layerCount != param1.layerCount)
         {
            return;
         }
         var _loc4_:class_3474 = null;
         var _loc2_:class_3474 = null;
         _loc3_ = 0;
         while(_loc3_ < layerCount)
         {
            _loc4_ = getLayer(_loc3_);
            _loc2_ = param1.getLayer(_loc3_);
            if(_loc4_)
            {
               _loc4_.copyValues(_loc2_);
            }
            _loc3_++;
         }
      }
   }
}

