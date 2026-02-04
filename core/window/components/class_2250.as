package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.utils.IMargins;
   
   public interface class_2250 extends class_1812
   {
      
      function get title() : ILabelWindow;
      
      function get header() : class_2211;
      
      function get content() : class_1812;
      
      function get margins() : IMargins;
      
      function get scaler() : IScalerWindow;
      
      function resizeToFitContent() : void;
      
      function set helpButtonAction(param1:Function) : void;
      
      function get helpPage() : String;
      
      function set helpPage(param1:String) : void;
      
      function get menuButton() : class_2483;
      
      function get menuButtonVisible() : Boolean;
      
      function set menuButtonVisible(param1:Boolean) : *;
   }
}

