package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   
   public interface IInteractiveWindow extends class_1741
   {
      
      function set toolTipCaption(param1:String) : void;
      
      function get toolTipCaption() : String;
      
      function set toolTipDelay(param1:uint) : void;
      
      function get toolTipDelay() : uint;
      
      function set toolTipIsDynamic(param1:Boolean) : void;
      
      function get toolTipIsDynamic() : Boolean;
      
      function get interactiveCursorDisabled() : Boolean;
      
      function set interactiveCursorDisabled(param1:Boolean) : void;
      
      function showToolTip(param1:IToolTipWindow) : void;
      
      function hideToolTip() : void;
      
      function setMouseCursorForState(param1:uint, param2:uint) : uint;
      
      function getMouseCursorByState(param1:uint) : uint;
   }
}

