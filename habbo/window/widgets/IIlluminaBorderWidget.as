package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.class_1901;
   
   public interface IIlluminaBorderWidget extends class_1901
   {
      
      function get borderStyle() : String;
      
      function set borderStyle(param1:String) : void;
      
      function get contentChild() : String;
      
      function set contentChild(param1:String) : void;
      
      function get contentPadding() : uint;
      
      function set contentPadding(param1:uint) : void;
      
      function get sidePadding() : uint;
      
      function set sidePadding(param1:uint) : void;
      
      function get childMargin() : uint;
      
      function set childMargin(param1:uint) : void;
      
      function get topLeftChild() : String;
      
      function set topLeftChild(param1:String) : void;
      
      function get topCenterChild() : String;
      
      function set topCenterChild(param1:String) : void;
      
      function get topRightChild() : String;
      
      function set topRightChild(param1:String) : void;
      
      function get bottomLeftChild() : String;
      
      function set bottomLeftChild(param1:String) : void;
      
      function get bottomCenterChild() : String;
      
      function set bottomCenterChild(param1:String) : void;
      
      function get bottomRightChild() : String;
      
      function set bottomRightChild(param1:String) : void;
      
      function get landingViewMode() : Boolean;
      
      function set landingViewMode(param1:Boolean) : void;
   }
}

