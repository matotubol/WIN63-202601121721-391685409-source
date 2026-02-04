package com.sulake.habbo.utils
{
   import com.sulake.core.window.components.ITextWindow;
   import flash.text.StyleSheet;
   
   public class TextWindowUtils
   {
      
      public function TextWindowUtils()
      {
         super();
      }
      
      public static function setHTMLLinkStyle(param1:ITextWindow, param2:uint, param3:uint, param4:uint, param5:Boolean = true) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc10_:StyleSheet = new StyleSheet();
         var _loc6_:Object = {};
         _loc6_.color = toHexString(param2);
         var _loc7_:Object = {};
         if(param5)
         {
            _loc7_.textDecoration = "underline";
         }
         _loc7_.color = toHexString(param3);
         var _loc9_:Object = {};
         _loc9_.color = toHexString(param4);
         var _loc8_:Object = {};
         _loc8_.textDecoration = "underline";
         _loc10_.setStyle("a:link",_loc7_);
         _loc10_.setStyle("a:hover",_loc6_);
         _loc10_.setStyle("a:active",_loc9_);
         _loc10_.setStyle(".visited",_loc8_);
         param1.styleSheet = _loc10_;
      }
      
      public static function toHexString(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         while(_loc2_.length < 6)
         {
            _loc2_ = "0" + _loc2_;
         }
         return "#" + _loc2_;
      }
   }
}

