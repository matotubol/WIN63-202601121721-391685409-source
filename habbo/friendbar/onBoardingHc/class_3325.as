package com.sulake.habbo.friendbar.onBoardingHc
{
   import com.sulake.habbo.communication.class_57;
   import onBoardingHcUi.IUIContext;
   
   public interface class_3325 extends IUIContext
   {
      
      function getLocalization(param1:String, param2:String = null) : String;
      
      function getProperty(param1:String, param2:String = null) : String;
      
      function nameChangeCompleted(param1:Boolean = true) : void;
      
      function showHideButtons(param1:Boolean) : void;
      
      function setNameGender(param1:String, param2:Boolean) : void;
      
      function editorFinished() : void;
      
      function get communicationManager() : class_57;
   }
}

