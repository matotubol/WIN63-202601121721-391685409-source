package com.sulake.core.window.components
{
   import com.sulake.core.window.class_1741;
   
   public interface ISelectableWindow extends class_1741
   {
      
      function get selector() : ISelectorWindow;
      
      function get isSelected() : Boolean;
      
      function set isSelected(param1:Boolean) : void;
      
      function select() : Boolean;
      
      function unselect() : Boolean;
   }
}

