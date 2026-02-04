package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.habbo.help.IHabboHelp;
   
   public interface IHabboNewNavigator extends IUnknown
   {
      
      function open() : void;
      
      function performSearch(param1:String, param2:String = "", param3:String = "") : void;
      
      function performTagSearch(param1:String) : void;
      
      function goToRoom(param1:int, param2:String = "mainview") : void;
      
      function get isReady() : Boolean;
      
      function get legacyNavigator() : class_41;
      
      function get habboHelp() : IHabboHelp;
   }
}

