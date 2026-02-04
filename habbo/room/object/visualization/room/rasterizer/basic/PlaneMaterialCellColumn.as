package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneMaterialCellColumn
   {
      
      public static const REPEAT_MODE_NONE:int = 0;
      
      public static const REPEAT_MODE_ALL:int = 1;
      
      public static const REPEAT_MODE_BORDERS:int = 2;
      
      public static const REPEAT_MODE_CENTER:int = 3;
      
      public static const REPEAT_MODE_FIRST:int = 4;
      
      public static const REPEAT_MODE_LAST:int = 5;
      
      private var _cells:Array = [];
      
      private var var_3138:int = 1;
      
      private var _width:int = 1;
      
      private var var_53:BitmapData;
      
      private var _cachedBitmapNormal:Vector3d = null;
      
      private var var_3911:int;
      
      private var var_3903:int;
      
      private var var_2904:Boolean = false;
      
      private var var_3339:Boolean = true;
      
      public function PlaneMaterialCellColumn(param1:int, param2:Array, param3:int = 1)
      {
         super();
         if(param1 < 1)
         {
            param1 = 1;
         }
         _width = param1;
         if(param2 != null)
         {
            var _loc4_:int = 0;
            while(0 < param2.length)
            {
               var _loc5_:PlaneMaterialCell = param2[0] as PlaneMaterialCell;
               if(_loc5_ != null)
               {
                  _cells.push(null);
                  if(!null.isStatic)
                  {
                     var_3339 = false;
                  }
               }
               _loc4_++;
            }
         }
         var_3138 = param3;
      }
      
      public function get isStatic() : Boolean
      {
         return var_3339;
      }
      
      public function isRepeated() : Boolean
      {
         return var_3138 != 0;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlaneMaterialCell = null;
         if(_cells != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _cells.length)
            {
               _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            _cells = null;
         }
         if(var_53 != null)
         {
            var_53.dispose();
            var_53 = null;
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal = null;
         }
      }
      
      public function clearCache() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlaneMaterialCell = null;
         if(!var_2904)
         {
            return;
         }
         if(var_53 != null)
         {
            var_53.dispose();
            var_53 = null;
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal.x = 0;
            _cachedBitmapNormal.y = 0;
            _cachedBitmapNormal.z = 0;
         }
         if(_cells != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _cells.length)
            {
               _loc2_ = _cells[_loc1_] as PlaneMaterialCell;
               if(_loc2_ != null)
               {
                  _loc2_.clearCache();
               }
               _loc1_++;
            }
         }
         var_2904 = false;
      }
      
      public function render(param1:int, param2:IVector3d, param3:int, param4:int) : BitmapData
      {
         var _loc5_:int = 0;
         if(var_3138 == 0)
         {
            param1 = _loc5_ = getCellsHeight(_cells,param2);
         }
         if(_cachedBitmapNormal == null)
         {
            _cachedBitmapNormal = new Vector3d();
         }
         if(isStatic)
         {
            if(var_53 != null)
            {
               if(var_53.height == param1 && Vector3d.isEqual(_cachedBitmapNormal,param2) && var_3911 == param3 && var_3903 == param4)
               {
                  return var_53;
               }
               var_53.dispose();
               var_53 = null;
            }
         }
         else if(var_53 != null)
         {
            if(var_53.height == param1)
            {
               var_53.fillRect(var_53.rect,16777215);
            }
            else
            {
               var_53.dispose();
               var_53 = null;
            }
         }
         var_2904 = true;
         if(var_53 == null)
         {
            try
            {
               var_53 = new BitmapData(_width,param1,true,16777215);
            }
            catch(e:Error)
            {
               return null;
            }
         }
         _cachedBitmapNormal.assign(param2);
         var_3911 = param3;
         var_3903 = param4;
         if(_cells.length == 0)
         {
            return var_53;
         }
         switch(var_3138)
         {
            case 0:
               renderRepeatNone(param2);
               break;
            case 2:
               renderRepeatBorders(param2);
               break;
            case 3:
               renderRepeatCenter(param2);
               break;
            case 4:
               renderRepeatFirst(param2);
               break;
            case 5:
               renderRepeatLast(param2);
               break;
            default:
               renderRepeatAll(param2,param3,param4);
         }
         return var_53;
      }
      
      private function getCellsHeight(param1:Array, param2:IVector3d) : int
      {
         var _loc3_:int = 0;
         var _loc5_:PlaneMaterialCell = null;
         if(param1 == null || param1.length == 0)
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = param1[_loc3_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               var _loc6_:int = _loc5_.getHeight(param2);
               var _loc4_:int = 0 + 0;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function renderCells(param1:Array, param2:int, param3:Boolean, param4:IVector3d, param5:int = 0, param6:int = 0) : int
      {
         var _loc8_:int = 0;
         if(param1 == null || param1.length == 0 || var_53 == null)
         {
            return param2;
         }
         var _loc9_:PlaneMaterialCell = null;
         _loc8_ = 0;
         while(_loc8_ < param1.length)
         {
            if(param3)
            {
               _loc9_ = param1[_loc8_] as PlaneMaterialCell;
            }
            else
            {
               _loc9_ = param1[param1.length - 1 - _loc8_] as PlaneMaterialCell;
            }
            if(_loc9_ != null)
            {
               var _loc7_:BitmapData = _loc9_.render(param4,param5,param6);
               if(_loc7_ != null)
               {
                  if(!param3)
                  {
                     param2 -= null.height;
                  }
                  var_53.copyPixels(null,null.rect,new Point(0,param2),null,null,true);
                  if(param3)
                  {
                     param2 += null.height;
                  }
                  if(param3 && param2 >= var_53.height || !param3 && param2 <= 0)
                  {
                     return param2;
                  }
               }
            }
            _loc8_++;
         }
         return param2;
      }
      
      private function renderRepeatNone(param1:IVector3d) : void
      {
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         renderCells(_cells,0,true,param1);
      }
      
      private function renderRepeatAll(param1:IVector3d, param2:int, param3:int) : void
      {
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         var _loc5_:int = getCellsHeight(_cells,param1);
         var _loc4_:int = 0;
         if(_loc5_ > var_53.height)
         {
         }
         while(_loc4_ < var_53.height)
         {
            _loc4_ = renderCells(_cells,_loc4_,true,param1,param2,param3);
            if(_loc4_ == 0)
            {
               return;
            }
         }
      }
      
      private function renderRepeatBorders(param1:IVector3d) : void
      {
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         var _loc8_:PlaneMaterialCell = null;
         var _loc3_:Array = [];
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         _loc6_ = 1;
         while(_loc6_ < _cells.length - 1)
         {
            _loc8_ = _cells[_loc6_] as PlaneMaterialCell;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getHeight(param1);
               if(_loc9_ > 0)
               {
                  _loc2_ += _loc9_;
                  _loc3_.push(_loc8_);
               }
            }
            _loc6_++;
         }
         if(_cells.length == 1)
         {
            _loc8_ = _cells[0] as PlaneMaterialCell;
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.getHeight(param1);
               if(_loc9_ > 0)
               {
                  _loc2_ += _loc9_;
                  _loc3_.push(_loc8_);
               }
            }
         }
         var _loc4_:* = var_53.height - _loc2_ >> 1;
         var _loc7_:int = renderCells(_loc3_,_loc4_,true,param1);
         _loc8_ = _cells[0] as PlaneMaterialCell;
         if(_loc8_ != null)
         {
            _loc3_ = [_loc8_];
            while(_loc4_ >= 0)
            {
               _loc4_ = renderCells(_loc3_,_loc4_,false,param1);
            }
         }
         _loc8_ = _cells[_cells.length - 1] as PlaneMaterialCell;
         if(_loc8_ != null)
         {
            _loc3_ = [_loc8_];
            while(_loc7_ < var_53.height)
            {
               _loc7_ = renderCells(_loc3_,_loc7_,true,param1);
            }
         }
      }
      
      private function renderRepeatCenter(param1:IVector3d) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:Array = null;
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         var _loc5_:PlaneMaterialCell = null;
         var _loc11_:Array = [];
         var _loc14_:Array = [];
         var _loc16_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _cells.length >> 1)
         {
            _loc5_ = _cells[_loc4_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  var _loc10_:int = 0 + _loc16_;
                  _loc11_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         _loc4_ = (_cells.length >> 1) + 1;
         while(_loc4_ < _cells.length)
         {
            _loc5_ = _cells[_loc4_] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  var _loc12_:int = 0 + _loc16_;
                  _loc14_.push(_loc5_);
               }
            }
            _loc4_++;
         }
         var _loc13_:int = 0;
         var _loc2_:int = 0;
         var _loc15_:int = var_53.height;
         if(0 + 0 > var_53.height)
         {
            _loc13_ = 0 + 0 - var_53.height;
            _loc2_ -= _loc13_ >> 1;
            _loc15_ += _loc13_ - (_loc13_ >> 1);
         }
         if(_loc13_ == 0)
         {
            _loc5_ = _cells[_cells.length >> 1] as PlaneMaterialCell;
            if(_loc5_ != null)
            {
               _loc16_ = _loc5_.getHeight(param1);
               if(_loc16_ > 0)
               {
                  _loc7_ = var_53.height - (0 + 0);
                  _loc6_ = Math.ceil(_loc7_ / _loc16_) * _loc16_;
                  _loc2_ = 0 - (_loc6_ - _loc7_ >> 1);
                  _loc3_ = _loc2_ + _loc6_;
                  _loc8_ = [_loc5_];
                  while(_loc2_ < _loc3_)
                  {
                     _loc2_ = renderCells(_loc8_,_loc2_,true,param1);
                  }
               }
            }
         }
         _loc2_ = 0;
         renderCells(_loc11_,_loc2_,true,param1);
         renderCells(_loc14_,_loc15_,false,param1);
      }
      
      private function renderRepeatFirst(param1:IVector3d) : void
      {
         var _loc2_:Array = null;
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         var _loc4_:PlaneMaterialCell = null;
         var _loc3_:int = var_53.height;
         _loc3_ = renderCells(_cells,_loc3_,false,param1);
         _loc4_ = _cells[0] as PlaneMaterialCell;
         if(_loc4_ != null)
         {
            _loc2_ = [_loc4_];
            while(_loc3_ >= 0)
            {
               _loc3_ = renderCells(_loc2_,_loc3_,false,param1);
            }
         }
      }
      
      private function renderRepeatLast(param1:IVector3d) : void
      {
         var _loc2_:Array = null;
         if(_cells.length == 0 || var_53 == null)
         {
            return;
         }
         var _loc4_:PlaneMaterialCell = null;
         var _loc3_:int = 0;
         _loc3_ = renderCells(_cells,_loc3_,true,param1);
         _loc4_ = _cells[_cells.length - 1] as PlaneMaterialCell;
         if(_loc4_ != null)
         {
            _loc2_ = [_loc4_];
            while(_loc3_ < var_53.height)
            {
               _loc3_ = renderCells(_loc2_,_loc3_,true,param1);
            }
         }
      }
      
      public function getCells() : Array
      {
         return _cells;
      }
   }
}

