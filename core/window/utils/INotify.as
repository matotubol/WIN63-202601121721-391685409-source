package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.class_13;
   
   public interface INotify extends class_13
   {
      
      function set title(param1:String) : void;
      
      function get title() : String;
      
      function set summary(param1:String) : void;
      
      function get summary() : String;
      
      function set callback(param1:Function) : void;
      
      function get callback() : Function;
   }
}

