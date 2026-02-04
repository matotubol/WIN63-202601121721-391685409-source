package com.sulake.habbo.avatar.structure.figure
{
   import flash.geom.ColorTransform;
   
   public class PartColor implements IPartColor
   {
      
      private var var_197:int;
      
      private var _index:int;
      
      private var var_2971:int;
      
      private var var_4896:Boolean = false;
      
      private var var_2398:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var var_3753:Number;
      
      private var var_3780:Number;
      
      private var var_3460:Number;
      
      private var var_859:ColorTransform;
      
      public function PartColor(param1:XML)
      {
         super();
         var_197 = parseInt(param1.@id);
         _index = parseInt(param1.@index);
         var_2971 = parseInt(param1.@club);
         var_4896 = Boolean(parseInt(param1.@selectable));
         var _loc2_:String = param1.text();
         var_2398 = parseInt(_loc2_,16);
         _r = var_2398 >> 16 & 0xFF;
         _g = var_2398 >> 8 & 0xFF;
         _b = var_2398 >> 0 & 0xFF;
         var_3753 = _r / 255 * 1;
         var_3780 = _g / 255 * 1;
         var_3460 = _b / 255 * 1;
         var_859 = new ColorTransform(var_3753,var_3780,var_3460);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return var_859;
      }
      
      public function get redMultiplier() : Number
      {
         return var_3753;
      }
      
      public function get greenMultiplier() : Number
      {
         return var_3780;
      }
      
      public function get blueMultiplier() : Number
      {
         return var_3460;
      }
      
      public function get rgb() : uint
      {
         return var_2398;
      }
      
      public function get r() : uint
      {
         return _r;
      }
      
      public function get g() : uint
      {
         return _g;
      }
      
      public function get b() : uint
      {
         return _b;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_4896;
      }
   }
}

