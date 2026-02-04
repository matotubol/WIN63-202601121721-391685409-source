package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.object.visualization.data.SizeData;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.utils.class_2119;
   
   public class FurnitureVisualizationData implements IRoomObjectVisualizationData
   {
      
      public static const LAYER_LIMIT:int = 1000;
      
      public static const LAYER_NAMES:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
      
      private var var_640:class_55;
      
      private var var_467:Array = [];
      
      private var var_1119:SizeData = null;
      
      private var var_2754:int = -1;
      
      private var var_3517:int = -1;
      
      private var var_4566:int = -1;
      
      private var var_230:String = "";
      
      public function FurnitureVisualizationData()
      {
         super();
         var_640 = new class_55();
      }
      
      public function dispose() : void
      {
         var _loc1_:SizeData = null;
         var _loc2_:int = 0;
         if(var_640 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < var_640.length)
            {
               _loc1_ = var_640.getWithIndex(_loc2_) as SizeData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_640.dispose();
            var_640 = null;
         }
         var_1119 = null;
         var_467 = null;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         reset();
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = param1.@type;
         if(_loc2_.length == 0)
         {
            return false;
         }
         var_230 = _loc2_;
         if(!defineVisualizations(param1))
         {
            reset();
            return false;
         }
         return true;
      }
      
      protected function reset() : void
      {
         var_230 = "";
         var _loc1_:SizeData = null;
         var _loc2_:int = 0;
         while(0 < var_640.length)
         {
            _loc1_ = var_640.getWithIndex(0) as SizeData;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         var_640.reset();
         var_467 = [];
         var_1119 = null;
         var_2754 = -1;
      }
      
      protected function defineVisualizations(param1:XML) : Boolean
      {
         var _loc7_:int = 0;
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:SizeData = null;
         var _loc5_:XMLList = null;
         var _loc9_:int = 0;
         var _loc12_:XML = null;
         var _loc10_:XMLList = param1.graphics.visualization;
         if(_loc10_.length() == 0)
         {
            return false;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length())
         {
            _loc2_ = _loc10_[_loc7_];
            if(!class_2119.checkRequiredAttributes(_loc2_,["size","layerCount","angle"]))
            {
               return false;
            }
            _loc3_ = int(_loc2_.@size);
            _loc4_ = int(_loc2_.@layerCount);
            _loc8_ = int(_loc2_.@angle);
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            if(var_640.getValue(String(_loc3_)) != null)
            {
               return false;
            }
            _loc11_ = createSizeData(_loc3_,_loc4_,_loc8_);
            if(_loc11_ == null)
            {
               return false;
            }
            _loc5_ = _loc2_.children();
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length())
            {
               _loc12_ = _loc5_[_loc9_];
               if(!processVisualizationElement(_loc11_,_loc12_))
               {
                  _loc11_.dispose();
                  return false;
               }
               _loc9_++;
            }
            var_640.add(String(_loc3_),_loc11_);
            var_467.push(_loc3_);
            var_467.sort(16);
            _loc7_++;
         }
         return true;
      }
      
      protected function createSizeData(param1:int, param2:int, param3:int) : SizeData
      {
         var _loc4_:SizeData = null;
         return new SizeData(param2,param3);
      }
      
      protected function processVisualizationElement(param1:SizeData, param2:XML) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         switch(String(param2.name()))
         {
            case "layers":
               if(!param1.defineLayers(param2))
               {
                  return false;
               }
               break;
            case "directions":
               if(!param1.defineDirections(param2))
               {
                  return false;
               }
               break;
            case "colors":
               if(!param1.defineColors(param2))
               {
                  return false;
               }
         }
         return true;
      }
      
      public function getType() : String
      {
         return var_230;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         if(param1 > 0)
         {
            _loc3_ = 1;
            while(_loc3_ < var_467.length)
            {
               if(var_467[_loc3_] > param1)
               {
                  if(var_467[_loc3_] / param1 < param1 / var_467[_loc3_ - 1])
                  {
                     _loc2_ = _loc3_;
                  }
                  break;
               }
               _loc2_ = _loc3_;
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function getSize(param1:int) : int
      {
         if(param1 == var_4566)
         {
            return var_3517;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < var_467.length)
         {
            var _loc3_:int = int(var_467[_loc2_]);
         }
         var_4566 = param1;
         var_3517 = -1;
         return -1;
      }
      
      public function getLayerCount(param1:int) : int
      {
         var _loc2_:SizeData = getSizeData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.layerCount;
         }
         return 0;
      }
      
      public function getDirectionValue(param1:int, param2:int) : int
      {
         var _loc3_:SizeData = getSizeData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getDirectionValue(param2);
         }
         return 0;
      }
      
      public function getTag(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getTag(param2,param3);
         }
         return "";
      }
      
      public function getInk(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getInk(param2,param3);
         }
         return 0;
      }
      
      public function getAlpha(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getAlpha(param2,param3);
         }
         return 255;
      }
      
      public function getColor(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getColor(param2,param3);
         }
         return 16777215;
      }
      
      public function getIgnoreMouse(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getIgnoreMouse(param2,param3);
         }
         return false;
      }
      
      public function getXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getXOffset(param2,param3);
         }
         return 0;
      }
      
      public function getYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getYOffset(param2,param3);
         }
         return 0;
      }
      
      public function getZOffset(param1:int, param2:int, param3:int) : Number
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getZOffset(param2,param3);
         }
         return 0;
      }
      
      protected function getSizeData(param1:int) : SizeData
      {
         if(param1 == var_2754)
         {
            return var_1119;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < var_467.length)
         {
            var_1119 = var_640.getValue(String(var_467[_loc2_])) as SizeData;
         }
         else
         {
            var_1119 = null;
         }
         var_2754 = param1;
         return var_1119;
      }
   }
}

