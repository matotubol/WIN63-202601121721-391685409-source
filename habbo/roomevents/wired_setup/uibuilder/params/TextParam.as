package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class TextParam
   {
      
      public static const NO_COLOR_OVERRIDE:uint = 0;
      
      public static const MODE_STRETCH:int = 0;
      
      public static const MODE_MULTILINE:int = 1;
      
      public static const MODE_OVERFLOW:int = 2;
      
      public static const DEFAULT:TextParam = new TextParam(1,false);
      
      private var var_261:int;
      
      private var var_4700:Boolean;
      
      private var var_4058:int;
      
      private var var_4793:Boolean;
      
      private var var_2733:String;
      
      private var var_4824:int = -1;
      
      private var _textColor:uint = 0;
      
      public function TextParam(param1:int, param2:Boolean = false, param3:int = 0, param4:Boolean = false, param5:String = null)
      {
         super();
         var_261 = param1;
         var_4700 = param2;
         var_4058 = param3;
         var_4793 = param4;
         var_2733 = param5;
      }
      
      public function get mode() : int
      {
         return var_261;
      }
      
      public function get bold() : Boolean
      {
         return var_4700;
      }
      
      public function get maxLines() : int
      {
         return var_4058;
      }
      
      public function get underline() : Boolean
      {
         return var_4793;
      }
      
      public function get alignment() : String
      {
         return var_2733;
      }
      
      public function get fontSize() : int
      {
         return var_4824;
      }
      
      public function set fontSize(param1:int) : void
      {
         var_4824 = param1;
      }
      
      public function get textColor() : uint
      {
         return _textColor;
      }
      
      public function set textColor(param1:uint) : void
      {
         _textColor = param1;
      }
   }
}

