package com.sulake.core.window.utils
{
   import com.sulake.core.window.class_1741;
   
   public class WindowRectLimits implements IRectLimiter
   {
      
      private var _minWidth:int = -2147483648;
      
      private var _maxWidth:int = 2147483647;
      
      private var var_515:int = -2147483648;
      
      private var var_531:int = 2147483647;
      
      private var var_202:class_1741;
      
      public function WindowRectLimits(param1:class_1741)
      {
         super();
         var_202 = param1;
      }
      
      public function get minWidth() : int
      {
         return _minWidth;
      }
      
      public function get maxWidth() : int
      {
         return _maxWidth;
      }
      
      public function get minHeight() : int
      {
         return var_515;
      }
      
      public function get maxHeight() : int
      {
         return var_531;
      }
      
      public function set minWidth(param1:int) : void
      {
         _minWidth = param1;
         if(_minWidth > -2147483648 && !var_202.disposed && var_202.width < _minWidth)
         {
            var_202.width = _minWidth;
         }
      }
      
      public function set maxWidth(param1:int) : void
      {
         _maxWidth = param1;
         if(_maxWidth < 2147483647 && !var_202.disposed && var_202.width > _maxWidth)
         {
            var_202.width = _maxWidth;
         }
      }
      
      public function set minHeight(param1:int) : void
      {
         var_515 = param1;
         if(var_515 > -2147483648 && !var_202.disposed && var_202.height < var_515)
         {
            var_202.height = var_515;
         }
      }
      
      public function set maxHeight(param1:int) : void
      {
         var_531 = param1;
         if(var_531 < 2147483647 && !var_202.disposed && var_202.height > var_531)
         {
            var_202.height = var_531;
         }
      }
      
      public function get isEmpty() : Boolean
      {
         return _minWidth == -2147483648 && _maxWidth == 2147483647 && var_515 == -2147483648 && var_531 == 2147483647;
      }
      
      public function setEmpty() : void
      {
         _minWidth = -2147483648;
         _maxWidth = 2147483647;
         var_515 = -2147483648;
         var_531 = 2147483647;
      }
      
      public function limit() : void
      {
         if(!isEmpty && var_202)
         {
            if(var_202.width < _minWidth)
            {
               var_202.width = _minWidth;
            }
            else if(var_202.width > _maxWidth)
            {
               var_202.width = _maxWidth;
            }
            if(var_202.height < var_515)
            {
               var_202.height = var_515;
            }
            else if(var_202.height > var_531)
            {
               var_202.height = var_531;
            }
         }
      }
      
      public function assign(param1:int, param2:int, param3:int, param4:int) : void
      {
         _minWidth = param1;
         _maxWidth = param2;
         var_515 = param3;
         var_531 = param4;
         limit();
      }
      
      public function clone(param1:class_1741) : WindowRectLimits
      {
         var _loc2_:WindowRectLimits = new WindowRectLimits(param1);
         _loc2_._minWidth = _minWidth;
         _loc2_._maxWidth = _maxWidth;
         _loc2_.var_515 = var_515;
         _loc2_.var_531 = var_531;
         return _loc2_;
      }
   }
}

