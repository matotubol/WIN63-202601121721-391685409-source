package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.class_2119;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class PlaneMaskManager
   {
      
      private var var_1373:class_1805 = null;
      
      private var var_324:class_55 = null;
      
      private var var_24:XML = null;
      
      public function PlaneMaskManager()
      {
         super();
         var_324 = new class_55();
      }
      
      public function get data() : XML
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_1373 = null;
         var_24 = null;
         if(var_324 != null)
         {
            var _loc1_:int = 0;
            while(0 < var_324.length)
            {
               var _loc2_:PlaneMask = var_324.getWithIndex(0) as PlaneMask;
               _loc1_++;
            }
            var_324.dispose();
         }
      }
      
      public function initialize(param1:XML) : void
      {
         var_24 = param1;
      }
      
      public function initializeAssetCollection(param1:class_1805) : void
      {
         if(data == null)
         {
            return;
         }
         var_1373 = param1;
         parseMasks(data,param1);
      }
      
      private function parseMasks(param1:XML, param2:class_1805) : void
      {
         var _loc5_:int = 0;
         var _loc16_:XML = null;
         var _loc14_:String = null;
         var _loc15_:PlaneMask = null;
         var _loc9_:XMLList = null;
         var _loc7_:int = 0;
         var _loc13_:XML = null;
         var _loc11_:int = 0;
         var _loc4_:PlaneMaskVisualization = null;
         var _loc3_:XMLList = null;
         var _loc12_:String = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc10_:Array = ["id"];
         var _loc8_:Array = ["size"];
         var _loc6_:XMLList = param1.mask;
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length())
         {
            _loc16_ = _loc6_[_loc5_];
            if(class_2119.checkRequiredAttributes(_loc16_,_loc10_))
            {
               _loc14_ = _loc16_.@id;
               if(var_324.getValue(_loc14_) == null)
               {
                  _loc15_ = new PlaneMask();
                  _loc9_ = _loc16_.maskVisualization;
                  _loc7_ = 0;
                  while(_loc7_ < _loc9_.length())
                  {
                     _loc13_ = _loc9_[_loc7_];
                     if(class_2119.checkRequiredAttributes(_loc13_,_loc8_))
                     {
                        _loc11_ = parseInt(_loc13_.@size);
                        _loc4_ = _loc15_.createMaskVisualization(_loc11_);
                        if(_loc4_ != null)
                        {
                           _loc3_ = _loc13_.bitmap;
                           _loc12_ = parseMaskBitmaps(_loc3_,_loc4_,param2);
                           _loc15_.setAssetName(_loc11_,_loc12_);
                        }
                     }
                     _loc7_++;
                  }
                  var_324.add(_loc14_,_loc15_);
               }
            }
            _loc5_++;
         }
      }
      
      private function parseMaskBitmaps(param1:XMLList, param2:PlaneMaskVisualization, param3:class_1805) : String
      {
         var _loc8_:int = 0;
         var _loc4_:XML = null;
         var _loc6_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:String = null;
         var _loc11_:IGraphicAsset = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc10_:String = null;
         _loc8_ = 0;
         while(_loc8_ < param1.length())
         {
            _loc4_ = param1[_loc8_];
            if(class_2119.checkRequiredAttributes(_loc4_,["assetName"]))
            {
               _loc6_ = -1;
               _loc12_ = 1;
               _loc9_ = -1;
               _loc5_ = 1;
               if(String(_loc4_.@normalMinX) != "")
               {
                  _loc6_ = parseFloat(_loc4_.@normalMinX);
               }
               if(String(_loc4_.@normalMaxX) != "")
               {
                  _loc12_ = parseFloat(_loc4_.@normalMaxX);
               }
               if(String(_loc4_.@normalMinY) != "")
               {
                  _loc9_ = parseFloat(_loc4_.@normalMinY);
               }
               if(String(_loc4_.@normalMaxY) != "")
               {
                  _loc5_ = parseFloat(_loc4_.@normalMaxY);
               }
               _loc7_ = _loc4_.@assetName;
               _loc11_ = param3.getAsset(_loc7_);
               if(_loc11_ != null)
               {
                  if(!_loc11_.flipH)
                  {
                     _loc10_ = _loc7_;
                  }
                  param2.addBitmap(_loc11_,_loc6_,_loc12_,_loc9_,_loc5_);
               }
            }
            _loc8_++;
         }
         return _loc10_;
      }
      
      public function updateMask(param1:BitmapData, param2:String, param3:Number, param4:IVector3d, param5:int, param6:int) : Boolean
      {
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc16_:PlaneMask = var_324.getValue(param2) as PlaneMask;
         if(_loc16_ != null)
         {
            var _loc15_:IGraphicAsset = _loc16_.getGraphicAsset(param3,param4);
            if(_loc15_ != null)
            {
               var _loc9_:BitmapDataAsset = null.asset as BitmapDataAsset;
               if(_loc9_ != null)
               {
                  var _loc10_:BitmapData = null.content as BitmapData;
                  if(_loc10_ != null)
                  {
                     var _loc8_:Point = new Point(param5 + null.offsetX,param6 + null.offsetY);
                     var _loc7_:Matrix = new Matrix();
                     _loc13_ = 1;
                     _loc14_ = 1;
                     _loc12_ = 0;
                     _loc11_ = 0;
                     if(null.flipH)
                     {
                        _loc13_ = -1;
                        _loc12_ = Number(null.width);
                     }
                     if(null.flipV)
                     {
                        _loc14_ = -1;
                        _loc11_ = Number(null.height);
                     }
                     null.scale(_loc13_,_loc14_);
                     null.translate(null.x + _loc12_,null.y + _loc11_);
                     param1.draw(null,null);
                  }
               }
            }
         }
         return true;
      }
      
      public function getMask(param1:String) : PlaneMask
      {
         return var_324.getValue(param1) as PlaneMask;
      }
   }
}

