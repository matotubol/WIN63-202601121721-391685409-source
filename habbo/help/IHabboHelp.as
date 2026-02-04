package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IUnknown;
   import flash.events.IEventDispatcher;
   
   public interface IHabboHelp extends IUnknown
   {
      
      function requestGuide() : void;
      
      function get events() : IEventDispatcher;
      
      function reportBully(param1:int) : void;
      
      function startPhotoReportingInNewCfhFlow(param1:int, param2:String, param3:String, param4:int) : void;
      
      function reportUser(param1:int, param2:int, param3:String) : void;
      
      function reportUserName(param1:int, param2:String) : void;
      
      function reportUserFromIM(param1:int) : void;
      
      function reportRoom(param1:int, param2:String, param3:String) : void;
      
      function reportThread(param1:int, param2:int) : void;
      
      function reportMessage(param1:int, param2:int, param3:int) : void;
      
      function reportSelfie(param1:String, param2:String, param3:int, param4:int, param5:int) : Boolean;
      
      function reportPhoto(param1:String, param2:int, param3:int, param4:int, param5:int) : Boolean;
      
      function startNameChange() : void;
      
      function showWelcomeScreen(param1:String, param2:String, param3:int, param4:String = null) : void;
      
      function set outsideRoom(param1:Boolean) : void;
      
      function showHabboWay() : void;
      
      function showSafetyBooklet() : void;
      
      function showTourPopup() : void;
   }
}

