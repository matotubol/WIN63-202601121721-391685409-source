package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneVisualizationAnimationLayer implements class_13
   {
      
      private var _color:uint = 0;
      
      private var _bitmapData:BitmapData = null;
      
      private var var_1134:Boolean = false;
      
      private var _items:Array = [];
      
      public function PlaneVisualizationAnimationLayer(param1:XML, param2:class_1805)
      {
         super();
         if(param1 != null && param2 != null)
         {
            var _loc10_:XMLList = param1.item;
            var _loc6_:int = 0;
            while(0 < null.length())
            {
               var _loc3_:XML = null[0] as XML;
               _loc6_++;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(_items != null)
         {
            var _loc2_:int = 0;
            while(0 < _items.length)
            {
               var _loc1_:AnimationItem = _items[0] as AnimationItem;
               _loc2_++;
            }
            _items = [];
         }
      }
      
      public function clearCache() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:int, param6:int, param7:int, param8:int, param9:Number, param10:Number, param11:int) : BitmapData
      {
         var _loc14_:int = 0;
         var _loc13_:AnimationItem = null;
         var _loc12_:Point = null;
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            if(_bitmapData == null || _bitmapData.width != param2 || _bitmapData.height != param3)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
               }
               _bitmapData = new BitmapData(param2,param3,true,16777215);
            }
            else
            {
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            param1 = _bitmapData;
         }
         if(param7 > 0 && param8 > 0)
         {
            _loc14_ = 0;
            while(_loc14_ < _items.length)
            {
               _loc13_ = _items[_loc14_] as AnimationItem;
               if(_loc13_ != null)
               {
                  _loc12_ = _loc13_.getPosition(param7,param8,param9,param10,param11);
                  _loc12_.x = _loc12_.x - param5;
                  _loc12_.y -= param6;
                  if(_loc13_.bitmapData != null)
                  {
                     if(_loc12_.x > -_loc13_.bitmapData.width && _loc12_.x < param1.width && _loc12_.y > -_loc13_.bitmapData.height && _loc12_.y < param1.height)
                     {
                        param1.copyPixels(_loc13_.bitmapData,_loc13_.bitmapData.rect,_loc12_,null,null,true);
                     }
                     if(_loc12_.x - param7 > -_loc13_.bitmapData.width && _loc12_.x - param7 < param1.width && _loc12_.y > -_loc13_.bitmapData.height && _loc12_.y < param1.height)
                     {
                        param1.copyPixels(_loc13_.bitmapData,_loc13_.bitmapData.rect,new Point(_loc12_.x - param7,_loc12_.y),null,null,true);
                     }
                     if(_loc12_.x > -_loc13_.bitmapData.width && _loc12_.x < param1.width && _loc12_.y - param8 > -_loc13_.bitmapData.height && _loc12_.y - param8 < param1.height)
                     {
                        param1.copyPixels(_loc13_.bitmapData,_loc13_.bitmapData.rect,new Point(_loc12_.x,_loc12_.y - param8),null,null,true);
                     }
                     if(_loc12_.x - param7 > -_loc13_.bitmapData.width && _loc12_.x - param7 < param1.width && _loc12_.y - param8 > -_loc13_.bitmapData.height && _loc12_.y - param8 < param1.height)
                     {
                        param1.copyPixels(_loc13_.bitmapData,_loc13_.bitmapData.rect,new Point(_loc12_.x - param7,_loc12_.y - param8),null,null,true);
                     }
                  }
               }
               _loc14_++;
            }
         }
         return param1;
      }
   }
}

