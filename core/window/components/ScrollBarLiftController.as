package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   
   public class ScrollBarLiftController extends InteractiveController implements class_2178
   {
      
      protected var var_2706:Number = 0;
      
      protected var var_3370:Number = 0;
      
      protected var _scrollBar:ScrollBarController;
      
      public function ScrollBarLiftController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 32;
         param4 = uint(param4 | 0x8000);
         param4 = uint(param4 | 0x0101);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         var _loc12_:class_1741 = param7;
         while(_loc12_ != null)
         {
            if(_loc12_ is IScrollbarWindow)
            {
               _scrollBar = ScrollBarController(_loc12_);
               _loc12_ = null;
            }
            else
            {
               _loc12_ = _loc12_.parent;
            }
         }
         if(_scrollBar.horizontal)
         {
            limits.minWidth = width;
         }
         else
         {
            limits.minHeight = height;
         }
      }
      
      public function get scrollbarOffsetX() : Number
      {
         return var_2706;
      }
      
      public function get scrollbarOffsetY() : Number
      {
         return var_3370;
      }
      
      public function set scrollbarOffsetX(param1:Number) : void
      {
      }
      
      public function set scrollbarOffsetY(param1:Number) : void
      {
      }
      
      override public function offset(param1:Number, param2:Number) : void
      {
         super.offset(param1,param2);
         var_2706 = this.x != 0 ? this.x / (_parent.width - width) : 0;
         var_3370 = this.y != 0 ? this.y / (_parent.height - height) : 0;
         if(_parent != _scrollBar)
         {
            var _loc3_:class_1758 = class_1758.allocate("WE_CHILD_RELOCATED",this,null);
            _scrollBar.update(this,null);
            null.recycle();
         }
      }
   }
}

