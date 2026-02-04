package com.sulake.core.window
{
   import com.sulake.core.runtime.class_13;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowModel implements class_13
   {
      
      private static var POINT_ZERO:Point = new Point(0,0);
      
      protected var _offsetX:int;
      
      protected var _offsetY:int;
      
      protected var var_25:int;
      
      protected var var_26:int;
      
      protected var var_29:int;
      
      protected var var_32:int;
      
      protected var var_499:Rectangle;
      
      protected var var_63:Rectangle;
      
      protected var var_314:Rectangle;
      
      protected var var_301:Rectangle;
      
      protected var _context:WindowContext;
      
      protected var _background:Boolean = false;
      
      protected var _fillColor:uint = 16777215;
      
      protected var var_3802:ColorTransform;
      
      protected var _alphaColor:uint;
      
      protected var var_1205:uint = 10;
      
      protected var _ignoreMouseEvents:Boolean = false;
      
      protected var var_2044:Boolean = true;
      
      protected var var_588:Boolean = true;
      
      protected var var_916:Number = 1;
      
      protected var var_44:uint;
      
      protected var var_61:uint;
      
      protected var _style:uint;
      
      protected var var_230:uint;
      
      protected var _caption:String = "";
      
      protected var _name:String;
      
      protected var var_197:uint;
      
      protected var var_553:Array;
      
      protected var _disposed:Boolean = false;
      
      protected var var_1431:String = "";
      
      public function WindowModel(param1:uint, param2:String, param3:uint, param4:uint, param5:uint, param6:WindowContext, param7:Rectangle, param8:Array = null, param9:String = "")
      {
         super();
         var_197 = param1;
         _name = param2;
         var_230 = param3;
         var_44 = param5;
         var_61 = 0;
         _style = param4;
         var_553 = param8;
         _context = param6;
         var_1431 = param9;
         var_25 = param7.x;
         var_26 = param7.y;
         var_29 = param7.width;
         var_32 = param7.height;
         var_499 = param7.clone();
         var_63 = param7.clone();
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get width() : int
      {
         return var_29;
      }
      
      public function get height() : int
      {
         return var_32;
      }
      
      public function get position() : Point
      {
         return new Point(var_25,var_26);
      }
      
      public function get rectangle() : Rectangle
      {
         return new Rectangle(var_25,var_26,var_29,var_32);
      }
      
      public function get context() : class_1892
      {
         return _context;
      }
      
      public function get mouseThreshold() : uint
      {
         return var_1205;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get background() : Boolean
      {
         return _background;
      }
      
      public function get clipping() : Boolean
      {
         return var_2044;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function get color() : uint
      {
         return _fillColor;
      }
      
      public function get alpha() : uint
      {
         return _alphaColor >>> 24;
      }
      
      public function get blend() : Number
      {
         return var_916;
      }
      
      public function get param() : uint
      {
         return var_44;
      }
      
      public function get state() : uint
      {
         return var_61;
      }
      
      public function get style() : uint
      {
         return _style;
      }
      
      public function get type() : uint
      {
         return var_230;
      }
      
      public function get caption() : String
      {
         return _caption;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get tags() : Array
      {
         return var_553 ? var_553 : (var_553 = []);
      }
      
      public function get left() : int
      {
         return var_25;
      }
      
      public function get top() : int
      {
         return var_26;
      }
      
      public function get right() : int
      {
         return var_25 + var_29;
      }
      
      public function get bottom() : int
      {
         return var_26 + var_32;
      }
      
      public function get renderingX() : int
      {
         return _offsetX + var_25;
      }
      
      public function get renderingY() : int
      {
         return _offsetY + var_26;
      }
      
      public function get renderingWidth() : int
      {
         return var_29 + Math.abs(etchingPoint.x);
      }
      
      public function get renderingHeight() : int
      {
         return var_32 + Math.abs(etchingPoint.y);
      }
      
      public function get renderingRectangle() : Rectangle
      {
         return new Rectangle(renderingX,renderingY,renderingWidth,renderingHeight);
      }
      
      public function get etchingPoint() : Point
      {
         return POINT_ZERO;
      }
      
      public function get dynamicStyle() : String
      {
         return var_1431;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            _context = null;
            var_61 = 1073741824;
            var_553 = null;
            var_25 = var_26 = var_29 = var_32 = 0;
         }
      }
      
      public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      public function getInitialWidth() : int
      {
         return var_499.width;
      }
      
      public function getInitialHeight() : int
      {
         return var_499.height;
      }
      
      public function getPreviousWidth() : int
      {
         return var_63.width;
      }
      
      public function getPreviousHeight() : int
      {
         return var_63.height;
      }
      
      public function getMinimizedWidth() : int
      {
         return var_314 ? var_314.width : 0;
      }
      
      public function getMinimizedHeight() : int
      {
         return var_314 ? var_314.height : 0;
      }
      
      public function getMaximizedWidth() : int
      {
         return var_301 ? var_301.width : 2147483647;
      }
      
      public function getMaximizedHeight() : int
      {
         return var_301 ? var_301.height : 2147483647;
      }
      
      public function testTypeFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_230 & param2 ^ param1) == 0;
         }
         return (var_230 & param1) == param1;
      }
      
      public function testStateFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_61 & param2 ^ param1) == 0;
         }
         return (var_61 & param1) == param1;
      }
      
      public function testStyleFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (_style & param2 ^ param1) == 0;
         }
         return (_style & param1) == param1;
      }
      
      public function testParamFlag(param1:uint, param2:uint = 0) : Boolean
      {
         if(param2 > 0)
         {
            return (var_44 & param2 ^ param1) == 0;
         }
         return (var_44 & param1) == param1;
      }
   }
}

