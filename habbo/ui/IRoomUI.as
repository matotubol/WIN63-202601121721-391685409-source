package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.habbo.session.IRoomSession;
   import flash.events.MouseEvent;
   
   public interface IRoomUI extends IUnknown
   {
      
      function createDesktop(param1:IRoomSession) : IRoomDesktop;
      
      function get chatContainer() : class_1970;
      
      function disposeDesktop() : void;
      
      function get desktop() : IRoomDesktop;
      
      function getActiveCanvasId(param1:int) : int;
      
      function set visible(param1:Boolean) : void;
      
      function hideWidget(param1:String) : void;
      
      function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void;
      
      function mouseEventPositionHasContextMenu(param1:MouseEvent) : Boolean;
      
      function triggerbottomBarResize() : void;
   }
}

