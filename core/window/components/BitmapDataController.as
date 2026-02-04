package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.enum.PivotPoint;
   import com.sulake.core.window.theme.class_2458;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataController extends WindowController implements class_2201
   {
      
      protected var _bitmapData:BitmapData;
      
      protected var var_1605:uint;
      
      protected var var_1645:Boolean;
      
      protected var var_1673:Boolean;
      
      protected var var_1402:Number;
      
      protected var var_1405:Number;
      
      protected var var_2428:Boolean;
      
      protected var _etchingColor:uint;
      
      protected var _etchingPoint:Point = new Point(0,-1);
      
      protected var var_2820:Boolean;
      
      private var var_1544:Boolean;
      
      private var var_1663:Boolean;
      
      private var var_207:Number;
      
      public function BitmapDataController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:class_2458 = param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3);
         var_1605 = PivotPoint.pivotFromName(String(_loc12_.method_20("pivot_point").value));
         var_1645 = Boolean(_loc12_.method_20("stretched_x").value);
         var_1673 = Boolean(_loc12_.method_20("stretched_y").value);
         var_1402 = Number(_loc12_.method_20("zoom_x").value);
         var_1405 = Number(_loc12_.method_20("zoom_y").value);
         var_1544 = Boolean(_loc12_.method_20("wrap_x").value);
         var_1663 = Boolean(_loc12_.method_20("wrap_y").value);
         var_207 = Number(_loc12_.method_20("rotation").value);
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         _bitmapData = null;
         super.dispose();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get pivotPoint() : uint
      {
         return var_1605;
      }
      
      public function set pivotPoint(param1:uint) : void
      {
         var_1605 = param1;
      }
      
      public function get stretchedX() : Boolean
      {
         return var_1645;
      }
      
      public function set stretchedX(param1:Boolean) : void
      {
         var_1645 = param1;
      }
      
      public function get stretchedY() : Boolean
      {
         return var_1673;
      }
      
      public function set stretchedY(param1:Boolean) : void
      {
         var_1673 = param1;
      }
      
      public function get zoomX() : Number
      {
         return var_1402;
      }
      
      public function set zoomX(param1:Number) : void
      {
         var_1402 = param1;
         fitSize();
      }
      
      public function get zoomY() : Number
      {
         return var_1405;
      }
      
      public function set zoomY(param1:Number) : void
      {
         var_1405 = param1;
         fitSize();
      }
      
      public function get greyscale() : Boolean
      {
         return var_2428;
      }
      
      public function set greyscale(param1:Boolean) : void
      {
         var_2428 = param1;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function set etchingColor(param1:uint) : void
      {
         _etchingColor = param1;
      }
      
      public function get fitSizeToContents() : Boolean
      {
         return var_2820;
      }
      
      public function set fitSizeToContents(param1:Boolean) : void
      {
         var_2820 = param1;
         fitSize();
      }
      
      override public function get etchingPoint() : Point
      {
         return _etchingPoint;
      }
      
      override public function set etching(param1:Array) : void
      {
         etchingColor = param1[0];
         _etchingPoint = new Point(param1[1],param1[2]);
      }
      
      public function get wrapX() : Boolean
      {
         return var_1544;
      }
      
      public function set wrapX(param1:Boolean) : void
      {
         var_1544 = param1;
      }
      
      public function get wrapY() : Boolean
      {
         return var_1663;
      }
      
      public function set wrapY(param1:Boolean) : void
      {
         var_1663 = param1;
      }
      
      public function get rotation() : Number
      {
         return var_207;
      }
      
      public function set rotation(param1:Number) : void
      {
         var_207 = param1;
      }
      
      protected function fitSize() : void
      {
         if(var_2820 && _bitmapData != null)
         {
            width = Math.abs(_bitmapData.width * var_1402);
            height = Math.abs(_bitmapData.height * var_1405);
         }
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("pivot_point",PivotPoint.PIVOT_NAMES[var_1605]));
         _loc1_.push(createProperty("stretched_x",var_1645));
         _loc1_.push(createProperty("stretched_y",var_1673));
         _loc1_.push(createProperty("wrap_x",var_1544));
         _loc1_.push(createProperty("wrap_y",var_1663));
         _loc1_.push(createProperty("zoom_x",var_1402));
         _loc1_.push(createProperty("zoom_y",var_1405));
         _loc1_.push(createProperty("greyscale",var_2428));
         _loc1_.push(createProperty("etching_color",_etchingColor));
         _loc1_.push(createProperty("fit_size_to_contents",var_2820));
         _loc1_.push(createProperty("rotation",var_207));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pivot_point":
                  var_1605 = PivotPoint.pivotFromName(String(_loc2_.value));
                  break;
               case "stretched_x":
                  var_1645 = Boolean(_loc2_.value);
                  break;
               case "stretched_y":
                  var_1673 = Boolean(_loc2_.value);
                  break;
               case "zoom_x":
                  var_1402 = Number(_loc2_.value);
                  break;
               case "zoom_y":
                  var_1405 = Number(_loc2_.value);
                  break;
               case "wrap_x":
                  var_1544 = Boolean(_loc2_.value);
                  break;
               case "wrap_y":
                  var_1663 = Boolean(_loc2_.value);
                  break;
               case "greyscale":
                  var_2428 = Boolean(_loc2_.value);
                  break;
               case "etching_color":
                  _etchingColor = uint(_loc2_.value);
                  break;
               case "fit_size_to_contents":
                  fitSizeToContents = _loc2_.value as Boolean;
                  break;
               case "rotation":
                  var_207 = Number(_loc2_.value);
            }
         }
         super.properties = param1;
      }
   }
}

