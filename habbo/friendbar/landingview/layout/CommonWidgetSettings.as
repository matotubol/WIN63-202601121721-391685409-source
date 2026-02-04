package com.sulake.habbo.friendbar.landingview.layout
{
   import com.sulake.core.runtime.class_16;
   
   public class CommonWidgetSettings
   {
      
      private static const TEXTCOLOR_DEFAULT:uint = 4278190080;
      
      private static const ETCHINGCOLOR_DEFAULT:uint = 4294967295;
      
      private static const ETCHINGPOSITION_DEFAULT:String = "bottom";
      
      private static const const_449:String = "landing.view.common.textcolor";
      
      private static const ETCHINGCOLOR_CONFIGURATION_KEY:String = "landing.view.common.etchingcolor";
      
      private static const ETCHINGPOSITION_CONFIGURATION_KEY:String = "landing.view.common.etchingposition";
      
      private var _textColor:uint = 4278190080;
      
      private var _etchingColor:uint = 4294967295;
      
      private var var_3040:String = "bottom";
      
      public function CommonWidgetSettings(param1:class_16)
      {
         super();
         if(param1.getProperty("landing.view.common.textcolor") != "")
         {
            _textColor = parseInt(param1.getProperty("landing.view.common.textcolor"),16);
         }
         if(param1.getProperty("landing.view.common.etchingcolor") != "")
         {
            _etchingColor = parseInt(param1.getProperty("landing.view.common.etchingcolor"),16);
         }
         if(param1.getProperty("landing.view.common.etchingposition") != "")
         {
            var_3040 = param1.getProperty("landing.view.common.etchingposition");
         }
      }
      
      public function get isTextColorSet() : Boolean
      {
         return _textColor != 4278190080;
      }
      
      public function get isEtchingColorSet() : Boolean
      {
         return _etchingColor != 4294967295;
      }
      
      public function get isEtchingPositionSet() : Boolean
      {
         return var_3040 != "bottom";
      }
      
      public function get textColor() : uint
      {
         return _textColor;
      }
      
      public function get etchingColor() : uint
      {
         return _etchingColor;
      }
      
      public function get etchingPosition() : String
      {
         return var_3040;
      }
   }
}

