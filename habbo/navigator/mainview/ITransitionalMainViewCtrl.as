package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.window.components.class_2250;
   import com.sulake.habbo.navigator.TextSearchInputs;
   import flash.geom.Point;
   
   public interface ITransitionalMainViewCtrl
   {
      
      function get disposed() : Boolean;
      
      function onNavigatorToolBarIconClick() : void;
      
      function dispose() : void;
      
      function open() : void;
      
      function isOpen() : Boolean;
      
      function close() : void;
      
      function get mainWindow() : class_2250;
      
      function refresh() : void;
      
      function reloadRoomList(param1:int) : Boolean;
      
      function startSearch(param1:int, param2:int, param3:String = "-1", param4:int = 1) : void;
      
      function update(param1:uint) : void;
      
      function get searchInput() : TextSearchInputs;
      
      function openAtPosition(param1:Point) : void;
      
      function get isPhaseOneNavigator() : Boolean;
   }
}

